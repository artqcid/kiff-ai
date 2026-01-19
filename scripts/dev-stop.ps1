# KIFF AI Development Stop Script (PowerShell)
# This script stops all running development servers

$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Stopping KIFF AI Development Servers" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Function to kill process on port
function Stop-ProcessOnPort {
    param (
        [int]$Port,
        [string]$ServiceName
    )
    
    Write-Host "Stopping $ServiceName (port $Port)..." -ForegroundColor Yellow
    
    $connection = Get-NetTCPConnection -LocalPort $Port -ErrorAction SilentlyContinue
    
    if ($connection) {
        $processId = $connection.OwningProcess
        try {
            Stop-Process -Id $processId -Force
            Write-Host "  ✓ $ServiceName stopped (PID: $processId)" -ForegroundColor Green
        } catch {
            Write-Host "  ✗ Failed to stop $ServiceName" -ForegroundColor Red
        }
    } else {
        Write-Host "  ○ $ServiceName not running" -ForegroundColor Gray
    }
}

# Stop backend (port 8000)
Stop-ProcessOnPort -Port 8000 -ServiceName "Backend (Uvicorn)"

# Stop frontend (port 5173)
Stop-ProcessOnPort -Port 5173 -ServiceName "Frontend (Vite)"

# Stop any remaining Python/Node processes related to the project
Write-Host ""
Write-Host "Cleaning up remaining processes..." -ForegroundColor Yellow

# Stop any uvicorn processes
$uvicornProcesses = Get-Process -Name "python" -ErrorAction SilentlyContinue | Where-Object {
    $_.CommandLine -like "*uvicorn*main:app*"
}
foreach ($proc in $uvicornProcesses) {
    try {
        Stop-Process -Id $proc.Id -Force
        Write-Host "  ✓ Stopped uvicorn process (PID: $($proc.Id))" -ForegroundColor Green
    } catch {
        Write-Host "  ✗ Failed to stop process $($proc.Id)" -ForegroundColor Red
    }
}

# Stop any Vite processes
$viteProcesses = Get-Process -Name "node" -ErrorAction SilentlyContinue | Where-Object {
    $_.CommandLine -like "*vite*"
}
foreach ($proc in $viteProcesses) {
    try {
        Stop-Process -Id $proc.Id -Force
        Write-Host "  ✓ Stopped Vite process (PID: $($proc.Id))" -ForegroundColor Green
    } catch {
        Write-Host "  ✗ Failed to stop process $($proc.Id)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  All Services Stopped! ✓" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
