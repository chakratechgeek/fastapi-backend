#!/bin/bash
# Installation and Setup Script for FastAPI Backend

echo "====================================="
echo "FastAPI Backend - Installation Script"
echo "====================================="

# Step 1: Create virtual environment
echo "Step 1: Creating virtual environment..."
python3 -m venv venv

# Step 2: Activate virtual environment
echo "Step 2: Activating virtual environment..."
source venv/bin/activate

# Step 3: Upgrade pip
echo "Step 3: Upgrading pip..."
pip install --upgrade pip

# Step 4: Install dependencies
echo "Step 4: Installing dependencies..."
pip install -r requirements.txt

# Step 5: Create database tables
echo "Step 5: Database tables will be created automatically on first run..."

echo ""
echo "====================================="
echo "Installation Complete!"
echo "====================================="
echo ""
echo "To start the application:"
echo "  1. Activate virtual environment: source venv/bin/activate"
echo "  2. Run the server: uvicorn app.main:app --reload --host 0.0.0.0 --port 8001"
echo ""
echo "API will be available at:"
echo "  - Main API: http://localhost:8001"
echo "  - API Docs: http://localhost:8001/docs"
echo "  - ReDoc: http://localhost:8001/redoc"
echo ""
echo "First time setup:"
echo "  1. Register a user: POST http://localhost:8001/api/v1/auth/register"
echo "  2. Login: POST http://localhost:8001/api/v1/auth/login"
echo "  3. Use the bearer token in Authorization header"
echo ""
