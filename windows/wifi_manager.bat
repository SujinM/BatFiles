@echo off
REM ========================================
REM WiFi Manager
REM Manage WiFi profiles and connections
REM ========================================

title WiFi Manager
color 0A

:MENU
cls
echo ========================================
echo         WIFI MANAGER
echo ========================================
echo.
echo 1. Show Available WiFi Networks
echo 2. Show Saved WiFi Profiles
echo 3. Show WiFi Password
echo 4. Connect to WiFi Network
echo 5. Disconnect from WiFi
echo 6. Export WiFi Profile
echo 7. Delete WiFi Profile
echo 8. Exit
echo.
echo ========================================
set /p CHOICE="Enter your choice (1-8): "

if "%CHOICE%"=="1" goto SHOW_NETWORKS
if "%CHOICE%"=="2" goto SHOW_PROFILES
if "%CHOICE%"=="3" goto SHOW_PASSWORD
if "%CHOICE%"=="4" goto CONNECT
if "%CHOICE%"=="5" goto DISCONNECT
if "%CHOICE%"=="6" goto EXPORT
if "%CHOICE%"=="7" goto DELETE
if "%CHOICE%"=="8" goto EXIT
goto MENU

:SHOW_NETWORKS
cls
echo Available WiFi Networks:
echo ----------------------------------------
netsh wlan show networks
echo.
pause
goto MENU

:SHOW_PROFILES
cls
echo Saved WiFi Profiles:
echo ----------------------------------------
netsh wlan show profiles
echo.
pause
goto MENU

:SHOW_PASSWORD
cls
echo ========================================
echo Show WiFi Password
echo ========================================
echo.
set /p SSID="Enter WiFi network name: "
if "%SSID%"=="" goto MENU

echo.
echo Password for %SSID%:
echo ----------------------------------------
netsh wlan show profile name="%SSID%" key=clear | findstr "Key Content"
echo.
pause
goto MENU

:CONNECT
cls
echo ========================================
echo Connect to WiFi
echo ========================================
echo.
set /p SSID="Enter WiFi network name: "
if "%SSID%"=="" goto MENU

echo.
echo Connecting to %SSID%...
netsh wlan connect name="%SSID%"
echo.
pause
goto MENU

:DISCONNECT
cls
echo Disconnecting from WiFi...
netsh wlan disconnect
echo.
pause
goto MENU

:EXPORT
cls
echo ========================================
echo Export WiFi Profile
echo ========================================
echo.
set /p SSID="Enter WiFi network name to export: "
if "%SSID%"=="" goto MENU

echo.
set EXPORT_PATH=%USERPROFILE%\Desktop
netsh wlan export profile name="%SSID%" folder="%EXPORT_PATH%"
echo Profile exported to: %EXPORT_PATH%
echo.
pause
goto MENU

:DELETE
cls
echo ========================================
echo Delete WiFi Profile
echo ========================================
echo.
set /p SSID="Enter WiFi network name to delete: "
if "%SSID%"=="" goto MENU

echo.
echo Deleting profile: %SSID%
netsh wlan delete profile name="%SSID%"
echo.
pause
goto MENU

:EXIT
exit
