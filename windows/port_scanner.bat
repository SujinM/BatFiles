@echo off
REM ========================================
REM Port Scanner
REM Check which ports are in use and by which process
REM ========================================

title Port Scanner
color 0B

:MENU
cls
echo ========================================
echo         PORT SCANNER
echo ========================================
echo.
echo 1. Show All Listening Ports
echo 2. Check Specific Port
echo 3. Show All Ports by Process
echo 4. Find Process Using Port
echo 5. Show Common Ports Status
echo 6. Exit
echo.
echo ========================================
set /p CHOICE="Enter your choice (1-6): "

if "%CHOICE%"=="1" goto SHOW_ALL
if "%CHOICE%"=="2" goto CHECK_PORT
if "%CHOICE%"=="3" goto BY_PROCESS
if "%CHOICE%"=="4" goto FIND_PROCESS
if "%CHOICE%"=="5" goto COMMON_PORTS
if "%CHOICE%"=="6" goto EXIT
goto MENU

:SHOW_ALL
cls
echo All Listening Ports:
echo ----------------------------------------
netstat -ano | findstr "LISTENING"
echo.
pause
goto MENU

:CHECK_PORT
cls
echo ========================================
echo Check Specific Port
echo ========================================
echo.
set /p PORT="Enter port number: "
if "%PORT%"=="" goto MENU

echo.
echo Checking port %PORT%...
echo ----------------------------------------
netstat -ano | findstr ":%PORT%"
echo.
pause
goto MENU

:BY_PROCESS
cls
echo Ports Grouped by Process:
echo ----------------------------------------
netstat -ano -p TCP
echo.
pause
goto MENU

:FIND_PROCESS
cls
echo ========================================
echo Find Process Using Port
echo ========================================
echo.
set /p PORT="Enter port number: "
if "%PORT%"=="" goto MENU

echo.
echo Finding process on port %PORT%...
echo ----------------------------------------
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":%PORT%"') do (
    echo PID: %%a
    tasklist /FI "PID eq %%a"
)
echo.
pause
goto MENU

:COMMON_PORTS
cls
echo Common Ports Status:
echo ----------------------------------------
echo [Port 80 - HTTP]
netstat -ano | findstr ":80 " | findstr "LISTENING"
echo.
echo [Port 443 - HTTPS]
netstat -ano | findstr ":443 " | findstr "LISTENING"
echo.
echo [Port 3000 - Development Server]
netstat -ano | findstr ":3000 " | findstr "LISTENING"
echo.
echo [Port 3306 - MySQL]
netstat -ano | findstr ":3306 " | findstr "LISTENING"
echo.
echo [Port 5432 - PostgreSQL]
netstat -ano | findstr ":5432 " | findstr "LISTENING"
echo.
echo [Port 27017 - MongoDB]
netstat -ano | findstr ":27017 " | findstr "LISTENING"
echo.
echo [Port 6379 - Redis]
netstat -ano | findstr ":6379 " | findstr "LISTENING"
echo.
echo [Port 8080 - Alt HTTP]
netstat -ano | findstr ":8080 " | findstr "LISTENING"
echo.
pause
goto MENU

:EXIT
exit
