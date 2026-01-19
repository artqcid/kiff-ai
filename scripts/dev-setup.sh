#!/bin/bash
# KIFF AI Development Setup Script (Bash)
# This script sets up the development environment for the KIFF AI project

set -e

echo "========================================"
echo "  KIFF AI Development Setup"
echo "========================================"
echo ""

# Check Python installation
echo "1. Checking Python installation..."
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version)
    echo "   ✓ Python found: $PYTHON_VERSION"
else
    echo "   ✗ Python not found! Please install Python 3.11+"
    exit 1
fi

# Check Node.js installation
echo "2. Checking Node.js installation..."
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    echo "   ✓ Node.js found: $NODE_VERSION"
else
    echo "   ✗ Node.js not found! Please install Node.js 20+"
    exit 1
fi

# Create Python virtual environment
echo "3. Setting up Python virtual environment..."
if [ ! -d "venv" ]; then
    python3 -m venv venv
    echo "   ✓ Virtual environment created"
else
    echo "   ✓ Virtual environment already exists"
fi

# Activate virtual environment
echo "4. Activating virtual environment..."
source venv/bin/activate
echo "   ✓ Virtual environment activated"

# Install backend dependencies
echo "5. Installing backend dependencies..."
cd backend
pip install -r requirements.txt
echo "   ✓ Backend dependencies installed"
cd ..

# Install frontend dependencies
echo "6. Installing frontend dependencies..."
cd frontend
npm install
echo "   ✓ Frontend dependencies installed"
cd ..

# Create config directories
echo "7. Setting up configuration directories..."
for dir in config documents documents/input documents/output; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo "   ✓ Created directory: $dir"
    else
        echo "   ✓ Directory already exists: $dir"
    fi
done

# Create sample .env file if it doesn't exist
echo "8. Setting up environment variables..."
ENV_FILE="backend/.env"
if [ ! -f "$ENV_FILE" ]; then
    cat > "$ENV_FILE" << EOF
# KIFF AI Backend Configuration
QDRANT_URL=http://localhost:6333
LLM_SERVER_URL=http://localhost:8080
MCP_SERVER_URL=http://localhost:3000
ENVIRONMENT=development
LOG_LEVEL=info
EOF
    echo "   ✓ Created .env file: $ENV_FILE"
else
    echo "   ✓ .env file already exists"
fi

echo ""
echo "========================================"
echo "  Setup Complete! ✓"
echo "========================================"
echo ""
echo "Next steps:"
echo "  1. Start development servers: ./scripts/dev-start.sh"
echo "  2. Or use VS Code tasks: Ctrl+Shift+P -> 'Tasks: Run Task'"
echo "  3. Or use VS Code debugger: F5"
echo ""
