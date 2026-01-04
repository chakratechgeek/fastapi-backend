# FastAPI Backend - Setup and Usage Guide

## 📋 Prerequisites Installed

✅ Python 3.8+
✅ PostgreSQL Database (Configured)
✅ pip package manager

## 🚀 Quick Start

### Step 1: Navigate to project directory

```bash
cd /home/app/fastapi-backend
```

### Step 2: Create and activate virtual environment

```bash
python3 -m venv venv
source venv/bin/activate
```

### Step 3: Install dependencies

```bash
pip install --upgrade pip
pip install -r requirements.txt
```

### Step 4: Verify environment variables

The `.env` file has been created with your PostgreSQL credentials:

```
PGHOST=192.168.0.112
POSTGRES_PORT=5432
PGDATABASE=postgres
PGUSER=myuser
PGPASSWORD=myuser
APP_PORT=8001
```

### Step 5: Test database connection

```bash
python3 -c "from app.core.config import settings; print(f'Database URL: {settings.DATABASE_URL}')"
```

### Step 6: Start the application

```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8001
```

The application will:
- Create the `users` table automatically if it doesn't exist
- Start the API server on port 8001

## 📚 API Endpoints

### Authentication Endpoints

#### 1. Register a New User

**Endpoint:** `POST /api/v1/auth/register`

**Request Body (JSON):**
```json
{
  "username": "testuser",
  "password": "password123",
  "email": "test@example.com"
}
```

**Response:**
```json
{
  "id": 1,
  "username": "testuser",
  "email": "test@example.com",
  "is_active": true,
  "is_superuser": false,
  "created_at": "2024-01-04T10:00:00"
}
```

#### 2. Login (OAuth2 Form Data)

**Endpoint:** `POST /api/v1/auth/login`

**Request Body (Form Data):**
- `username`: testuser
- `password`: password123

**cURL Example:**
```bash
curl -X POST "http://localhost:8001/api/v1/auth/login" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=testuser&password=password123"
```

**Response:**
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "bearer"
}
```

#### 3. Login (JSON Alternative)

**Endpoint:** `POST /api/v1/auth/login-json`

**Request Body (JSON):**
```json
{
  "username": "testuser",
  "password": "password123"
}
```

**cURL Example:**
```bash
curl -X POST "http://localhost:8001/api/v1/auth/login-json" \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","password":"password123"}'
```

### Protected Endpoints (Require Bearer Token)

#### Get Current User

**Endpoint:** `GET /api/v1/users/me`

**Headers:**
- `Authorization: Bearer <your_access_token>`

**cURL Example:**
```bash
curl -X GET "http://localhost:8001/api/v1/users/me" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
```

**Response:**
```json
{
  "id": 1,
  "username": "testuser",
  "email": "test@example.com",
  "is_active": true,
  "is_superuser": false,
  "created_at": "2024-01-04T10:00:00"
}
```

## 🧪 Testing the API

### Using Swagger UI (Recommended)

1. Start the application
2. Open browser: http://localhost:8001/docs
3. Try the endpoints interactively:
   - Register a user
   - Click "Login" endpoint
   - Use "Try it out"
   - Click "Authorize" button at top
   - Enter your token
   - Test protected endpoints

### Using cURL Commands

**1. Register a user:**
```bash
curl -X POST "http://localhost:8001/api/v1/auth/register" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "john",
    "password": "secure123",
    "email": "john@example.com"
  }'
```

**2. Login and get token:**
```bash
TOKEN=$(curl -X POST "http://localhost:8001/api/v1/auth/login" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=john&password=secure123" | jq -r '.access_token')

echo "Token: $TOKEN"
```

**3. Access protected endpoint:**
```bash
curl -X GET "http://localhost:8001/api/v1/users/me" \
  -H "Authorization: Bearer $TOKEN"
```

### Using Postman

1. **Register User:**
   - Method: POST
   - URL: http://localhost:8001/api/v1/auth/register
   - Body: Raw JSON
   ```json
   {
     "username": "testuser",
     "password": "password123",
     "email": "test@example.com"
   }
   ```

2. **Login:**
   - Method: POST
   - URL: http://localhost:8001/api/v1/auth/login-json
   - Body: Raw JSON
   ```json
   {
     "username": "testuser",
     "password": "password123"
   }
   ```
   - Copy the `access_token` from response

3. **Access Protected Endpoint:**
   - Method: GET
   - URL: http://localhost:8001/api/v1/users/me
   - Headers:
     - Key: `Authorization`
     - Value: `Bearer <paste_your_token_here>`

## 🗄️ Database

The application automatically creates the following table:

### `users` Table Schema

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

### Verify Table Creation

```bash
psql -h 192.168.0.112 -U myuser -d postgres -c "\dt"
psql -h 192.168.0.112 -U myuser -d postgres -c "SELECT * FROM users;"
```

## 🔐 Security Features

✅ **Password Hashing:** bcrypt algorithm
✅ **JWT Tokens:** HS256 algorithm, 30-minute expiration
✅ **OAuth2 Bearer:** Standard authorization flow
✅ **Input Validation:** Pydantic models
✅ **SQL Injection Prevention:** SQLAlchemy ORM
✅ **CORS Configuration:** Configurable origins

## 🔧 Configuration

Edit `.env` file to customize:

```bash
# Change secret key for production
SECRET_KEY=generate-a-strong-random-secret-key

# Adjust token expiration
ACCESS_TOKEN_EXPIRE_MINUTES=60

# Change application port
APP_PORT=8001

# Add frontend URL for CORS
CORS_ORIGINS=["http://localhost:3000", "https://yourdomain.com"]
```

## 📊 API Documentation

Once running, access:

- **Swagger UI:** http://localhost:8001/docs
- **ReDoc:** http://localhost:8001/redoc
- **OpenAPI JSON:** http://localhost:8001/openapi.json

## 🐛 Troubleshooting

### Database Connection Error

```bash
# Test PostgreSQL connection
psql -h 192.168.0.112 -U myuser -d postgres

# Check if PostgreSQL is running
sudo systemctl status postgresql
```

### Module Not Found Errors

```bash
# Ensure virtual environment is activated
source venv/bin/activate

# Reinstall dependencies
pip install -r requirements.txt
```

### Port Already in Use

```bash
# Use different port
uvicorn app.main:app --reload --host 0.0.0.0 --port 8002

# Or kill process using port 8001
lsof -ti:8001 | xargs kill -9
```

## 🚀 Production Deployment

For production:

```bash
# Run with multiple workers
uvicorn app.main:app --host 0.0.0.0 --port 8001 --workers 4

# Or with Gunicorn
gunicorn app.main:app -w 4 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:8001
```

## 📝 Next Steps

1. ✅ Start the application
2. ✅ Register your first user
3. ✅ Test authentication with bearer token
4. ✅ Build additional API endpoints
5. ✅ Integrate with React.js frontend
6. ✅ Deploy to production

## 🤝 Integration with React.js Frontend

Your React application will:

1. **Register/Login:** POST to `/api/v1/auth/register` or `/api/v1/auth/login`
2. **Store Token:** Save `access_token` in localStorage or state management
3. **Authenticated Requests:** Include header: `Authorization: Bearer <token>`
4. **Handle Expiration:** Refresh token or redirect to login after 30 minutes

Example React Code:
```javascript
// Login function
const login = async (username, password) => {
  const response = await fetch('http://localhost:8001/api/v1/auth/login-json', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ username, password })
  });
  const data = await response.json();
  localStorage.setItem('token', data.access_token);
};

// Authenticated request
const getProfile = async () => {
  const token = localStorage.getItem('token');
  const response = await fetch('http://localhost:8001/api/v1/users/me', {
    headers: { 'Authorization': `Bearer ${token}` }
  });
  return response.json();
};
```

---

**Your FastAPI backend with OAuth2 authentication is ready! 🎉**
