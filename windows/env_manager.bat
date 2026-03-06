@echo off
REM ========================================
REM Environment Variables Manager
REM View and manage environment variables
REM ========================================

title Environment Variables Manager
color 0A

:MENU
cls
echo ========================================
echo   ENVIRONMENT VARIABLES MANAGER
echo ========================================
echo.
echo 1. Show All Environment Variables
echo 2. Show System Variables
echo 3. Show User Variables
echo 4. Show Specific Variable
echo 5. Show PATH Variable
echo 6. Export Variables to File
echo 7. Exit
echo.
echo ========================================
set /p CHOICE="Enter your choice (1-7): "

if "%CHOICE%"=="1" goto SHOW_ALL
if "%CHOICE%"=="2" goto SHOW_SYSTEM
if "%CHOICE%"=="3" goto SHOW_USER
if "%CHOICE%"=="4" goto SHOW_SPECIFIC
if "%CHOICE%"=="5" goto SHOW_PATH
if "%CHOICE%"=="6" goto EXPORT
if "%CHOICE%"=="7" goto EXIT
goto MENU

:SHOW_ALL
cls
echo All Environment Variables:
echo ----------------------------------------
set
echo.
pause
goto MENU

:SHOW_SYSTEM
cls
echo System Environment Variables:
echo ----------------------------------------
powershell -Command "[System.Environment]::GetEnvironmentVariables('Machine') | Format-Table -AutoSize"
echo.
pause
goto MENU

:SHOW_USER
cls
echo User Environment Variables:
echo ----------------------------------------
powershell -Command "[System.Environment]::GetEnvironmentVariables('User') | Format-Table -AutoSize"
echo.
pause
goto MENU

:SHOW_SPECIFIC
cls
echo ========================================
echo Show Specific Variable
echo ========================================
echo.
set /p VARNAME="Enter variable name: "
if "%VARNAME%"=="" goto MENU

echo.
echo Value of %VARNAME%:
echo ----------------------------------------
call echo %%%VARNAME%%%
echo.
pause
goto MENU

:SHOW_PATH
cls
echo PATH Variable:
echo ----------------------------------------
echo Current PATH entries:
echo.
powershell -Command "$env:PATH -split ';' | ForEach-Object { Write-Host $_ }"
echo.
pause
goto MENU

:EXPORT
cls
echo ========================================
echo Export Variables to File
echo ========================================
echo.
set EXPORT_FILE=%USERPROFILE%\Desktop\environment_variables.txt

echo Exporting environment variables to:
echo %EXPORT_FILE%
echo.

echo ========================================= > "%EXPORT_FILE%"
echo ENVIRONMENT VARIABLES EXPORT >> "%EXPORT_FILE%"
echo Date: %DATE% %TIME% >> "%EXPORT_FILE%"
echo ========================================= >> "%EXPORT_FILE%"
echo. >> "%EXPORT_FILE%"

set >> "%EXPORT_FILE%"

echo.
echo Export complete!
echo Location: %EXPORT_FILE%
echo.
pause
goto MENU

:EXIT
exit
