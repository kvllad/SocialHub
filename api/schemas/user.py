import pydantic
from datetime import date

from api.schemas.base import BaseModel


# фио офис номер телефона дата_рождения подразделение/команда интересы: list[str], грейд, дата начала работы в компании

class UserRegisterSchema(BaseModel):
    name: str
    surname: str
    phone_number: str
    office: str
    date_of_birth: date
    department: str
    interests: list[str]
    grade: str
    company_start_date: date
    password: pydantic.SecretStr


class UserLoginSchema(BaseModel):
    phone_number: str
    password: str


class UserGetSchema(BaseModel):
    name: str
    surname: str
    phone_number: str
    office: str
    date_of_birth: date
    department: str
    interests: list[str]
    grade: str
    company_start_date: date
