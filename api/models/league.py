from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, Date, Boolean
from sqlalchemy.orm import relationship
from datetime import datetime
from api.database import Base


class League(Base):
    """Model for league definitions"""
    __tablename__ = "leagues"

    id = Column(Integer, primary_key=True, index=True)
    level = Column(Integer, unique=True, nullable=False)  # 1, 2, 3, 4
    name = Column(String, nullable=False)  # Bronze, Silver, Gold, Platinum
    color_emoji = Column(String, nullable=False)  # 🟫, ⚪️, 🟡, 🔷
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    user_leagues = relationship("UserLeague", back_populates="league")


class UserLeague(Base):
    """Model for tracking user's league membership and weekly scores"""
    __tablename__ = "user_leagues"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    league_id = Column(Integer, ForeignKey("leagues.id", ondelete="CASCADE"), nullable=False)

    # Week tracking
    week_start_date = Column(Date, nullable=False)  # Monday of the week
    week_end_date = Column(Date, nullable=False)    # Sunday of the week

    # Score tracking
    weekly_coins = Column(Integer, default=0, nullable=False)  # Coins earned this week
    rank = Column(Integer, nullable=True)  # Rank in this league for this week (calculated at week end)

    # Status
    is_current = Column(Boolean, default=True, nullable=False)  # Is this the current active week?
    promoted = Column(Boolean, nullable=True)  # True if promoted, False if demoted, None if stayed

    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    user = relationship("User", back_populates="leagues")
    league = relationship("League", back_populates="user_leagues")


class WeeklyLeaderboard(Base):
    """Model for weekly leaderboard snapshots"""
    __tablename__ = "weekly_leaderboards"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    league_id = Column(Integer, ForeignKey("leagues.id", ondelete="CASCADE"), nullable=False)
    week_start_date = Column(Date, nullable=False)
    week_end_date = Column(Date, nullable=False)

    weekly_coins = Column(Integer, nullable=False)
    final_rank = Column(Integer, nullable=False)
    total_participants = Column(Integer, nullable=False)
    percentile = Column(Integer, nullable=False)  # 0-100, where user falls

    # Result
    promoted = Column(Boolean, nullable=True)  # True/False/None
    next_league_id = Column(Integer, ForeignKey("leagues.id"), nullable=True)

    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    user = relationship("User", foreign_keys=[user_id])
    league = relationship("League", foreign_keys=[league_id])
    next_league = relationship("League", foreign_keys=[next_league_id])
