#!/bin/bash
echo "Starting Smart Vending Machine Application..."

echo "Starting PostgreSQL database..."
echo "Please ensure PostgreSQL is installed and running on port 5432"
echo "Database: smartvms, Username: postgres, Password: postgres"

echo "Starting backend..."
cd backend
mvn spring-boot:run &
BACKEND_PID=$!

echo "Waiting for backend to start..."
sleep 10

echo "Starting frontend..."
cd ../frontend
npm install
npm start &
FRONTEND_PID=$!

echo "Smart Vending Machine Application is starting up!"
echo "Backend: http://localhost:8080/api"
echo "Frontend: http://localhost:3000"

# Handle graceful shutdown
trap "kill $BACKEND_PID $FRONTEND_PID; exit" SIGINT SIGTERM
wait 