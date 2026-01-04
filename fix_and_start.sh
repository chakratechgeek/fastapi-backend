#!/bin/bash
# Fix FastAPI Backend - Reinstall Dependencies with Correct bcrypt Version

echo "🔧 Fixing FastAPI Backend Dependencies..."
echo ""

# Navigate to project directory
cd /home/app/fastapi-backend

# Activate virtual environment
echo "1️⃣ Activating virtual environment..."
source .venv/bin/activate

# Uninstall bcrypt
echo "2️⃣ Uninstalling incompatible bcrypt version..."
pip uninstall bcrypt -y

# Install correct bcrypt version
echo "3️⃣ Installing bcrypt 3.2.2 (compatible with passlib)..."
pip install bcrypt==3.2.2

# Reinstall all dependencies to ensure compatibility
echo "4️⃣ Reinstalling all dependencies..."
pip install -r requirements.txt --force-reinstall --no-cache-dir

echo ""
echo "✅ Dependencies fixed!"
echo ""
echo "🚀 Starting FastAPI server on port 8001..."
echo ""

# Start the server
uvicorn app.main:app --reload --host 0.0.0.0 --port 8001
