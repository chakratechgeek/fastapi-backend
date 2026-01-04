# FastAPI Backend Application

**Version:** 1.0.0 | **Status:** Production Ready | **Port:** 8001

Modern, production-grade FastAPI backend with OAuth2 JWT authentication and PostgreSQL integration.

## Quick Start

```bash
cd /home/app/fastapi-backend
source .venv/bin/activate
uvicorn app.main:app --reload --host 0.0.0.0 --port 8001
```

**API Documentation:** http://192.168.0.112:8001/docs

## Features

✅ OAuth2 Bearer Token Authentication  
✅ JWT Token Generation & Validation  
✅ User Registration & Login  
✅ Secure Password Hashing (bcrypt)  
✅ PostgreSQL Database Integration  
✅ Interactive API Documentation  
✅ CORS Enabled for React.js Frontend  

## Tech Stack

FastAPI • Python 3.8+ • PostgreSQL 16 • SQLAlchemy • Pydantic • JWT • bcrypt

## Key Endpoints

- `POST /api/v1/auth/register` - Register new user
- `POST /api/v1/auth/login` - Login (OAuth2 form)
- `POST /api/v1/auth/login-json` - Login (JSON)
- `GET /api/v1/users/me` - Get current user (requires token)

## Complete Documentation

📚 **See [docs/DOCUMENTATION.md](docs/DOCUMENTATION.md) for comprehensive documentation including:**

- Detailed setup instructions
- Complete API reference
- Database configuration
- Testing guide
- Troubleshooting & fixes
- Frontend integration guide
- Security best practices
- Deployment instructions
- Full changelog

## Database

- **Host:** 192.168.0.112
- **Port:** 5432
- **Database:** postgres
- **User:** myuser

## Configuration

Environment variables are configured in `.env` file (not committed to git).

```env
PGHOST=192.168.0.112
POSTGRES_PORT=5432
PGDATABASE=postgres
PGUSER=myuser
PGPASSWORD=myuser
SECRET_KEY=<your-secret-key>
JWT_ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
APP_PORT=8001
DEBUG=True
CORS_ORIGINS=["http://localhost:3000","http://192.168.0.112:3000"]
```

## Project Structure

```
fastapi-backend/
├── app/
│   ├── api/v1/endpoints/    # API endpoints (auth, users)
│   ├── core/                # Config & security
│   ├── crud/                # Database operations
│   ├── db/                  # Database session
│   ├── models/              # SQLAlchemy models
│   ├── schemas/             # Pydantic schemas
│   └── main.py              # Application entry
├── docs/
│   ├── DOCUMENTATION.md     # Complete documentation
│   └── CHANGELOG.md         # Version history
├── .env                     # Environment variables
├── requirements.txt         # Dependencies
└── start.sh                 # Quick start script
```

## Testing

**Using cURL:**
```bash
# Register
curl -X POST "http://192.168.0.112:8001/api/v1/auth/register" \
  -H "Content-Type: application/json" \
  -d '{"username":"john","password":"test123","email":"john@test.com"}'

# Login
curl -X POST "http://192.168.0.112:8001/api/v1/auth/login-json" \
  -H "Content-Type: application/json" \
  -d '{"username":"john","password":"test123"}'

# Get profile (with token)
curl -X GET "http://192.168.0.112:8001/api/v1/users/me" \
  -H "Authorization: Bearer <your_token>"
```

**Using Swagger UI (Recommended):**
1. Start the application
2. Open http://192.168.0.112:8001/docs
3. Test endpoints interactively

## Troubleshooting

**Bcrypt error?**
```bash
pip uninstall bcrypt -y && pip install bcrypt==3.2.2
```

**Port in use?**
```bash
lsof -ti:8001 | xargs kill -9
```

**Database connection error?**
```bash
psql -h 192.168.0.112 -U myuser -d postgres
```

See [docs/DOCUMENTATION.md](docs/DOCUMENTATION.md) for complete troubleshooting guide.

## Frontend Integration

**React.js Example:**
```javascript
// Login
const login = async (username, password) => {
  const res = await fetch('http://192.168.0.112:8001/api/v1/auth/login-json', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ username, password })
  });
  const data = await res.json();
  localStorage.setItem('token', data.access_token);
};

// Authenticated request
const getProfile = async () => {
  const token = localStorage.getItem('token');
  const res = await fetch('http://192.168.0.112:8001/api/v1/users/me', {
    headers: { 'Authorization': `Bearer ${token}` }
  });
  return res.json();
};
```

## Security

⚠️ **Production Checklist:**
- [ ] Change `SECRET_KEY` in `.env`
- [ ] Change database password
- [ ] Set `DEBUG=False`
- [ ] Enable HTTPS
- [ ] Update `CORS_ORIGINS`

## License

MIT License

---

**Created:** 2026-01-04 | **Server:** Oracle Linux 10.1 (192.168.0.112)

For detailed documentation, see [docs/DOCUMENTATION.md](docs/DOCUMENTATION.md)
