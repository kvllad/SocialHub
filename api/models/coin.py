from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, Boolean, Date
from sqlalchemy.orm import relationship
from datetime import datetime
from api.database import Base


class Coin(Base):
    """Model for tracking user coins/points"""
    __tablename__ = "coins"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    amount = Column(Integer, nullable=False)  # Positive for earning, negative for spending
    reason = Column(String, nullable=False)  # e.g., "office_checkin", "bonus", "purchase"
    description = Column(String, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationship
    user = relationship("User", back_populates="coins")


class CheckIn(Base):
    """Model for tracking office check-ins"""
    __tablename__ = "checkins"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    checkin_date = Column(Date, nullable=False)
    office = Column(String, nullable=False)
    coins_earned = Column(Integer, nullable=False)
    is_first_of_week = Column(Boolean, default=False)  # First checkin of the week gets bonus
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationship
    user = relationship("User", back_populates="checkins")