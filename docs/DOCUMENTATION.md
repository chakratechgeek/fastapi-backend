# FastAPI Backend - Complete Documentation

**Version:** 1.0.0  
**Last Updated:** 2026-01-04  
**Status:** Production Ready  
**Server:** Oracle Linux 10.1 (192.168.0.112)  
**Application Port:** 8001

---

## Table of Contents

1. [Overview](#overview)
2. [Quick Start](#quick-start)
3. [Project Structure](#project-structure)
4. [API Endpoints](#api-endpoints)
5. [Database Configuration](#database-configuration)
6. [Setup & Installation](#setup--installation)
7. [Testing Guide](#testing-guide)
8. [Troubleshooting & Fixes](#troubleshooting--fixes)
9. [Security & Best Practices](#security--best-practices)
10. [Frontend Integration](#frontend-integration)
11. [Deployment](#deployment)
12. [Changelog](#changelog)
13. [Future Roadmap](#future-roadmap)

---

## Overview

This is a **production-grade FastAPI application** with OAuth2 bearer token authentication, designed to provide a robust, scalable, and maintainable backend API service.

### Technology Stack

- **FastAPI** - Modern, fast web framework
- **Python 3.8+** - Core programming language
- **SQLAlchemy** - SQL ORM for database operations
- **PostgreSQL 16** - Production database
- **Pydantic** - Data validation and settings
- **JWT (python-jose)** - Token-based authentication
- **bcrypt (passlib)** - Secure password hashing
- **Uvicorn** - ASGI server

### Key Features

✅ RESTful API with OAuth2 bearer token authentication  
✅ JWT token generation and validation  
✅ Secure password hashing with bcrypt  
✅ User registration and login endpoints  
✅ Protected routes requiring authentication  
✅ PostgreSQL database integration  
✅ Automatic API documentation (Swagger UI & ReDoc)  
✅ CORS middleware for React.js frontend  
✅ Environment-based configuration  
✅ Production-ready project structure

---

## Quick Start

### Prerequisites

- Python 3.8+
- PostgreSQL database (configured and running)
- Virtual environment tool

### Start the Application (3 commands)

```bash
cd /home/app/fastapi-backend
source .venv/bin/activate
uvicorn app.main:app --reload --host 0.0.0.0 --port 8001
```

### Access API Documentation

Once running, open your browser:
- **Swagger UI:** http://192.168.0.112:8001/docs
- **ReDoc:** http://192.168.0.112:8001/redoc

---

## Project Structure

```
fastapi-backend/
├── app/
│   ├── __init__.py
│   ├── main.py                      # Application entry point
│   ├── api/
│   │   ├── __init__.py
│   │   ├── dependencies.py          # OAuth2 dependencies
│   │   └── v1/
│   │       ├── __init__.py
│   │       ├── api.py               # API router
│   │       └── endpoints/
│   │           ├── __init__.py
│   │           ├── auth.py          # Login & Register endpoints
│   │           └── users.py         # User endpoints
│   ├── core/
│   │   ├── __init__.py
│   │   ├── config.py                # Configuration & settings
│   │   └── security.py              # Password hashing & JWT
│   ├── db/
│   │   ├── __init__.py
│   │   └── session.py               # Database session
│   ├── models/
│   │   ├── __init__.py
│   │   └── user.py                  # User database model
│   ├── schemas/
│   │   ├── __init__.py
│   │   ├── user.py                  # User Pydantic schemas
│   │   └── token.py                 # Token schemas
│   └── crud/
│       ├── __init__.py
│       └── user.py                  # User CRUD operations
├── docs/
│   └── DOCUMENTATION.md             # This file
├── .env                             # Environment variables (gitignored)
├── .env.example                     # Environment template
├── .gitignore                       # Git ignore rules
├── requirements.txt                 # Python dependencies
├── start.sh                         # Quick start script
└── README.md                        # Project readme
```

---

## API Endpoints

### Authentication Endpoints

#### 1. Register New User
**Endpoint:** `POST /api/v1/auth/register`

**Request Body:**
```json
{
  "username": "john",
  "password": "secure123",
  "email": "john@example.com"
}
```

**Response (200 OK):**
```json
{
  "id": 1,
  "username": "john",
  "email": "john@example.com",
  "is_active": true,
  "is_superuser": false,
  "created_at": "2026-01-04T10:00:00"
}
```

**cURL Example:**
```bash
curl -X POST "http://192.168.0.112:8001/api/v1/auth/register" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "john",
    "password": "secure123",
    "email": "john@example.com"
  }'
```

#### 2. Login (OAuth2 Form Data)
**Endpoint:** `POST /api/v1/auth/login`

**Request Body (Form Data):**
- `username`: john
- `password`: secure123

**Response:**
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "bearer"
}
```

**cURL Example:**
```bash
curl -X POST "http://192.168.0.112:8001/api/v1/auth/login" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=john&password=secure123"
```

#### 3. Login (JSON Alternative)
**Endpoint:** `POST /api/v1/auth/login-json`

**Request Body:**
```json
{
  "username": "john",
  "password": "secure123"
}
```

**cURL Example:**
```bash
curl -X POST "http://192.168.0.112:8001/api/v1/auth/login-json" \
  -H "Content-Type: application/json" \
  -d '{"username":"john","password":"secure123"}'
```

### Protected Endpoints (Require Bearer Token)

#### 4. Get Current User
**Endpoint:** `GET /api/v1/users/me`

**Headers:**
```
Authorization: Bearer <your_access_token>
```

**Response:**
```json
{
  "id": 1,
  "username": "john",
  "email": "john@example.com",
  "is_active": true,
  "is_superuser": false,
  "created_at": "2026-01-04T10:00:00"
}
```

**cURL Example:**
```bash
TOKEN="your_token_here"
curl -X GET "http://192.168.0.112:8001/api/v1/users/me" \
  -H "Authorization: Bearer $TOKEN"
```

---

## Database Configuration

### Connection Details

```
Host: 192.168.0.112
Port: 5432
Database: postgres
User: myuser
Password: myuser
```

### Database Schema

**Table:** `users`

| Column | Type | Constraints |
|--------|------|-------------|
| id | INTEGER | PRIMARY KEY, AUTOINCREMENT |
| username | VARCHAR(50) | UNIQUE, NOT NULL, INDEXED |
| email | VARCHAR(100) | UNIQUE, INDEXED |
| hashed_password | VARCHAR(255) | NOT NULL |
| is_active | BOOLEAN | DEFAULT TRUE |
| is_superuser | BOOLEAN | DEFAULT FALSE |
| created_at | TIMESTAMP | DEFAULT NOW() |
| updated_at | TIMESTAMP | ON UPDATE NOW() |

**Note:** The `users` table is created automatically when the application starts.

### Verify Database Connection

```bash
psql -h 192.168.0.112 -U myuser -d postgres
```

### Check Tables

```bash
psql -h 192.168.0.112 -U myuser -d postgres -c "\dt"
psql -h 192.168.0.112 -U myuser -d postgres -c "SELECT * FROM users;"
```

---

## Setup & Installation

### Step 1: Clone/Navigate to Project

```bash
cd /home/app/fastapi-backend
```

### Step 2: Create Virtual Environment

```bash
python3 -m venv .venv
source .venv/bin/activate
```

### Step 3: Install Dependencies

```bash
pip install --upgrade pip
pip install -r requirements.txt
```

**Important:** If you encounter bcrypt issues, run:
```bash
pip uninstall bcrypt -y
pip install bcrypt==3.2.2
```

### Step 4: Configure Environment Variables

The `.env` file should already exist. If not, create it:

```bash
cat > .env << 'EOF'
PGHOST=192.168.0.112
POSTGRES_PORT=5432
PGDATABASE=postgres
PGUSER=myuser
PGPASSWORD=myuser
SECRET_KEY=5xQJYZX9cg4yTt1RmKnb8skhmQ45BN_bgfbTpyPo14Q
JWT_ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
APP_PORT=8001
DEBUG=True
CORS_ORIGINS=["http://localhost:3000","http://192.168.0.112:3000"]
EOF
```

### Step 5: Start the Application

```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8001
```

**Or use the start script:**
```bash
chmod +x start.sh
./start.sh
```

### Step 6: Verify Installation

Open browser: http://192.168.0.112:8001/docs

You should see the interactive API documentation.

---

## Testing Guide

### Using Swagger UI (Recommended)

1. Start the application
2. Open: http://192.168.0.112:8001/docs
3. Test the endpoints interactively:
   - Click on any endpoint
   - Click "Try it out"
   - Fill in the parameters
   - Click "Execute"
4. For protected endpoints:
   - First login to get a token
   - Click "Authorize" button at the top
   - Enter your token
   - Test protected endpoints

### Using cURL

**Complete Test Flow:**

```bash
# 1. Register a new user
curl -X POST "http://192.168.0.112:8001/api/v1/auth/register" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "password": "test123",
    "email": "test@example.com"
  }'

# 2. Login and capture token
TOKEN=$(curl -X POST "http://192.168.0.112:8001/api/v1/auth/login-json" \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","password":"test123"}' \
  | grep -o '"access_token":"[^"]*' | cut -d'"' -f4)

echo "Token: $TOKEN"

# 3. Access protected endpoint
curl -X GET "http://192.168.0.112:8001/api/v1/users/me" \
  -H "Authorization: Bearer $TOKEN"
```

### Using Postman

1. **Register User:**
   - Method: POST
   - URL: http://192.168.0.112:8001/api/v1/auth/register
   - Body: Raw JSON
   ```json
   {
     "username": "testuser",
     "password": "test123",
     "email": "test@example.com"
   }
   ```

2. **Login:**
   - Method: POST
   - URL: http://192.168.0.112:8001/api/v1/auth/login-json
   - Body: Raw JSON
   ```json
   {
     "username": "testuser",
     "password": "test123"
   }
   ```
   - Copy the `access_token` from response

3. **Access Protected Endpoint:**
   - Method: GET
   - URL: http://192.168.0.112:8001/api/v1/users/me
   - Headers:
     - Key: `Authorization`
     - Value: `Bearer <paste_token_here>`

---

## Troubleshooting & Fixes

### Critical Issues Fixed (v1.0.0)

#### Issue #1: Missing Environment Configuration
**Problem:** Application failed to start with `ValidationError: Field required`

**Solution:** Created `.env` file with proper configuration (see Setup section)

#### Issue #2: Bcrypt Compatibility Error
**Problem:** Registration failed with:
- `ValueError: password cannot be longer than 72 bytes`
- `AttributeError: module 'bcrypt' has no attribute '__about__'`

**Root Cause:** Incompatibility between `passlib 1.7.4` and `bcrypt 4.x+`

**Solution:**
```bash
cd /home/app/fastapi-backend
source .venv/bin/activate
pip uninstall bcrypt -y
pip install bcrypt==3.2.2
pip install --force-reinstall passlib[bcrypt]==1.7.4
```

**Permanent Fix:** `requirements.txt` now pins `bcrypt==3.2.2`

#### Issue #3: Virtual Environment Path
**Problem:** Start script referenced wrong path (`venv` instead of `.venv`)

**Solution:** Updated `start.sh` to use `.venv/bin/activate`

### Common Issues

#### Port Already in Use
```bash
# Check what's using port 8001
lsof -ti:8001

# Kill the process
lsof -ti:8001 | xargs kill -9

# Or use a different port
uvicorn app.main:app --reload --host 0.0.0.0 --port 8002
```

#### Database Connection Error
```bash
# Test PostgreSQL connection
psql -h 192.168.0.112 -U myuser -d postgres

# Check if PostgreSQL is running
sudo systemctl status postgresql
```

#### Module Not Found Errors
```bash
# Ensure virtual environment is activated
source .venv/bin/activate

# Reinstall dependencies
pip install -r requirements.txt
```

#### Server Not Starting
1. Check `.env` file exists and has correct values
2. Verify PostgreSQL is accessible
3. Ensure correct bcrypt version: `pip show bcrypt` (should be 3.2.2)
4. Check logs for specific errors

---

## Security & Best Practices

### Current Security Features

✅ **Password Hashing:** bcrypt algorithm  
✅ **JWT Tokens:** HS256 algorithm with 30-minute expiration  
✅ **OAuth2 Bearer:** Standard authorization flow  
✅ **Input Validation:** Pydantic models prevent invalid data  
✅ **SQL Injection Prevention:** SQLAlchemy ORM sanitizes queries  
✅ **CORS Configuration:** Controlled frontend access  

### Security Recommendations

⚠️ **For Production:**

1. **Change Secret Key:**
   ```bash
   python -c "import secrets; print(secrets.token_urlsafe(32))"
   ```
   Update `SECRET_KEY` in `.env` with the generated value

2. **Change Database Password:** Use a strong, unique password

3. **Enable HTTPS:** Use SSL/TLS certificates (Let's Encrypt)

4. **Environment Variables:** Never commit `.env` to git (already in `.gitignore`)

5. **Disable Debug Mode:** Set `DEBUG=False` in production

6. **Update CORS Origins:** Only allow trusted frontend domains

7. **Use Environment-Specific Configs:** Different `.env` files for dev/staging/prod

### Best Practices Implemented

✅ Project structure with separation of concerns  
✅ OAuth2 with JWT authentication  
✅ Password hashing  
✅ SQLAlchemy ORM  
✅ Pydantic schemas for validation  
✅ CORS middleware  
✅ Dependency injection pattern  
✅ Environment-based configuration

### Missing Best Practices (Future Implementation)

- [ ] Alembic migrations (installed but not configured)
- [ ] Structured logging setup
- [ ] Custom exception handlers
- [ ] Comprehensive test suite
- [ ] Docker containerization
- [ ] Rate limiting
- [ ] Enhanced health checks
- [ ] Request ID middleware for tracking
- [ ] Monitoring with Prometheus
- [ ] CI/CD pipeline

---

## Frontend Integration

### React.js Integration Guide

Your React frontend will communicate with this API through standard HTTP requests.

#### 1. Authentication Flow

**Login:**
```javascript
const login = async (username, password) => {
  const response = await fetch('http://192.168.0.112:8001/api/v1/auth/login-json', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ username, password })
  });
  
  const data = await response.json();
  
  // Store token in localStorage or state management
  localStorage.setItem('token', data.access_token);
  
  return data;
};
```

**Register:**
```javascript
const register = async (username, password, email) => {
  const response = await fetch('http://192.168.0.112:8001/api/v1/auth/register', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ username, password, email })
  });
  
  return response.json();
};
```

#### 2. Authenticated Requests

```javascript
const getProfile = async () => {
  const token = localStorage.getItem('token');
  
  const response = await fetch('http://192.168.0.112:8001/api/v1/users/me', {
    headers: {
      'Authorization': `Bearer ${token}`
    }
  });
  
  if (response.status === 401) {
    // Token expired or invalid - redirect to login
    window.location.href = '/login';
    return null;
  }
  
  return response.json();
};
```

#### 3. Axios Integration

```javascript
import axios from 'axios';

// Create axios instance
const api = axios.create({
  baseURL: 'http://192.168.0.112:8001/api/v1'
});

// Add token to all requests
api.interceptors.request.use(config => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

// Handle 401 errors
api.interceptors.response.use(
  response => response,
  error => {
    if (error.response?.status === 401) {
      localStorage.removeItem('token');
      window.location.href = '/login';
    }
    return Promise.reject(error);
  }
);

// Usage
const login = (username, password) => 
  api.post('/auth/login-json', { username, password });

const getProfile = () => 
  api.get('/users/me');
```

### CORS Configuration

The backend is configured to accept requests from:
- `http://localhost:3000` (React development server)
- `http://192.168.0.112:3000` (Local network)

To add more origins, update `.env`:
```
CORS_ORIGINS=["http://localhost:3000","https://yourdomain.com"]
```

---

## Deployment

### Production Deployment Options

#### Option 1: Systemd Service (Recommended for Linux)

Create `/etc/systemd/system/fastapi-backend.service`:
```ini
[Unit]
Description=FastAPI Backend Application
After=network.target postgresql.service

[Service]
Type=simple
User=app
WorkingDirectory=/home/app/fastapi-backend
Environment="PATH=/home/app/fastapi-backend/.venv/bin"
ExecStart=/home/app/fastapi-backend/.venv/bin/uvicorn app.main:app --host 0.0.0.0 --port 8001 --workers 4
Restart=always

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable fastapi-backend
sudo systemctl start fastapi-backend
sudo systemctl status fastapi-backend
```

#### Option 2: Gunicorn with Uvicorn Workers

```bash
pip install gunicorn
gunicorn app.main:app \
  --workers 4 \
  --worker-class uvicorn.workers.UvicornWorker \
  --bind 0.0.0.0:8001 \
  --access-logfile /var/log/fastapi/access.log \
  --error-logfile /var/log/fastapi/error.log
```

#### Option 3: Docker (Future Implementation)

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8001"]
```

### Nginx Reverse Proxy

```nginx
server {
    listen 80;
    server_name yourdomain.com;

    location / {
        proxy_pass http://127.0.0.1:8001;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

### Production Checklist

- [ ] Set `DEBUG=False` in `.env`
- [ ] Generate new `SECRET_KEY`
- [ ] Change database password
- [ ] Configure HTTPS/SSL
- [ ] Set up firewall rules
- [ ] Enable rate limiting
- [ ] Set up monitoring and logging
- [ ] Configure backups
- [ ] Update CORS_ORIGINS for production domain
- [ ] Set appropriate worker count (2-4 x CPU cores)

---

## Changelog

### [1.0.0] - 2026-01-04

#### Project Created
- Initial FastAPI backend with OAuth2 authentication
- PostgreSQL integration (192.168.0.112:5432)
- User registration and login endpoints
- JWT token-based authentication
- Production-ready project structure

#### Features Implemented
- ✅ User Registration API
- ✅ OAuth2 Login (form-data and JSON)
- ✅ JWT Token Generation (30-minute expiration)
- ✅ Protected Routes with Bearer Token
- ✅ Password Hashing with bcrypt
- ✅ PostgreSQL Integration
- ✅ Automatic Table Creation
- ✅ CORS Configuration
- ✅ Interactive API Documentation (Swagger UI)

#### Critical Fixes
1. **Missing Environment Configuration** - Created `.env` file
2. **Bcrypt Compatibility** - Pinned bcrypt to 3.2.2
3. **Virtual Environment Path** - Fixed start.sh path

#### Configuration
- Database: 192.168.0.112:5432/postgres
- Application Port: 8001
- JWT Algorithm: HS256
- Token Expiration: 30 minutes
- CORS: localhost:3000, 192.168.0.112:3000

---

## Future Roadmap

### Phase 1: Critical Features (Immediate)
- [ ] Initialize Alembic migrations
- [ ] Add structured logging
- [ ] Add custom exception handlers
- [ ] Fix timezone-aware datetime usage
- [ ] Add comprehensive error responses

### Phase 2: Essential Features (High Priority)
- [ ] Comprehensive test suite (pytest)
- [ ] Docker containerization
- [ ] Pagination utilities
- [ ] Rate limiting middleware
- [ ] Enhanced health checks
- [ ] Request ID tracking

### Phase 3: Advanced Features (Medium Priority)
- [ ] Background task processing
- [ ] Prometheus metrics/monitoring
- [ ] Pre-commit hooks
- [ ] CI/CD pipeline (GitHub Actions)
- [ ] Enhanced API documentation
- [ ] WebSocket support

### Phase 4: Nice-to-Have (Low Priority)
- [ ] Caching layer (Redis)
- [ ] Email notifications
- [ ] API versioning improvements
- [ ] Performance optimizations
- [ ] Admin dashboard
- [ ] Audit logging

---

## Support & Contributing

### Getting Help

If you encounter issues:
1. Check this documentation's troubleshooting section
2. Verify `.env` file configuration
3. Test database connectivity
4. Check application logs
5. Review error messages in Swagger UI

### Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

**Project Location:** `/home/app/fastapi-backend`  
**Documentation:** `/home/app/fastapi-backend/docs/DOCUMENTATION.md`  
**Environment:** `.env` (not committed to git)  
**Dependencies:** `requirements.txt`

---

*This consolidated documentation replaces the following files:*
- README.md
- PROJECT_SUMMARY.md
- SETUP_GUIDE.md
- FIX_SUMMARY.md
- IMMEDIATE_FIX.md
- FASTAPI_BEST_PRACTICES_IMPLEMENTATION.md
- docs/CHANGELOG.md
