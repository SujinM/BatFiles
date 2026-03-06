@echo off
REM ========================================
REM Process Killer Utility
REM Terminate processes by name or PID
REM ========================================

title Process Killer
color 0C

:MENU
cls
echo ========================================
echo      PROCESS KILLER UTILITY
echo ========================================
echo.
echo 1. View Running Processes
echo 2. Kill Process by Name
echo 3. Kill Process by PID
echo 4. Exit
echo.
echo ========================================
set /p CHOICE="Enter your choice (1-4): "

if "%CHOICE%"=="1" goto VIEW_PROCESSES
if "%CHOICE%"=="2" goto KILL_BY_NAME
if "%CHOICE%"=="3" goto KILL_BY_PID
if "%CHOICE%"=="4" goto EXIT
goto MENU

:VIEW_PROCESSES
cls
echo Current Running Processes:
echo ----------------------------------------
tasklist
echo.
pause
goto MENU

:KILL_BY_NAME
cls
echo ========================================
echo Kill Process by Name
echo ========================================
echo.
set /p PNAME="Enter process name (e.g., notepad.exe): "
if "%PNAME%"=="" goto MENU

echo.
echo Attempting to kill: %PNAME%
taskkill /F /IM "%PNAME%" /T
echo.
pause
goto MENU

:KILL_BY_PID
cls
echo ========================================
echo Kill Process by PID
echo ========================================
echo.
set /p PID="Enter Process ID: "
if "%PID%"=="" goto MENU

echo.
echo Attempting to kill PID: %PID%
taskkill /F /PID %PID% /T
echo.
pause
goto MENU

:EXIT
exit
