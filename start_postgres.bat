@echo off
echo Checking PostgreSQL service status...

sc query postgresql-x64-14 | findstr "RUNNING" > nul
if %errorlevel% == 0 (
    echo PostgreSQL service is already running.
) else (
    echo Starting PostgreSQL service...
    net start postgresql-x64-14
    if %errorlevel% == 0 (
        echo PostgreSQL service started successfully.
    ) else (
        echo Failed to start PostgreSQL service. Please start it manually.
        echo You may need to install PostgreSQL or configure the service name.
    )
)

echo.
echo Creating or checking database "smartvms"...
echo You'll need to enter your PostgreSQL password when prompted.
echo.

cd %~dp0
psql -U postgres -c "SELECT 1 FROM pg_database WHERE datname='smartvms'" | findstr "1" > nul
if %errorlevel% == 0 (
    echo Database "smartvms" already exists.
) else (
    echo Creating database "smartvms"...
    psql -U postgres -c "CREATE DATABASE smartvms"
    echo Database created successfully.
)

echo.
echo PostgreSQL setup complete!
echo Database: smartvms
echo Username: postgres
echo Password: postgres (or your custom password)
echo.
pause 