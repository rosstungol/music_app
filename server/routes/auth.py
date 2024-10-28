from fastapi import Depends, HTTPException, APIRouter
from sqlalchemy.orm import Session
from database import get_db
from middleware.auth_middleware import auth_middleware
from models.user import User
from pydantic_schemas.user_create import UserCreate
from pydantic_schemas.user_login import UserLogin
from dotenv import load_dotenv
import uuid
import bcrypt
import jwt
import os

load_dotenv()

router = APIRouter()

@router.post('/signup', status_code=201)
def signup_user(user: UserCreate, db: Session=Depends(get_db)):
  # check if user already exists in the db
  user_db = db.query(User).filter(User.email == user.email).first()

  if user_db:
    raise HTTPException(400, 'User with the same email address already exists')

  hashed_pw = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt())

  user_db = User(id=str(uuid.uuid4()), name=user.name, email=user.email, password=hashed_pw)

  # add user to the db
  db.add(user_db)
  db.commit()
  db.refresh(user_db)

  return user_db

@router.post('/login')
def login_user(user: UserLogin, db: Session=Depends(get_db)):
  # check if user already exists in the db
  user_db = db.query(User).filter(User.email == user.email).first()

  if not user_db:
    raise HTTPException(400, 'You have entered an invalid email address or password')
  
  # check if passwords match
  is_match = bcrypt.checkpw(user.password.encode(), user_db.password)
  
  if not is_match:
    raise HTTPException(400, 'You have entered an invalid email address or password')

  token = jwt.encode({'id': user_db.id}, os.getenv('JWT_PASSWORD_KEY'))

  return {'token': token, 'user': user_db}

@router.get('/')
def current_user_data(db: Session=Depends(get_db),
                      user_dict=Depends(auth_middleware)):
  
  user = db.query(User).filter(User.id == user_dict['uid']).first()

  if not user:
    raise HTTPException(404, 'User not found')

  return user
