@echo off
REM ========================================
REM App Quick Launcher
REM Launch common applications quickly
REM ========================================

title App Quick Launcher
color 0B

:MENU
cls
echo ========================================
echo      APP QUICK LAUNCHER
echo ========================================
echo.
echo 1. Notepad
echo 2. Calculator
echo 3. Task Manager
echo 4. Command Prompt
echo 5. PowerShell
echo 6. Registry Editor
echo 7. Control Panel
echo 8. System Information
echo 9. Disk Management
echo 10. Device Manager
echo 11. Windows Explorer
echo 12. Paint
echo 13. Snipping Tool
echo 14. Character Map
echo 15. Services
echo 16. Event Viewer
echo 17. Resource Monitor
echo 18. Performance Monitor
echo 19. Custom Program
echo 20. Exit
echo.
echo ========================================
set /p CHOICE="Enter your choice (1-20): "

if "%CHOICE%"=="1" start notepad.exe & goto MENU
if "%CHOICE%"=="2" start calc.exe & goto MENU
if "%CHOICE%"=="3" start taskmgr.exe & goto MENU
if "%CHOICE%"=="4" start cmd.exe & goto MENU
if "%CHOICE%"=="5" start powershell.exe & goto MENU
if "%CHOICE%"=="6" start regedit.exe & goto MENU
if "%CHOICE%"=="7" start control.exe & goto MENU
if "%CHOICE%"=="8" start msinfo32.exe & goto MENU
if "%CHOICE%"=="9" start diskmgmt.msc & goto MENU
if "%CHOICE%"=="10" start devmgmt.msc & goto MENU
if "%CHOICE%"=="11" start explorer.exe & goto MENU
if "%CHOICE%"=="12" start mspaint.exe & goto MENU
if "%CHOICE%"=="13" start snippingtool.exe & goto MENU
if "%CHOICE%"=="14" start charmap.exe & goto MENU
if "%CHOICE%"=="15" start services.msc & goto MENU
if "%CHOICE%"=="16" start eventvwr.msc & goto MENU
if "%CHOICE%"=="17" start resmon.exe & goto MENU
if "%CHOICE%"=="18" start perfmon.exe & goto MENU
if "%CHOICE%"=="19" goto CUSTOM
if "%CHOICE%"=="20" goto EXIT
goto MENU

:CUSTOM
cls
echo ========================================
echo Launch Custom Program
echo ========================================
echo.
set /p PROGRAM="Enter program name or path: "
if "%PROGRAM%"=="" goto MENU

echo.
echo Launching %PROGRAM%...
start "" "%PROGRAM%" 2>nul
if errorlevel 1 (
    echo ERROR: Could not launch program!
    pause
)
goto MENU

:EXIT
exit
