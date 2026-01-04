from pydantic_settings import BaseSettings
from typing import List
import os


class Settings(BaseSettings):
    # Application
    APP_NAME: str = "FastAPI Backend"
    APP_VERSION: str = "1.0.0"
    DEBUG: bool = True
    API_V1_PREFIX: str = "/api/v1"
    APP_PORT: int = 8001
    
    # Database
    PGHOST: str
    POSTGRES_PORT: int = 5432
    PGDATABASE: str
    PGUSER: str
    PGPASSWORD: str
    
    # Security
    SECRET_KEY: str
    JWT_ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    
    # CORS
    CORS_ORIGINS: List[str] = ["http://localhost:3000"]
    
    @property
    def DATABASE_URL(self) -> str:
        return f"postgresql://{self.PGUSER}:{self.PGPASSWORD}@{self.PGHOST}:{self.POSTGRES_PORT}/{self.PGDATABASE}"
    
    class Config:
        env_file = ".env"
        case_sensitive = True


settings = Settings()
