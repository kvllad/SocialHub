from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from typing import List

from api.database import get_db
from api.services.coin_service import CoinService
from api.schemas.coin import (
    CheckInRequest,
    CheckInResponse,
    UserBalanceResponse,
    CheckInHistoryResponse,
    CoinTransactionSchema
)
from api.auth import verify_token

router = APIRouter(prefix="/coins", tags=["coins"])


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


@router.post("/checkin", response_model=CheckInResponse)
async def office_checkin(
    checkin_data: CheckInRequest,
    token: str,
    db: AsyncSession = Depends(get_db)
):
    """
    Check in to office and earn coins with streak system.

    Streak Multipliers (working days only):
    - Days 1-4: ×1.0 = 10 coins
    - Days 5-9: ×1.2 = 12 coins
    - Days 10-14: ×1.4 = 14 coins
    - Days 15-19: ×2.0 = 20 coins
    - Days 20-30: ×2.5 = 25 coins
    - Days 30+: Always 25 coins

    Milestone Bonus:
    - Every 10 consecutive days: +200 coins bonus

    Rules:
    - Only working days (Monday-Friday) count
    - Can only check in once per day
    - Missing a working day breaks the streak
    """
    try:
        user_id = await get_current_user_id(token)

        # Get current streak before check-in
        current_streak = await CoinService.get_current_streak(db, user_id)
        new_streak = current_streak + 1

        checkin, total_coins, milestone_bonus = await CoinService.create_checkin(
            db=db,
            user_id=user_id,
            office=checkin_data.office
        )

        # Build message
        message = f"Day {new_streak} streak! You earned {checkin.coins_earned} coins"
        if milestone_bonus > 0:
            message += f" + {milestone_bonus} milestone bonus = {total_coins} total coins! 🎉"
        else:
            message += "."

        return CheckInResponse(
            id=checkin.id,
            user_id=checkin.user_id,
            checkin_date=checkin.checkin_date,
            office=checkin.office,
            coins_earned=checkin.coins_earned,
            milestone_bonus=milestone_bonus,
            total_coins=total_coins,
            current_streak=new_streak,
            message=message,
            created_at=checkin.created_at
        )

    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=str(e)
        )


@router.get("/balance", response_model=UserBalanceResponse)
async def get_balance(
    token: str,
    db: AsyncSession = Depends(get_db)
):
    """
    Get user's coin balance and statistics.

    Returns:
    - Total balance
    - Total earned
    - Total spent
    - Number of check-ins
    - Last check-in date
    - Current streak (consecutive working days)
    """
    user_id = await get_current_user_id(token)

    balance_data = await CoinService.get_user_balance(db=db, user_id=user_id)

    return UserBalanceResponse(**balance_data)


@router.get("/checkin-history", response_model=List[CheckInHistoryResponse])
async def get_checkin_history(
    token: str,
    limit: int = 30,
    db: AsyncSession = Depends(get_db)
):
    """
    Get user's check-in history.

    Parameters:
    - limit: Maximum number of records to return (default: 30)
    """
    user_id = await get_current_user_id(token)

    checkins = await CoinService.get_checkin_history(
        db=db,
        user_id=user_id,
        limit=limit
    )

    return [
        CheckInHistoryResponse(
            id=c.id,
            checkin_date=c.checkin_date,
            office=c.office,
            coins_earned=c.coins_earned,
            is_first_of_week=c.is_first_of_week,
            created_at=c.created_at
        )
        for c in checkins
    ]


@router.get("/transactions", response_model=List[CoinTransactionSchema])
async def get_transactions(
    token: str,
    limit: int = 50,
    db: AsyncSession = Depends(get_db)
):
    """
    Get user's coin transaction history.

    Parameters:
    - limit: Maximum number of records to return (default: 50)
    """
    user_id = await get_current_user_id(token)

    transactions = await CoinService.get_coin_transactions(
        db=db,
        user_id=user_id,
        limit=limit
    )

    return [
        CoinTransactionSchema(
            id=t.id,
            user_id=t.user_id,
            amount=t.amount,
            reason=t.reason,
            description=t.description,
            created_at=t.created_at
        )
        for t in transactions
    ]
