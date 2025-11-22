from sqlalchemy import Column, String, Date, JSON
from sqlalchemy.orm import relationship
from api.models.base import BaseModel


class User(BaseModel):
    __tablename__ = "users"

    name = Column(String, nullable=False)
    surname = Column(String, nullable=False)
    phone_number = Column(String, unique=True, index=True, nullable=False)
    office = Column(String, nullable=False)
    date_of_birth = Column(Date, nullable=False)
    department = Column(String, nullable=False)
    interests = Column(JSON, nullable=False)
    grade = Column(String, nullable=False)
    company_start_date = Column(Date, nullable=False)
    hashed_password = Column(String, nullable=False)

    # Relationships
    coins = relationship("Coin", back_populates="user", cascade="all, delete-orphan")
    checkins = relationship("CheckIn", back_populates="user", cascade="all, delete-orphan")
    leagues = relationship("UserLeague", back_populates="user", cascade="all, delete-orphan")
