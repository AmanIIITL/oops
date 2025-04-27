# Script to run both backend and frontend of the Smart Vending Machine application

Write-Host "Starting Smart Vending Machine Application..." -ForegroundColor Cyan

# Setup PostgreSQL
Write-Host "`nSetting up PostgreSQL database..." -ForegroundColor Cyan
.\start_postgres.ps1

if ($LASTEXITCODE -ne 0) {
    Write-Host "Database setup failed. Exiting." -ForegroundColor Red
    exit 1
}

# Start backend
Write-Host "`nStarting backend..." -ForegroundColor Cyan
$backendDir = Join-Path -Path $PSScriptRoot -ChildPath "backend"

if (-not (Test-Path $backendDir)) {
    Write-Host "Backend directory not found at $backendDir" -ForegroundColor Red
    exit 1
}

# Start backend in a new window
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Set-Location '$backendDir'; mvn spring-boot:run"

Write-Host "Waiting for backend to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# Start frontend
Write-Host "`nStarting frontend..." -ForegroundColor Cyan
$frontendDir = Join-Path -Path $PSScriptRoot -ChildPath "frontend"

if (-not (Test-Path $frontendDir)) {
    Write-Host "Frontend directory not found at $frontendDir" -ForegroundColor Red
    exit 1
}

# Start frontend in a new window
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Set-Location '$frontendDir'; npm install; npm start"

Write-Host "`nSmart Vending Machine Application is starting up!" -ForegroundColor Green
Write-Host "Backend: http://localhost:8080/api" -ForegroundColor Cyan
Write-Host "Frontend: http://localhost:3000" -ForegroundColor Cyan
Write-Host "`nPress Enter to exit..." -ForegroundColor Yellow
Read-Host 