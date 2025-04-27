# Script to start PostgreSQL and create the database if it doesn't exist

Write-Host "Checking PostgreSQL service status..." -ForegroundColor Cyan

# Check if PostgreSQL service is running (adjust the service name if different)
$service = Get-Service -Name "postgresql*" -ErrorAction SilentlyContinue

if ($null -eq $service) {
    Write-Host "PostgreSQL service not found. Make sure PostgreSQL is installed." -ForegroundColor Red
    exit 1
}

if ($service.Status -eq "Running") {
    Write-Host "PostgreSQL service is already running." -ForegroundColor Green
} else {
    Write-Host "Starting PostgreSQL service..." -ForegroundColor Yellow
    Start-Service $service.Name
    
    # Wait a moment for the service to start
    Start-Sleep -Seconds 2
    
    # Check if it started successfully
    $service = Get-Service -Name $service.Name
    if ($service.Status -eq "Running") {
        Write-Host "PostgreSQL service started successfully." -ForegroundColor Green
    } else {
        Write-Host "Failed to start PostgreSQL service. Please start it manually." -ForegroundColor Red
        exit 1
    }
}

Write-Host "`nChecking database 'smartvms'..." -ForegroundColor Cyan

# Use PSQL to check if the database exists and create it if it doesn't
# Make sure psql is in your PATH
try {
    # Test if we can connect to PostgreSQL
    $testConnection = psql -U postgres -c "SELECT 1" postgres
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Could not connect to PostgreSQL. Please check your installation." -ForegroundColor Red
        exit 1
    }
    
    # Check if database exists
    $dbExists = psql -U postgres -t -c "SELECT 1 FROM pg_database WHERE datname='smartvms'" postgres
    
    if ($dbExists -match "1") {
        Write-Host "Database 'smartvms' already exists." -ForegroundColor Green
    } else {
        Write-Host "Creating database 'smartvms'..." -ForegroundColor Yellow
        $createResult = psql -U postgres -c "CREATE DATABASE smartvms" postgres
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Database created successfully." -ForegroundColor Green
        } else {
            Write-Host "Failed to create database. Please create it manually." -ForegroundColor Red
            exit 1
        }
    }
} catch {
    Write-Host "Error accessing PostgreSQL: $_" -ForegroundColor Red
    Write-Host "Please ensure PostgreSQL is properly installed and 'psql' is in your PATH." -ForegroundColor Yellow
    exit 1
}

Write-Host "`nPostgreSQL setup complete!" -ForegroundColor Green
Write-Host "Database: smartvms" -ForegroundColor Cyan
Write-Host "Username: postgres" -ForegroundColor Cyan
Write-Host "Password: postgres (or your custom password)" -ForegroundColor Cyan 