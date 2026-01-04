#!/bin/bash
# Quick Start Commands - FastAPI Backend

echo "🚀 Starting FastAPI Backend with OAuth2 Authentication"
echo ""

# Navigate to project directory
cd /home/app/fastapi-backend

# Activate virtual environment
source .venv/bin/activate

# Start the server
echo "Starting uvicorn server on http://0.0.0.0:8001"
echo ""
echo "📚 API Documentation will be available at:"
echo "   - Swagger UI: http://localhost:8001/docs"
echo "   - ReDoc: http://localhost:8001/redoc"
echo ""
echo "🔐 Authentication Endpoints:"
echo "   - Register: POST /api/v1/auth/register"
echo "   - Login: POST /api/v1/auth/login"
echo "   - Get Profile: GET /api/v1/users/me (requires token)"
echo ""
echo "Press CTRL+C to stop the server"
echo "=========================================="
echo ""

uvicorn app.main:app --reload --host 0.0.0.0 --port 8001
