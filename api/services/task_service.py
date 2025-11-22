"""
Task Service for managing task completions and rewards
"""
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, and_, func
from sqlalchemy.orm import selectinload
from datetime import datetime, timedelta
from typing import Optional, List

from api.models.task import Task, UserTask
from api.models.user import User
from api.models.coin import Coin
from api.services.ai_service import AIService
from api.services.league_service import LeagueService


class TaskService:
    """Service for task management and completion"""

    @staticmethod
    async def get_available_tasks(db: AsyncSession, user_id: int) -> List[Task]:
        """
        Get all available tasks for a user:
        - All active fixed tasks
        - User's personal AI-generated tasks that haven't expired
        """
        query = select(Task).where(
            and_(
                Task.is_active == True,
                (
                    (Task.task_type == "fixed") |
                    (
                        and_(
                            Task.task_type == "ai_generated",
                            Task.user_id == user_id,
                            (Task.expires_at == None) | (Task.expires_at > datetime.utcnow())
                        )
                    )
                )
            )
        ).order_by(Task.coin_reward.desc())

        result = await db.execute(query)
        return result.scalars().all()

    @staticmethod
    async def check_task_completed(db: AsyncSession, user_id: int, task_id: int) -> bool:
        """Check if user has already completed a specific task"""
        query = select(UserTask).where(
            and_(
                UserTask.user_id == user_id,
                UserTask.task_id == task_id
            )
        )
        result = await db.execute(query)
        return result.scalar_one_or_none() is not None

    @staticmethod
    async def complete_task(db: AsyncSession, user_id: int, task_id: int) -> Optional[dict]:
        """
        Mark a task as completed by user and award coins

        Returns:
            dict with completion info or None if task cannot be completed
        """
        # Get the task
        task_query = select(Task).where(Task.id == task_id)
        task_result = await db.execute(task_query)
        task = task_result.scalar_one_or_none()

        if not task:
            return None

        if not task.is_active:
            return {"error": "Task is not active"}

        # Check if task is expired (for AI-generated tasks)
        if task.expires_at and task.expires_at < datetime.utcnow():
            return {"error": "Task has expired"}

        # Check if task is personal and belongs to this user
        if task.task_type == "ai_generated" and task.user_id != user_id:
            return {"error": "This task is not assigned to you"}

        # Check if already completed
        already_completed = await TaskService.check_task_completed(db, user_id, task_id)
        if already_completed:
            return {"error": "Task already completed"}

        # Create completion record
        completion = UserTask(
            user_id=user_id,
            task_id=task_id,
            coins_earned=task.coin_reward
        )
        db.add(completion)

        # Award coins
        coin_transaction = Coin(
            user_id=user_id,
            amount=task.coin_reward,
            reason="task_completion",
            description=f"Задание: {task.name}"
        )
        db.add(coin_transaction)

        # Update weekly league coins
        await LeagueService.update_user_weekly_coins(db, user_id, task.coin_reward)

        await db.commit()
        await db.refresh(completion)

        return {
            "completion_id": completion.id,
            "task_name": task.name,
            "coins_earned": task.coin_reward,
            "completed_at": completion.completed_at
        }

    @staticmethod
    async def generate_personal_task(db: AsyncSession, user_id: int) -> Optional[dict]:
        """
        Generate a personalized AI task for the user

        Returns:
            dict with task info or None if generation failed
        """
        # Get user info
        user_query = select(User).where(User.id == user_id)
        user_result = await db.execute(user_query)
        user = user_result.scalar_one_or_none()

        if not user:
            return None

        # Calculate age
        age = AIService.calculate_age(user.date_of_birth)

        # Generate task using AI
        task_data = await AIService.generate_personalized_task(
            user_age=age,
            user_interests=user.interests if user.interests else [],
            user_position=user.grade,
            user_department=user.department
        )

        if not task_data:
            return {"error": "Failed to generate task"}

        # Create the task with 24-hour expiration
        expires_at = datetime.utcnow() + timedelta(hours=24)

        task = Task(
            name=task_data["name"],
            coin_reward=task_data["coin_reward"],
            task_type="ai_generated",
            user_id=user_id,
            expires_at=expires_at,
            is_active=True
        )
        db.add(task)
        await db.commit()
        await db.refresh(task)

        return {
            "task_id": task.id,
            "name": task.name,
            "coin_reward": task.coin_reward,
            "expires_at": task.expires_at
        }

    @staticmethod
    async def get_user_completions(
        db: AsyncSession,
        user_id: int,
        limit: int = 50,
        offset: int = 0
    ) -> List[UserTask]:
        """Get user's task completion history"""
        query = (
            select(UserTask)
            .where(UserTask.user_id == user_id)
            .options(selectinload(UserTask.task))
            .order_by(UserTask.completed_at.desc())
            .limit(limit)
            .offset(offset)
        )

        result = await db.execute(query)
        return result.scalars().all()

    @staticmethod
    async def get_user_stats(db: AsyncSession, user_id: int) -> dict:
        """Get user's task completion statistics"""
        # Total tasks completed
        total_query = select(func.count(UserTask.id)).where(UserTask.user_id == user_id)
        total_result = await db.execute(total_query)
        total_completed = total_result.scalar()

        # Total coins earned from tasks
        coins_query = select(func.sum(UserTask.coins_earned)).where(UserTask.user_id == user_id)
        coins_result = await db.execute(coins_query)
        total_coins = coins_result.scalar() or 0

        # Tasks completed today
        today_start = datetime.utcnow().replace(hour=0, minute=0, second=0, microsecond=0)
        today_query = select(func.count(UserTask.id)).where(
            and_(
                UserTask.user_id == user_id,
                UserTask.completed_at >= today_start
            )
        )
        today_result = await db.execute(today_query)
        completed_today = today_result.scalar()

        return {
            "total_completed": total_completed,
            "total_coins_earned": total_coins,
            "completed_today": completed_today
        }
