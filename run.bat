@echo off
echo Starting Smart Vending Machine Application...

echo Setting up PostgreSQL database...
call start_postgres.bat

echo Starting backend...
start cmd /k "cd backend && mvn spring-boot:run"

echo Waiting for backend to start...
timeout /t 10 /nobreak

echo Starting frontend...
start cmd /k "cd frontend && npm install && npm start"

echo Smart Vending Machine Application is starting up!
echo Backend: http://localhost:8080/api
echo Frontend: http://localhost:3000 