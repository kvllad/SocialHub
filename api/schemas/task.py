from pydantic import BaseModel, Field
from datetime import datetime
from typing import Optional


class TaskBase(BaseModel):
    """Base task schema"""
    name: str
    coin_reward: int = Field(ge=0, description="Coin reward for completing the task")


class TaskCreate(TaskBase):
    """Schema for creating a new task"""
    description: Optional[str] = None
    task_type: str = Field(default="fixed", pattern="^(fixed|ai_generated)$")
    user_id: Optional[int] = None
    expires_at: Optional[datetime] = None


class TaskResponse(TaskBase):
    """Schema for task response"""
    id: int
    description: Optional[str] = None
    task_type: str
    is_active: bool
    user_id: Optional[int] = None
    created_at: datetime
    expires_at: Optional[datetime] = None

    class Config:
        from_attributes = True


class TaskCompletionRequest(BaseModel):
    """Schema for task completion request"""
    task_id: int


class TaskCompletionResponse(BaseModel):
    """Schema for task completion response"""
    completion_id: int
    task_name: str
    coins_earned: int
    completed_at: datetime


class UserTaskResponse(BaseModel):
    """Schema for user task completion response"""
    id: int
    user_id: int
    task_id: int
    coins_earned: int
    completed_at: datetime
    task: TaskResponse

    class Config:
        from_attributes = True


class PersonalTaskResponse(BaseModel):
    """Schema for AI-generated personal task response"""
    task_id: int
    name: str
    coin_reward: int
    expires_at: datetime


class TaskStatsResponse(BaseModel):
    """Schema for user task statistics"""
    total_completed: int
    total_coins_earned: int
    completed_today: int
