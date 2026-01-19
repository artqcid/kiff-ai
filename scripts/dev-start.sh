#!/bin/bash
# KIFF AI Development Start Script (Bash)
# This script starts both backend and frontend development servers

set -e

echo "========================================"
echo "  Starting KIFF AI Development Servers"
echo "========================================"
echo ""

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "✗ Virtual environment not found!"
    echo "  Please run: ./scripts/dev-setup.sh"
    exit 1
fi

# Check if ports are available
echo "Checking port availability..."

check_port() {
    local port=$1
    if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1 ; then
        echo "  ✗ Port $port is already in use!"
        echo "    Please close the application using this port or run: ./scripts/dev-stop.sh"
        exit 1
    fi
}

check_port 8000
check_port 5173

echo "  ✓ All ports available"
echo ""

# Get the absolute path of the project root
PROJECT_ROOT=$(pwd)

# Start backend in background
echo "Starting backend server..."
(
    cd "$PROJECT_ROOT"
    source venv/bin/activate
    cd backend/api
    python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000 > "$PROJECT_ROOT/backend.log" 2>&1 &
    echo $! > "$PROJECT_ROOT/.backend.pid"
)
echo "  ✓ Backend starting on http://localhost:8000"
echo "  ✓ API Docs: http://localhost:8000/docs"
echo "  ✓ Logs: backend.log"

# Wait a bit for backend to initialize
sleep 2

# Start frontend in background
echo "Starting frontend server..."
(
    cd "$PROJECT_ROOT/frontend"
    npm run dev > "$PROJECT_ROOT/frontend.log" 2>&1 &
    echo $! > "$PROJECT_ROOT/.frontend.pid"
)
echo "  ✓ Frontend starting on http://localhost:5173"
echo "  ✓ Logs: frontend.log"

echo ""
echo "========================================"
echo "  Development Servers Started! ✓"
echo "========================================"
echo ""
echo "Access your application:"
echo "  • Frontend: http://localhost:5173"
echo "  • Backend API: http://localhost:8000"
echo "  • API Documentation: http://localhost:8000/docs"
echo ""
echo "View logs:"
echo "  • Backend: tail -f backend.log"
echo "  • Frontend: tail -f frontend.log"
echo ""
echo "To stop servers, run: ./scripts/dev-stop.sh"
echo ""
