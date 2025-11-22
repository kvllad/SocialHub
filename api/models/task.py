from sqlalchemy import Column, Integer, String, Boolean, DateTime, ForeignKey, Text
from sqlalchemy.orm import relationship
from datetime import datetime
from api.database import Base


class Task(Base):
    """
    Task/Challenge model
    Can be either fixed (predefined) or AI-generated (personalized)
    """
    __tablename__ = "tasks"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)  # название
    description = Column(Text, nullable=True)  # Optional detailed description
    coin_reward = Column(Integer, nullable=False)  # количество баллов
    task_type = Column(String, nullable=False)  # "fixed" or "ai_generated"
    is_active = Column(Boolean, default=True)

    # For AI-generated tasks - assigned to specific user
    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=True)

    created_at = Column(DateTime, default=datetime.utcnow)
    expires_at = Column(DateTime, nullable=True)  # For AI-generated tasks that expire

    # Relationships
    user = relationship("User", back_populates="personal_tasks")
    completions = relationship("UserTask", back_populates="task", cascade="all, delete-orphan")


class UserTask(Base):
    """
    Track task completions by users
    """
    __tablename__ = "user_tasks"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    task_id = Column(Integer, ForeignKey("tasks.id", ondelete="CASCADE"), nullable=False)

    completed_at = Column(DateTime, default=datetime.utcnow)
    coins_earned = Column(Integer, nullable=False)

    # Relationships
    user = relationship("User", back_populates="completed_tasks")
    task = relationship("Task", back_populates="completions")
