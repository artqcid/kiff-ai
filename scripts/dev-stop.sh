#!/bin/bash
# KIFF AI Development Stop Script (Bash)
# This script stops all running development servers

echo "========================================"
echo "  Stopping KIFF AI Development Servers"
echo "========================================"
echo ""

# Function to kill process
stop_service() {
    local pid_file=$1
    local service_name=$2
    local port=$3
    
    echo "Stopping $service_name (port $port)..."
    
    if [ -f "$pid_file" ]; then
        local pid=$(cat "$pid_file")
        if ps -p $pid > /dev/null 2>&1; then
            kill -15 $pid 2>/dev/null || kill -9 $pid 2>/dev/null
            echo "  ✓ $service_name stopped (PID: $pid)"
        else
            echo "  ○ $service_name not running"
        fi
        rm -f "$pid_file"
    else
        # Try to find and kill by port
        local pid=$(lsof -ti:$port 2>/dev/null)
        if [ -n "$pid" ]; then
            kill -15 $pid 2>/dev/null || kill -9 $pid 2>/dev/null
            echo "  ✓ $service_name stopped (PID: $pid)"
        else
            echo "  ○ $service_name not running"
        fi
    fi
}

# Stop backend (port 8000)
stop_service ".backend.pid" "Backend (Uvicorn)" 8000

# Stop frontend (port 5173)
stop_service ".frontend.pid" "Frontend (Vite)" 5173

# Clean up any remaining processes
echo ""
echo "Cleaning up remaining processes..."

# Stop any uvicorn processes
pkill -f "uvicorn.*main:app" 2>/dev/null && echo "  ✓ Stopped additional uvicorn processes" || echo "  ○ No additional uvicorn processes found"

# Stop any Vite processes
pkill -f "vite.*dev" 2>/dev/null && echo "  ✓ Stopped additional Vite processes" || echo "  ○ No additional Vite processes found"

# Clean up log files
if [ -f "backend.log" ]; then
    rm -f backend.log
    echo "  ✓ Removed backend.log"
fi

if [ -f "frontend.log" ]; then
    rm -f frontend.log
    echo "  ✓ Removed frontend.log"
fi

echo ""
echo "========================================"
echo "  All Services Stopped! ✓"
echo "========================================"
echo ""
