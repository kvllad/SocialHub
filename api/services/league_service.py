from datetime import date, datetime, timedelta
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func, and_, desc
from api.models.league import League, UserLeague, WeeklyLeaderboard
from api.models.coin import Coin
from api.models.user import User
from typing import Optional


class LeagueService:
    """Service for managing league system"""

    @staticmethod
    def get_week_dates(target_date: Optional[date] = None) -> tuple[date, date]:
        """Get Monday and Sunday for a given date (or current week)"""
        if target_date is None:
            target_date = date.today()

        # Get Monday
        monday = target_date - timedelta(days=target_date.weekday())
        # Get Sunday
        sunday = monday + timedelta(days=6)

        return monday, sunday

    @staticmethod
    async def get_user_current_league(db: AsyncSession, user_id: int) -> Optional[UserLeague]:
        """Get user's current active league"""
        result = await db.execute(
            select(UserLeague)
            .where(UserLeague.user_id == user_id, UserLeague.is_current == True)
            .order_by(UserLeague.created_at.desc())
            .limit(1)
        )
        return result.scalar_one_or_none()

    @staticmethod
    async def initialize_user_league(db: AsyncSession, user_id: int) -> UserLeague:
        """Initialize user in Bronze league (league_id=1)"""
        monday, sunday = LeagueService.get_week_dates()

        # Get Bronze league
        result = await db.execute(select(League).where(League.level == 1))
        bronze_league = result.scalar_one()

        user_league = UserLeague(
            user_id=user_id,
            league_id=bronze_league.id,
            week_start_date=monday,
            week_end_date=sunday,
            weekly_coins=0,
            is_current=True
        )
        db.add(user_league)
        await db.commit()
        await db.refresh(user_league)

        return user_league

    @staticmethod
    async def update_user_weekly_coins(db: AsyncSession, user_id: int, coins_earned: int):
        """Update user's weekly coins when they earn coins"""
        user_league = await LeagueService.get_user_current_league(db, user_id)

        if not user_league:
            # Initialize user in Bronze league if not in any league
            user_league = await LeagueService.initialize_user_league(db, user_id)

        # Check if week has changed
        monday, sunday = LeagueService.get_week_dates()
        if user_league.week_start_date != monday:
            # New week started, archive old and create new
            user_league.is_current = False
            await db.commit()

            user_league = UserLeague(
                user_id=user_id,
                league_id=user_league.league_id,  # Keep same league for now
                week_start_date=monday,
                week_end_date=sunday,
                weekly_coins=0,
                is_current=True
            )
            db.add(user_league)

        # Add coins to weekly total
        user_league.weekly_coins += coins_earned
        await db.commit()

    @staticmethod
    async def get_league_leaderboard(
        db: AsyncSession,
        league_id: int,
        week_start: Optional[date] = None
    ) -> list[dict]:
        """Get current leaderboard for a league"""
        if week_start is None:
            week_start, _ = LeagueService.get_week_dates()

        # Get all users in this league for current week
        result = await db.execute(
            select(UserLeague, User)
            .join(User, UserLeague.user_id == User.id)
            .where(
                UserLeague.league_id == league_id,
                UserLeague.week_start_date == week_start,
                UserLeague.is_current == True
            )
            .order_by(desc(UserLeague.weekly_coins))
        )
        rows = result.all()

        leaderboard = []
        for rank, (user_league, user) in enumerate(rows, 1):
            leaderboard.append({
                "rank": rank,
                "user_id": user.id,
                "name": user.name,
                "surname": user.surname,
                "weekly_coins": user_league.weekly_coins,
                "total_participants": len(rows)
            })

        return leaderboard

    @staticmethod
    async def process_week_end(db: AsyncSession, week_start: date):
        """
        Process league promotions/demotions at week end.

        Rules:
        - Top 25% (75-100 percentile) -> promoted
        - Middle 50% (25-75 percentile) -> stay
        - Bottom 25% (0-25 percentile) -> demoted (except league 1)
        """
        # Get all leagues
        leagues_result = await db.execute(select(League).order_by(League.level))
        leagues = leagues_result.scalars().all()

        for league in leagues:
            # Get all users in this league for this week
            result = await db.execute(
                select(UserLeague)
                .where(
                    UserLeague.league_id == league.id,
                    UserLeague.week_start_date == week_start,
                    UserLeague.is_current == True
                )
                .order_by(desc(UserLeague.weekly_coins))
            )
            user_leagues = result.scalars().all()

            if not user_leagues:
                continue

            total_users = len(user_leagues)

            for idx, user_league in enumerate(user_leagues):
                rank = idx + 1
                percentile = int(((total_users - rank) / total_users) * 100)

                # Determine promotion/demotion
                promoted = None
                next_league_id = league.id

                if percentile >= 75:
                    # Top 25% - promote (if not already at top)
                    if league.level < 4:
                        promoted = True
                        next_league_result = await db.execute(
                            select(League).where(League.level == league.level + 1)
                        )
                        next_league = next_league_result.scalar_one()
                        next_league_id = next_league.id
                elif percentile < 25:
                    # Bottom 25% - demote (if not at bottom)
                    if league.level > 1:
                        promoted = False
                        prev_league_result = await db.execute(
                            select(League).where(League.level == league.level - 1)
                        )
                        prev_league = prev_league_result.scalar_one()
                        next_league_id = prev_league.id

                # Update user_league
                user_league.rank = rank
                user_league.promoted = promoted
                user_league.is_current = False

                # Create leaderboard snapshot
                snapshot = WeeklyLeaderboard(
                    user_id=user_league.user_id,
                    league_id=league.id,
                    week_start_date=user_league.week_start_date,
                    week_end_date=user_league.week_end_date,
                    weekly_coins=user_league.weekly_coins,
                    final_rank=rank,
                    total_participants=total_users,
                    percentile=percentile,
                    promoted=promoted,
                    next_league_id=next_league_id
                )
                db.add(snapshot)

                # Create new league entry for next week
                next_monday, next_sunday = LeagueService.get_week_dates(
                    user_league.week_end_date + timedelta(days=1)
                )

                new_user_league = UserLeague(
                    user_id=user_league.user_id,
                    league_id=next_league_id,
                    week_start_date=next_monday,
                    week_end_date=next_sunday,
                    weekly_coins=0,
                    is_current=True
                )
                db.add(new_user_league)

        await db.commit()

    @staticmethod
    async def get_user_league_info(db: AsyncSession, user_id: int) -> dict:
        """Get comprehensive league info for a user"""
        user_league = await LeagueService.get_user_current_league(db, user_id)

        if not user_league:
            # User not in any league yet
            return {
                "in_league": False,
                "league": None,
                "weekly_coins": 0,
                "rank": None,
                "total_participants": 0
            }

        # Get league details
        league_result = await db.execute(
            select(League).where(League.id == user_league.league_id)
        )
        league = league_result.scalar_one()

        # Get leaderboard to find rank
        leaderboard = await LeagueService.get_league_leaderboard(
            db, league.id, user_league.week_start_date
        )

        # Find user's rank
        user_rank = None
        for entry in leaderboard:
            if entry["user_id"] == user_id:
                user_rank = entry["rank"]
                break

        return {
            "in_league": True,
            "league": {
                "id": league.id,
                "level": league.level,
                "name": league.name,
                "color_emoji": league.color_emoji
            },
            "weekly_coins": user_league.weekly_coins,
            "rank": user_rank,
            "total_participants": len(leaderboard),
            "week_start": user_league.week_start_date,
            "week_end": user_league.week_end_date
        }
