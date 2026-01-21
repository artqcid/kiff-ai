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

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Development Servers Started! ✓" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "This script is deprecated. Please use VS Code Tasks instead:" -ForegroundColor Yellow
Write-Host ""
Write-Host "Quick Start:" -ForegroundColor Cyan
Write-Host "  1. Press Ctrl+Shift+P" -ForegroundColor White
Write-Host "  2. Type 'Tasks: Run Task'" -ForegroundColor White
Write-Host "  3. Select 'Start: All Services (LLM + Backend + Frontend)'" -ForegroundColor White
Write-Host ""
Write-Host "Or press Ctrl+Shift+B to run the default build task" -ForegroundColor Yellow
Write-Host ""
Write-Host "Available Tasks:" -ForegroundColor Cyan
Write-Host "  • Start: All Services (LLM + Backend + Frontend)" -ForegroundColor White
Write-Host "  • Start: Backend + Frontend" -ForegroundColor White
Write-Host "  • LLM: Start Server" -ForegroundColor White
Write-Host "  • Stop: All Services" -ForegroundColor White
Write-Host ""
