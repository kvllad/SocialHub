from pydantic import BaseModel, Field
from datetime import datetime, date
from typing import Optional


class CheckInRequest(BaseModel):
    """Request schema for office check-in"""
    office: str = Field(..., description="Office name where user checked in")


class CheckInResponse(BaseModel):
    """Response schema for office check-in"""
    id: int
    user_id: int
    checkin_date: date
    office: str
    coins_earned: int
    milestone_bonus: int
    total_coins: int
    current_streak: int
    message: str
    created_at: datetime

    class Config:
        from_attributes = True


class CoinTransactionSchema(BaseModel):
    """Schema for a single coin transaction"""
    id: int
    user_id: int
    amount: int
    reason: str
    description: Optional[str] = None
    created_at: datetime

    class Config:
        from_attributes = True


class UserBalanceResponse(BaseModel):
    """Response schema for user balance"""
    user_id: int
    total_balance: int
    total_earned: int
    total_spent: int
    checkins_count: int
    last_checkin: Optional[date] = None
    current_streak: int


class CheckInHistoryResponse(BaseModel):
    """Response schema for check-in history"""
    id: int
    checkin_date: date
    office: str
    coins_earned: int
    is_first_of_week: bool
    created_at: datetime

    class Config:
        from_attributes = True