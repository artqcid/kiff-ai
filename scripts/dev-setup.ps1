# KIFF AI Development Setup Script (PowerShell)
# This script sets up the development environment for the KIFF AI project

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  KIFF AI Development Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check Python installation
Write-Host "1. Checking Python installation..." -ForegroundColor Yellow
try {
    $pythonVersion = python --version
    Write-Host "   ✓ Python found: $pythonVersion" -ForegroundColor Green
}
catch {
    Write-Host "   ✗ Python not found! Please install Python 3.11+" -ForegroundColor Red
    exit 1
}

# Check Node.js installation
Write-Host "2. Checking Node.js installation..." -ForegroundColor Yellow
try {
    $nodeVersion = node --version
    Write-Host "   ✓ Node.js found: $nodeVersion" -ForegroundColor Green
}
catch {
    Write-Host "   ✗ Node.js not found! Please install Node.js 20+" -ForegroundColor Red
    exit 1
}

# Create Python virtual environment
Write-Host "3. Setting up Python virtual environment..." -ForegroundColor Yellow
if (-not (Test-Path "venv")) {
    python -m venv venv
    Write-Host "   ✓ Virtual environment created" -ForegroundColor Green
}
else {
    Write-Host "   ✓ Virtual environment already exists" -ForegroundColor Green
}

# Activate virtual environment
Write-Host "4. Activating virtual environment..." -ForegroundColor Yellow
& .\venv\Scripts\Activate.ps1
Write-Host "   ✓ Virtual environment activated" -ForegroundColor Green

# Install backend dependencies
Write-Host "5. Installing backend dependencies..." -ForegroundColor Yellow
Push-Location backend
try {
    pip install -r requirements.txt
    Write-Host "   ✓ Backend dependencies installed" -ForegroundColor Green
}
catch {
    Write-Host "   ✗ Failed to install backend dependencies" -ForegroundColor Red
    Pop-Location
    exit 1
}
Pop-Location

# Install frontend dependencies
Write-Host "6. Installing frontend dependencies..." -ForegroundColor Yellow
Push-Location frontend
try {
    npm install
    Write-Host "   ✓ Frontend dependencies installed" -ForegroundColor Green
}
catch {
    Write-Host "   ✗ Failed to install frontend dependencies" -ForegroundColor Red
    Pop-Location
    exit 1
}
Pop-Location

# Create config directories
Write-Host "7. Setting up configuration directories..." -ForegroundColor Yellow
$configDirs = @("config", "documents", "documents/input", "documents/output")
foreach ($dir in $configDirs) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
        Write-Host "   ✓ Created directory: $dir" -ForegroundColor Green
    }
    else {
        Write-Host "   ✓ Directory already exists: $dir" -ForegroundColor Green
    }
}

# Create sample .env file if it doesn't exist
Write-Host "8. Setting up environment variables..." -ForegroundColor Yellow
$envFile = "backend\.env"
if (-not (Test-Path $envFile)) {
    @"
# KIFF AI Backend Configuration
QDRANT_URL=http://localhost:6333
LLM_SERVER_URL=http://localhost:8080
ENVIRONMENT=development
LOG_LEVEL=info
"@ | Out-File -FilePath $envFile -Encoding UTF8
    Write-Host "   ✓ Created .env file: $envFile" -ForegroundColor Green
}
else {
    Write-Host "   ✓ .env file already exists" -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Setup Complete! ✓" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Start development servers: .\scripts\dev-start.ps1" -ForegroundColor White
Write-Host "  2. Or use VS Code tasks: Ctrl+Shift+P -> 'Tasks: Run Task'" -ForegroundColor White
Write-Host "  3. Or use VS Code debugger: F5" -ForegroundColor White
Write-Host ""
