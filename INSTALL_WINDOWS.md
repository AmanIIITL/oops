# Installation Guide for Windows Users

This guide will help you set up and run the Smart Vending Machine application on Windows.

## Prerequisites

Before you begin, ensure you have the following installed:

1. **Java Development Kit (JDK) 17 or higher**
   - Download from: https://www.oracle.com/java/technologies/downloads/#java17
   - After installation, verify by running: `java -version`

2. **Maven**
   - Download from: https://maven.apache.org/download.cgi
   - Install following these instructions: https://maven.apache.org/install.html
   - Add Maven to your PATH
   - Verify by running: `mvn -version`

3. **Node.js and npm**
   - Download from: https://nodejs.org/ (LTS version recommended)
   - Verify by running: `node -v` and `npm -v`

4. **PostgreSQL**
   - Download from: https://www.postgresql.org/download/windows/
   - During installation:
     - Remember the password you set for the 'postgres' user
     - Use default port 5432
   - After installation, you can use pgAdmin (included in the installation) to manage your databases

## Database Setup

1. Open PostgreSQL command line (SQL Shell - psql) or pgAdmin
2. Create a database named 'smartvms':
   ```sql
   CREATE DATABASE smartvms;
   ```
3. If you want to use a different username/password than the default (postgres/postgres), update the configuration in `backend/src/main/resources/application.yml`

## Running the Application (Manual Setup)

### Backend Setup

1. Open PowerShell and navigate to the backend directory:
   ```powershell
   cd .\backend
   ```

2. Build the application with Maven:
   ```powershell
   mvn clean package
   ```

3. Run the application:
   ```powershell
   mvn spring-boot:run
   ```

   The backend will start on http://localhost:8080/api

### Frontend Setup

1. Open a new PowerShell window and navigate to the frontend directory:
   ```powershell
   cd .\frontend
   ```

2. Install dependencies:
   ```powershell
   npm install
   ```

3. Start the development server:
   ```powershell
   npm start
   ```

   The frontend will start on http://localhost:3000

## Running the Application (Using Scripts)

We've provided PowerShell scripts to make running the application easier:

1. First, ensure PostgreSQL service is running:
   ```powershell
   .\start_postgres.ps1
   ```

2. Run the application:
   ```powershell
   .\run.ps1
   ```

   This will:
   - Start PostgreSQL if not running
   - Create the database if it doesn't exist
   - Start the backend server
   - Start the frontend development server

## Access the Application

- Frontend: http://localhost:3000
- Backend API: http://localhost:8080/api

## Default Admin Credentials

- Username: admin123
- Password: aman

## Troubleshooting

1. **Port already in use**
   - If port 8080 is already in use, modify the server port in `backend/src/main/resources/application.yml`
   - If port 3000 is already in use, the React development server will automatically suggest an alternative port

2. **Database connection issues**
   - Ensure PostgreSQL service is running
   - Verify your PostgreSQL username and password in `application.yml`
   - Use pgAdmin to check if the database exists

3. **Maven build failures**
   - Ensure JDK 17+ is installed and set as the JAVA_HOME environment variable
   - Delete the `target` directory and try building again

4. **Frontend dependency issues**
   - Delete the `node_modules` folder and run `npm install` again

## PowerShell Scripts

For easier operation, we've added PowerShell scripts to help run the application:

### start_postgres.ps1

This script checks if PostgreSQL is running and starts it if needed:

```powershell
.\start_postgres.ps1
```

### run.ps1

This script runs both backend and frontend:

```powershell
.\run.ps1
``` 