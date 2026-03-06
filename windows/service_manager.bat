@echo off
REM ========================================
REM Service Manager
REM Start, stop, and manage Windows services
REM ========================================

title Service Manager
color 0C

:MENU
cls
echo ========================================
echo       SERVICE MANAGER
echo ========================================
echo.
echo 1. List All Services
echo 2. List Running Services
echo 3. List Stopped Services
echo 4. Start a Service
echo 5. Stop a Service
echo 6. Restart a Service
echo 7. Check Service Status
echo 8. Exit
echo.
echo ========================================
set /p CHOICE="Enter your choice (1-8): "

if "%CHOICE%"=="1" goto LIST_ALL
if "%CHOICE%"=="2" goto LIST_RUNNING
if "%CHOICE%"=="3" goto LIST_STOPPED
if "%CHOICE%"=="4" goto START_SERVICE
if "%CHOICE%"=="5" goto STOP_SERVICE
if "%CHOICE%"=="6" goto RESTART_SERVICE
if "%CHOICE%"=="7" goto CHECK_STATUS
if "%CHOICE%"=="8" goto EXIT
goto MENU

:LIST_ALL
cls
echo All Services:
echo ----------------------------------------
sc query type= service state= all | findstr "SERVICE_NAME DISPLAY_NAME STATE"
echo.
pause
goto MENU

:LIST_RUNNING
cls
echo Running Services:
echo ----------------------------------------
sc query type= service state= active | findstr "SERVICE_NAME DISPLAY_NAME"
echo.
pause
goto MENU

:LIST_STOPPED
cls
echo Stopped Services:
echo ----------------------------------------
sc query type= service state= inactive | findstr "SERVICE_NAME DISPLAY_NAME"
echo.
pause
goto MENU

:START_SERVICE
cls
echo ========================================
echo Start a Service
echo ========================================
echo.
set /p SERVICE="Enter service name: "
if "%SERVICE%"=="" goto MENU

echo.
echo Starting service: %SERVICE%...
net start "%SERVICE%"
echo.
pause
goto MENU

:STOP_SERVICE
cls
echo ========================================
echo Stop a Service
echo ========================================
echo.
set /p SERVICE="Enter service name: "
if "%SERVICE%"=="" goto MENU

echo.
echo Stopping service: %SERVICE%...
net stop "%SERVICE%"
echo.
pause
goto MENU

:RESTART_SERVICE
cls
echo ========================================
echo Restart a Service
echo ========================================
echo.
set /p SERVICE="Enter service name: "
if "%SERVICE%"=="" goto MENU

echo.
echo Restarting service: %SERVICE%...
net stop "%SERVICE%"
timeout /t 2 >nul
net start "%SERVICE%"
echo.
pause
goto MENU

:CHECK_STATUS
cls
echo ========================================
echo Check Service Status
echo ========================================
echo.
set /p SERVICE="Enter service name: "
if "%SERVICE%"=="" goto MENU

echo.
echo Status of %SERVICE%:
echo ----------------------------------------
sc query "%SERVICE%"
echo.
pause
goto MENU

:EXIT
exit
