"""
Script to initialize league system with default leagues
"""
import asyncio
import sys
from pathlib import Path

# Add parent directory to path
sys.path.insert(0, str(Path(__file__).parent.parent))

from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker
from api.database import Base  # noqa: F401 - needed for metadata
from api.models.user import User  # noqa: F401
from api.models.coin import Coin, CheckIn  # noqa: F401
from api.models.league import League, UserLeague, WeeklyLeaderboard  # noqa: F401
from dotenv import load_dotenv
import os

load_dotenv()
load_dotenv(".env.local", override=True)


LEAGUES = [
    {"level": 1, "name": "Bronze", "color_emoji": "🟫"},
    {"level": 2, "name": "Silver", "color_emoji": "⚪️"},
    {"level": 3, "name": "Gold", "color_emoji": "🟡"},
    {"level": 4, "name": "Platinum", "color_emoji": "🔷"},
]


async def init_leagues():
    """Initialize leagues in database"""
    DATABASE_URL = os.getenv("DATABASE_URL")
    engine = create_async_engine(DATABASE_URL, echo=True)
    async_session = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)

    async with async_session() as session:
        # Check if leagues already exist
        from sqlalchemy import select
        result = await session.execute(select(League))
        existing = result.scalars().all()

        if existing:
            print(f"Leagues already exist ({len(existing)} leagues found)")
            return

        # Create leagues
        for league_data in LEAGUES:
            league = League(**league_data)
            session.add(league)

        await session.commit()
        print(f"✅ Created {len(LEAGUES)} leagues successfully!")

    await engine.dispose()


if __name__ == "__main__":
    asyncio.run(init_leagues())
