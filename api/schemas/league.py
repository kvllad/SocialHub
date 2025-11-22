from pydantic import BaseModel
from datetime import date
from typing import Optional


class LeagueSchema(BaseModel):
    """Schema for league info"""
    id: int
    level: int
    name: str
    color_emoji: str

    class Config:
        from_attributes = True


class LeaderboardEntrySchema(BaseModel):
    """Schema for leaderboard entry"""
    rank: int
    user_id: int
    name: str
    surname: str
    weekly_coins: int
    total_participants: int


class UserLeagueInfoSchema(BaseModel):
    """Schema for user's league information"""
    in_league: bool
    league: Optional[LeagueSchema] = None
    weekly_coins: int
    rank: Optional[int] = None
    total_participants: int
    week_start: Optional[date] = None
    week_end: Optional[date] = None


class WeeklyResultSchema(BaseModel):
    """Schema for weekly league result"""
    week_start: date
    week_end: date
    league_name: str
    league_level: int
    weekly_coins: int
    final_rank: int
    total_participants: int
    percentile: int
    promoted: Optional[bool]
    next_league_name: Optional[str] = None

    class Config:
        from_attributes = True
