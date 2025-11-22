"""
Initialize fixed tasks in the database
Run this script once to populate the database with predefined tasks
"""
import asyncio
import sys
from pathlib import Path

# Add parent directory to path
sys.path.append(str(Path(__file__).parent.parent))

from sqlalchemy.ext.asyncio import AsyncSession
from api.database import async_session_maker
# Import all models together to avoid circular import issues
from api.models.user import User  # noqa: F401
from api.models.coin import Coin, CheckIn  # noqa: F401
from api.models.league import League, UserLeague, WeeklyLeaderboard  # noqa: F401
from api.models.task import Task, UserTask  # noqa: F401


FIXED_TASKS = [
    {
        "name": "Предложить идею для мероприятия или митапа",
        "description": "Поделитесь идеей интересного мероприятия или митапа для коллег",
        "coin_reward": 10,
    },
    {
        "name": "Ваше предложенное мероприятие было проведено",
        "description": "Мероприятие, которое вы предложили, успешно состоялось",
        "coin_reward": 1000,
    },
    {
        "name": "Выступить спикером на мероприятии",
        "description": "Провести доклад или презентацию на мероприятии компании",
        "coin_reward": 1000,
    },
    {
        "name": "Войти в топ-3 на мероприятии",
        "description": "Занять призовое место (топ-3) на мероприятии компании",
        "coin_reward": 1000,
    },
    {
        "name": "Кофе-встреча с коллегой",
        "description": "Провести неформальную встречу с коллегой за чашкой кофе",
        "coin_reward": 20,
    },
    {
        "name": "Участие в настольной игре",
        "description": "Поучаствовать в игре в настольные игры с коллегами",
        "coin_reward": 50,
    },
    {
        "name": "Участие в 'Что? Где? Когда?'",
        "description": "Поучаствовать в интеллектуальной игре 'Что? Где? Когда?' в офисе",
        "coin_reward": 50,
    },
]


async def init_tasks():
    """Initialize fixed tasks in the database"""
    async with async_session_maker() as db:
        try:
            # Check if tasks already exist
            from sqlalchemy import select
            result = await db.execute(select(Task).where(Task.task_type == "fixed"))
            existing_tasks = result.scalars().all()

            if existing_tasks:
                print(f"Found {len(existing_tasks)} existing fixed tasks. Skipping initialization.")
                print("To reinitialize, delete existing tasks first.")
                return

            # Create fixed tasks
            for task_data in FIXED_TASKS:
                task = Task(
                    name=task_data["name"],
                    description=task_data.get("description"),
                    coin_reward=task_data["coin_reward"],
                    task_type="fixed",
                    is_active=True
                )
                db.add(task)

            await db.commit()
            print(f"✅ Successfully initialized {len(FIXED_TASKS)} fixed tasks!")

            # Display created tasks
            print("\nCreated tasks:")
            for task_data in FIXED_TASKS:
                print(f"  - {task_data['name']}: {task_data['coin_reward']} коинов")

        except Exception as e:
            print(f"❌ Error initializing tasks: {e}")
            await db.rollback()
            raise


if __name__ == "__main__":
    print("Initializing fixed tasks...")
    asyncio.run(init_tasks())