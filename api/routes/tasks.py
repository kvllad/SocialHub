from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from typing import List

from api.auth import verify_token
from api.database import get_db
from api.models.user import User
from api.services.task_service import TaskService
from api.schemas.task import (
    TaskResponse,
    TaskCompletionResponse,
    UserTaskResponse,
    PersonalTaskResponse,
    TaskStatsResponse
)

router = APIRouter(prefix="/tasks", tags=["tasks"])


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


@router.get("/available", response_model=List[TaskResponse])
async def get_available_tasks(
    user_id: User = Depends(get_current_user_id),
    db: AsyncSession = Depends(get_db)
):
    """
    Получить список доступных заданий для пользователя:
    - Все активные фиксированные задания
    - Персональные AI-задания пользователя, которые не истекли
    """
    tasks = await TaskService.get_available_tasks(db, user_id)
    return tasks


@router.post("/{task_id}/complete", response_model=TaskCompletionResponse)
async def complete_task(
    task_id: int,
    user_id: User = Depends(get_current_user_id),
    db: AsyncSession = Depends(get_db)
):
    """
    Отметить задание как выполненное.
    Пользователь получает награду в коинах.

    Задание можно выполнить только один раз.
    """
    result = await TaskService.complete_task(db, user_id, task_id)

    if not result:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Task not found"
        )

    if "error" in result:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=result["error"]
        )

    return result


@router.post("/generate-personal", response_model=PersonalTaskResponse)
async def generate_personal_task(
    user_id: User = Depends(get_current_user_id),
    db: AsyncSession = Depends(get_db)
):
    """
    Сгенерировать персональное задание для пользователя с помощью AI.

    Задание генерируется на основе:
    - Возраста пользователя
    - Интересов
    - Должности и отдела

    Задание действует 24 часа.
    Награда: 0-50 коинов (определяется AI на основе сложности).
    """
    result = await TaskService.generate_personal_task(db, user_id)

    if not result:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to generate personal task"
        )

    if "error" in result:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=result["error"]
        )

    return result


@router.get("/my-completions", response_model=List[UserTaskResponse])
async def get_my_completions(
    limit: int = 50,
    offset: int = 0,
    user_id: User = Depends(get_current_user_id),
    db: AsyncSession = Depends(get_db)
):
    """
    Получить историю выполненных заданий текущего пользователя.

    Параметры:
    - limit: максимальное количество записей (по умолчанию 50)
    - offset: смещение для пагинации (по умолчанию 0)
    """
    completions = await TaskService.get_user_completions(db, get_current_user_id, limit, offset)
    return completions


@router.get("/stats", response_model=TaskStatsResponse)
async def get_task_stats(
    user_id: User = Depends(get_current_user_id),
    db: AsyncSession = Depends(get_db)
):
    """
    Получить статистику выполнения заданий пользователя:
    - Всего заданий выполнено
    - Всего коинов заработано на заданиях
    - Заданий выполнено сегодня
    """
    stats = await TaskService.get_user_stats(db, user_id)
    return stats
