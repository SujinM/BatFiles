@echo off
REM ========================================
REM URL Quick Launcher
REM Open multiple websites at once
REM ========================================

title URL Quick Launcher
color 0D

:MENU
cls
echo ========================================
echo     URL QUICK LAUNCHER
echo ========================================
echo.
echo 1. Development Tools
echo 2. Social Media
echo 3. Productivity
echo 4. Entertainment
echo 5. Custom URL
echo 6. Exit
echo.
echo ========================================
set /p CHOICE="Enter your choice (1-6): "

if "%CHOICE%"=="1" goto DEV_TOOLS
if "%CHOICE%"=="2" goto SOCIAL_MEDIA
if "%CHOICE%"=="3" goto PRODUCTIVITY
if "%CHOICE%"=="4" goto ENTERTAINMENT
if "%CHOICE%"=="5" goto CUSTOM
if "%CHOICE%"=="6" goto EXIT
goto MENU

:DEV_TOOLS
cls
echo Opening Development Tools...
start https://github.com
start https://stackoverflow.com
start https://developer.mozilla.org
start https://code.visualstudio.com
start https://nodejs.org
echo.
echo Development tools opened in browser!
timeout /t 2 >nul
goto MENU

:SOCIAL_MEDIA
cls
echo Opening Social Media...
start https://twitter.com
start https://linkedin.com
start https://facebook.com
start https://reddit.com
echo.
echo Social media sites opened!
timeout /t 2 >nul
goto MENU

:PRODUCTIVITY
cls
echo Opening Productivity Apps...
start https://mail.google.com
start https://calendar.google.com
start https://drive.google.com
start https://docs.google.com
start https://trello.com
echo.
echo Productivity tools opened!
timeout /t 2 >nul
goto MENU

:ENTERTAINMENT
cls
echo Opening Entertainment Sites...
start https://youtube.com
start https://netflix.com
start https://spotify.com
start https://twitch.tv
echo.
echo Entertainment sites opened!
timeout /t 2 >nul
goto MENU

:CUSTOM
cls
echo ========================================
echo Open Custom URL
echo ========================================
echo.
set /p URL="Enter URL (include https://): "
if "%URL%"=="" goto MENU

echo.
echo Opening %URL%...
start %URL%
timeout /t 2 >nul
goto MENU

:EXIT
exit
