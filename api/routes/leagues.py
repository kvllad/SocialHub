from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from typing import List

from api.database import get_db
from api.services.league_service import LeagueService
from api.schemas.league import (
    UserLeagueInfoSchema,
    LeaderboardEntrySchema,
    LeagueSchema,
    WeeklyResultSchema
)
from api.auth import verify_token
from api.models.league import League, WeeklyLeaderboard
from sqlalchemy import select, desc

router = APIRouter(prefix="/leagues", tags=["leagues"])


async def get_current_user_id(token: str) -> int:
    """Extract user ID from JWT token"""
    payload = verify_token(token)
    if not payload:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid authentication credentials",
            headers={"WWW-Authenticate": "Bearer"},
        )
    return payload.get("user_id")


@router.get("/my-league", response_model=UserLeagueInfoSchema)
async def get_my_league(
    token: str,
    db: AsyncSession = Depends(get_db)
):
    """
    Get current league information for the authenticated user.

    Returns:
    - League details (level, name, color)
    - Weekly coins earned so far
    - Current rank in league
    - Total participants in league
    - Week start/end dates
    """
    user_id = await get_current_user_id(token)

    league_info = await LeagueService.get_user_league_info(db, user_id)

    return UserLeagueInfoSchema(**league_info)


@router.get("/leaderboard", response_model=List[LeaderboardEntrySchema])
async def get_leaderboard(
    token: str,
    db: AsyncSession = Depends(get_db)
):
    """
    Get current week's leaderboard for user's league.

    Returns list of all participants sorted by weekly coins (highest first).
    """
    user_id = await get_current_user_id(token)

    # Get user's current league
    league_info = await LeagueService.get_user_league_info(db, user_id)

    if not league_info["in_league"]:
        # Initialize user in Bronze league
        await LeagueService.initialize_user_league(db, user_id)
        league_info = await LeagueService.get_user_league_info(db, user_id)

    league_id = league_info["league"]["id"]

    # Get leaderboard
    leaderboard = await LeagueService.get_league_leaderboard(db, league_id)

    return [LeaderboardEntrySchema(**entry) for entry in leaderboard]


@router.get("/all-leagues", response_model=List[LeagueSchema])
async def get_all_leagues(db: AsyncSession = Depends(get_db)):
    """
    Get list of all available leagues.

    Returns all leagues from Bronze to Platinum.
    """
    result = await db.execute(select(League).order_by(League.level))
    leagues = result.scalars().all()

    return [LeagueSchema.model_validate(league) for league in leagues]


@router.get("/history", response_model=List[WeeklyResultSchema])
async def get_league_history(
    token: str,
    limit: int = 10,
    db: AsyncSession = Depends(get_db)
):
    """
    Get user's league history (past weeks results).

    Parameters:
    - limit: Maximum number of weeks to return (default: 10)

    Returns list of weekly results including promotions/demotions.
    """
    user_id = await get_current_user_id(token)

    result = await db.execute(
        select(WeeklyLeaderboard, League)
        .join(League, WeeklyLeaderboard.league_id == League.id)
        .where(WeeklyLeaderboard.user_id == user_id)
        .order_by(desc(WeeklyLeaderboard.week_start_date))
        .limit(limit)
    )
    rows = result.all()

    history = []
    for leaderboard, league in rows:
        # Get next league name if applicable
        next_league_name = None
        if leaderboard.next_league_id and leaderboard.next_league_id != league.id:
            next_league_result = await db.execute(
                select(League).where(League.id == leaderboard.next_league_id)
            )
            next_league = next_league_result.scalar_one_or_none()
            if next_league:
                next_league_name = next_league.name

        history.append(WeeklyResultSchema(
            week_start=leaderboard.week_start_date,
            week_end=leaderboard.week_end_date,
            league_name=league.name,
            league_level=league.level,
            weekly_coins=leaderboard.weekly_coins,
            final_rank=leaderboard.final_rank,
            total_participants=leaderboard.total_participants,
            percentile=leaderboard.percentile,
            promoted=leaderboard.promoted,
            next_league_name=next_league_name
        ))

    return history
