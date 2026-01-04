# IMMEDIATE FIX INSTRUCTIONS - Run These Commands Now

## Problem
The bcrypt error is still occurring because the server is running with the old incompatible bcrypt version in the virtual environment.

## Solution - Run These Commands

### Step 1: Stop the current server
Press `CTRL+C` in the terminal where uvicorn is running, OR run:
```bash
pkill -f "uvicorn app.main:app"
```

### Step 2: Navigate to project and activate virtual environment
```bash
cd /home/app/fastapi-backend
source .venv/bin/activate
```

### Step 3: Check current bcrypt version (should show 4.x)
```bash
pip show bcrypt
```

### Step 4: Uninstall the incompatible bcrypt
```bash
pip uninstall bcrypt -y
```

### Step 5: Install compatible bcrypt 3.2.2
```bash
pip install bcrypt==3.2.2
```

### Step 6: Verify installation
```bash
pip show bcrypt
# Should show: Version: 3.2.2
```

### Step 7: Reinstall passlib to ensure compatibility
```bash
pip install --force-reinstall passlib[bcrypt]==1.7.4
```

### Step 8: Start the server
```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8001
```

## OR Use the Emergency Fix Script (All-in-One)

```bash
cd /home/app/fastapi-backend
chmod +x emergency_fix.sh
./emergency_fix.sh
```

This script will:
1. Stop any running servers
2. Uninstall incompatible bcrypt
3. Install bcrypt 3.2.2
4. Reinstall passlib
5. Start the server

## Test After Fix

Once the server starts without errors, test registration:

```bash
curl -X POST "http://localhost:8001/api/v1/auth/register" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser123",
    "password": "test123",
    "email": "testuser123@example.com"
  }'
```

Expected: HTTP 200 with user object (no 500 error)

## Quick Commands Summary

```bash
# 1. Stop server (CTRL+C or)
pkill -f uvicorn

# 2. Fix bcrypt
cd /home/app/fastapi-backend
source .venv/bin/activate
pip uninstall bcrypt -y && pip install bcrypt==3.2.2

# 3. Restart server
uvicorn app.main:app --reload --host 0.0.0.0 --port 8001
```

## Why This Happened

The requirements.txt was updated with `bcrypt==3.2.2`, but the virtual environment still has the old incompatible version installed. Python uses what's already installed in the virtual environment, not what's in requirements.txt, unless you explicitly reinstall.

---

**Status:** Ready to fix - Run the commands above
**Expected Time:** 1-2 minutes
