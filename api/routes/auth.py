from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from datetime import timedelta

from api.database import get_db
from api.models.user import User
from api.schemas.user import UserRegisterSchema, UserLoginSchema, UserGetSchema
from api.auth import get_password_hash, verify_password, create_access_token, ACCESS_TOKEN_EXPIRE_MINUTES
from api.services.league_service import LeagueService

router = APIRouter(prefix="/auth", tags=["authentication"])

# In-memory token blacklist for logout (use Redis in production)
token_blacklist = set()


@router.post("/register", response_model=UserGetSchema, status_code=status.HTTP_201_CREATED)
async def register(user_data: UserRegisterSchema, db: AsyncSession = Depends(get_db)):
    # Check if user already exists
    result = await db.execute(select(User).where(User.phone_number == user_data.phone_number))
    existing_user = result.scalar_one_or_none()

    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="User with this phone number already exists"
        )

    # Create new user
    new_user = User(
        name=user_data.name,
        surname=user_data.surname,
        phone_number=user_data.phone_number,
        office=user_data.office,
        date_of_birth=user_data.date_of_birth,
        department=user_data.department,
        interests=user_data.interests,
        grade=user_data.grade,
        company_start_date=user_data.company_start_date,
        hashed_password=get_password_hash(user_data.password.get_secret_value())
    )

    db.add(new_user)
    await db.commit()
    await db.refresh(new_user)

    # Initialize user in Bronze league
    await LeagueService.initialize_user_league(db, new_user.id)

    return new_user


@router.post("/login")
async def login(user_data: UserLoginSchema, db: AsyncSession = Depends(get_db)):
    # Find user by phone number
    result = await db.execute(select(User).where(User.phone_number == user_data.phone_number))
    user = result.scalar_one_or_none()

    if not user or not verify_password(user_data.password, user.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect phone number or password",
            headers={"WWW-Authenticate": "Bearer"},
        )

    # Create access token
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user.phone_number, "user_id": user.id},
        expires_delta=access_token_expires
    )

    return {
        "access_token": access_token,
        "token_type": "bearer",
        "user": UserGetSchema.model_validate(user)
    }


@router.post("/logout")
async def logout(token: str):
    # Add token to blacklist
    token_blacklist.add(token)

    return {"message": "Successfully logged out"}
