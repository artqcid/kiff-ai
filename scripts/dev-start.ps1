# KIFF AI Development Start Script (PowerShell)
# This script starts both backend and frontend development servers

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Starting KIFF AI Development Servers" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if virtual environment exists
if (-not (Test-Path "venv")) {
    Write-Host "✗ Virtual environment not found!" -ForegroundColor Red
    Write-Host "  Please run: .\scripts\dev-setup.ps1" -ForegroundColor Yellow
    exit 1
}

# Check if ports are available
Write-Host "Checking port availability..." -ForegroundColor Yellow

$portsToCheck = @(8000, 5173)
foreach ($port in $portsToCheck) {
    $connection = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue
    if ($connection) {
        Write-Host "  ✗ Port $port is already in use!" -ForegroundColor Red
        Write-Host "    Process: $($connection.OwningProcess)" -ForegroundColor Yellow
        Write-Host "    Please close the application using this port or run: .\scripts\dev-stop.ps1" -ForegroundColor Yellow
        exit 1
    }
}
Write-Host "  ✓ All ports available" -ForegroundColor Green
Write-Host ""

# Start backend in new terminal
Write-Host "Starting backend server..." -ForegroundColor Yellow
$backendScript = {
    Set-Location $using:PWD
    & .\venv\Scripts\Activate.ps1
    Set-Location backend\api
    python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000
}
Start-Process pwsh -ArgumentList "-NoExit", "-Command", "& {$backendScript}"
Write-Host "  ✓ Backend starting on http://localhost:8000" -ForegroundColor Green
Write-Host "  ✓ API Docs: http://localhost:8000/docs" -ForegroundColor Green

# Wait a bit for backend to initialize
Start-Sleep -Seconds 2

# Start frontend in new terminal
Write-Host "Starting frontend server..." -ForegroundColor Yellow
$frontendScript = {
    Set-Location $using:PWD
    Set-Location frontend
    npm run dev
}
Start-Process pwsh -ArgumentList "-NoExit", "-Command", "& {$frontendScript}"
Write-Host "  ✓ Frontend starting on http://localhost:5173" -ForegroundColor Green

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Development Servers Started! ✓" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Access your application:" -ForegroundColor Yellow
Write-Host "  • Frontend: http://localhost:5173" -ForegroundColor White
Write-Host "  • Backend API: http://localhost:8000" -ForegroundColor White
Write-Host "  • API Documentation: http://localhost:8000/docs" -ForegroundColor White
Write-Host ""
Write-Host "To stop servers, run: .\scripts\dev-stop.ps1" -ForegroundColor Yellow
Write-Host ""
