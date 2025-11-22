from datetime import datetime, date, timedelta
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func, and_
from api.models.coin import Coin, CheckIn
from api.models.user import User


class CoinService:
    """Service for calculating and managing coins with streak system"""

    # Streak multipliers
    STREAK_MULTIPLIERS = {
        (1, 4): 1.0,    # Days 1-4: ×1 = 10 coins
        (5, 9): 1.2,    # Days 5-9: ×1.2 = 12 coins
        (10, 14): 1.4,  # Days 10-14: ×1.4 = 14 coins
        (15, 19): 2.0,  # Days 15-19: ×2 = 20 coins
        (20, 30): 2.5,  # Days 20-30: ×2.5 = 25 coins
    }
    BASE_COINS = 10  # Base amount before multiplier
    MAX_DAILY_COINS = 25  # After day 30, always 25 coins
    MILESTONE_BONUS = 200  # Bonus every 10 consecutive days
    MILESTONE_INTERVAL = 10

    @staticmethod
    def is_working_day(check_date: date) -> bool:
        """Check if the date is a working day (Monday-Friday)"""
        return check_date.weekday() < 5  # 0-4 are Monday-Friday

    @staticmethod
    async def check_if_already_checked_in_today(db: AsyncSession, user_id: int) -> bool:
        """Check if user already checked in today"""
        today = date.today()
        result = await db.execute(
            select(CheckIn).where(
                CheckIn.user_id == user_id,
                CheckIn.checkin_date == today
            )
        )
        return result.scalar_one_or_none() is not None

    @staticmethod
    async def get_current_streak(db: AsyncSession, user_id: int) -> int:
        """
        Calculate current streak of consecutive working days.
        Only counts working days (Monday-Friday).
        """
        # Get all check-ins ordered by date descending
        result = await db.execute(
            select(CheckIn.checkin_date)
            .where(CheckIn.user_id == user_id)
            .order_by(CheckIn.checkin_date.desc())
        )
        checkin_dates = [row[0] for row in result.all()]

        if not checkin_dates:
            return 0

        # Start from today and go backwards
        current_date = date.today()
        streak = 0

        # If not checked in today, start from yesterday
        if not checkin_dates or checkin_dates[0] != current_date:
            current_date = current_date - timedelta(days=1)

        # Count consecutive working days
        checkin_set = set(checkin_dates)

        while True:
            # Skip weekends
            while not CoinService.is_working_day(current_date):
                current_date = current_date - timedelta(days=1)

            # Check if user checked in on this working day
            if current_date in checkin_set:
                streak += 1
                current_date = current_date - timedelta(days=1)
            else:
                break

            # Safety limit
            if streak > 365:
                break

        return streak

    @staticmethod
    def get_multiplier(streak_day: int) -> float:
        """Get multiplier based on streak day"""
        if streak_day > 30:
            # After day 30, return multiplier that gives 25 coins
            return CoinService.MAX_DAILY_COINS / CoinService.BASE_COINS

        for (start, end), multiplier in CoinService.STREAK_MULTIPLIERS.items():
            if start <= streak_day <= end:
                return multiplier

        # Default for day 1-4
        return 1.0

    @staticmethod
    async def calculate_coins(db: AsyncSession, user_id: int) -> tuple[int, int, bool]:
        """
        Calculate coins for office check-in based on streak.

        Returns: (coins_amount, current_streak, is_milestone)
        """
        # Get current streak (before today's check-in)
        current_streak = await CoinService.get_current_streak(db, user_id)

        # New streak will be current + 1
        new_streak = current_streak + 1

        # Calculate coins based on new streak
        multiplier = CoinService.get_multiplier(new_streak)
        coins = int(CoinService.BASE_COINS * multiplier)

        # Check if this is a milestone (every 10 days)
        is_milestone = (new_streak % CoinService.MILESTONE_INTERVAL == 0)

        return coins, new_streak, is_milestone

    @staticmethod
    async def create_checkin(
        db: AsyncSession,
        user_id: int,
        office: str
    ) -> tuple[CheckIn, int, int]:
        """
        Create a check-in record and award coins.

        Returns: (checkin, total_coins_earned, milestone_bonus)
        """
        # Check if today is a working day
        if not CoinService.is_working_day(date.today()):
            raise ValueError("Check-ins are only allowed on working days (Monday-Friday)")

        # Check if already checked in today
        if await CoinService.check_if_already_checked_in_today(db, user_id):
            raise ValueError("Already checked in today")

        # Calculate coins
        coins_earned, new_streak, is_milestone = await CoinService.calculate_coins(db, user_id)

        # Calculate milestone bonus if applicable
        milestone_bonus = CoinService.MILESTONE_BONUS if is_milestone else 0
        total_coins = coins_earned + milestone_bonus

        # Create check-in record
        checkin = CheckIn(
            user_id=user_id,
            checkin_date=date.today(),
            office=office,
            coins_earned=coins_earned,
            is_first_of_week=False  # We'll use this field differently now - for milestone
        )
        db.add(checkin)

        # Create coin transaction for daily check-in
        description = f"Day {new_streak} check-in at {office}"
        coin = Coin(
            user_id=user_id,
            amount=coins_earned,
            reason="office_checkin",
            description=description
        )
        db.add(coin)

        # If milestone reached, add bonus transaction
        if is_milestone:
            bonus_coin = Coin(
                user_id=user_id,
                amount=milestone_bonus,
                reason="streak_milestone",
                description=f"{new_streak} days streak milestone bonus!"
            )
            db.add(bonus_coin)

        await db.commit()
        await db.refresh(checkin)

        return checkin, total_coins, milestone_bonus

    @staticmethod
    async def get_user_balance(db: AsyncSession, user_id: int) -> dict:
        """Get user's total coin balance and statistics"""
        # Get total earned (positive amounts)
        earned_result = await db.execute(
            select(func.coalesce(func.sum(Coin.amount), 0))
            .where(Coin.user_id == user_id, Coin.amount > 0)
        )
        total_earned = earned_result.scalar()

        # Get total spent (negative amounts)
        spent_result = await db.execute(
            select(func.coalesce(func.sum(Coin.amount), 0))
            .where(Coin.user_id == user_id, Coin.amount < 0)
        )
        total_spent = abs(spent_result.scalar())

        # Get total balance
        balance_result = await db.execute(
            select(func.coalesce(func.sum(Coin.amount), 0))
            .where(Coin.user_id == user_id)
        )
        total_balance = balance_result.scalar()

        # Get checkins count
        checkins_result = await db.execute(
            select(func.count(CheckIn.id))
            .where(CheckIn.user_id == user_id)
        )
        checkins_count = checkins_result.scalar()

        # Get last check-in date
        last_checkin_result = await db.execute(
            select(CheckIn.checkin_date)
            .where(CheckIn.user_id == user_id)
            .order_by(CheckIn.checkin_date.desc())
            .limit(1)
        )
        last_checkin = last_checkin_result.scalar_one_or_none()

        # Get current streak
        current_streak = await CoinService.get_current_streak(db, user_id)

        return {
            "user_id": user_id,
            "total_balance": total_balance,
            "total_earned": total_earned,
            "total_spent": total_spent,
            "checkins_count": checkins_count,
            "last_checkin": last_checkin,
            "current_streak": current_streak
        }

    @staticmethod
    async def get_checkin_history(
        db: AsyncSession,
        user_id: int,
        limit: int = 30
    ) -> list[CheckIn]:
        """Get user's check-in history"""
        result = await db.execute(
            select(CheckIn)
            .where(CheckIn.user_id == user_id)
            .order_by(CheckIn.checkin_date.desc())
            .limit(limit)
        )
        return result.scalars().all()

    @staticmethod
    async def get_coin_transactions(
        db: AsyncSession,
        user_id: int,
        limit: int = 50
    ) -> list[Coin]:
        """Get user's coin transaction history"""
        result = await db.execute(
            select(Coin)
            .where(Coin.user_id == user_id)
            .order_by(Coin.created_at.desc())
            .limit(limit)
        )
        return result.scalars().all()
