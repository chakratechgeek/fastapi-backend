#!/bin/bash
# Emergency Fix - Stop Server and Reinstall Dependencies

echo "🛑 Stopping any running FastAPI servers..."
pkill -f "uvicorn app.main:app" 2>/dev/null || echo "No running server found"
sleep 2

cd /home/app/fastapi-backend

echo ""
echo "🔧 Activating virtual environment..."
source .venv/bin/activate

echo ""
echo "📦 Checking current bcrypt version..."
pip show bcrypt | grep Version || echo "bcrypt not found"

echo ""
echo "🗑️  Uninstalling incompatible bcrypt..."
pip uninstall bcrypt -y

echo ""
echo "✅ Installing compatible bcrypt 3.2.2..."
pip install bcrypt==3.2.2

echo ""
echo "📋 Verifying bcrypt installation..."
pip show bcrypt | grep Version

echo ""
echo "🔄 Reinstalling passlib to ensure compatibility..."
pip install --force-reinstall passlib[bcrypt]==1.7.4

echo ""
echo "✅ Dependencies fixed!"
echo ""
echo "🚀 Starting FastAPI server..."
echo ""

uvicorn app.main:app --reload --host 0.0.0.0 --port 8001
