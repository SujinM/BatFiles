@echo off
REM ========================================
REM Quick Backup Utility
REM Backs up specified folder with timestamp
REM ========================================

title Quick Backup Tool

echo ========================================
echo      QUICK BACKUP UTILITY
echo ========================================
echo.

REM Set source folder (change this to your needs)
set SOURCE=D:\Documents

REM Set backup destination
set BACKUP_ROOT=D:\Backups

REM Create timestamp
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /format:list') do set datetime=%%I
set TIMESTAMP=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%_%datetime:~8,2%-%datetime:~10,2%-%datetime:~12,2%

REM Create backup folder
set BACKUP_DEST=%BACKUP_ROOT%\Backup_%TIMESTAMP%

echo Source: %SOURCE%
echo Destination: %BACKUP_DEST%
echo.

if not exist "%SOURCE%" (
    echo ERROR: Source folder does not exist!
    pause
    exit /b 1
)

echo Creating backup folder...
mkdir "%BACKUP_DEST%" 2>nul

echo Copying files...
xcopy "%SOURCE%" "%BACKUP_DEST%" /E /I /H /Y

echo.
echo ========================================
echo Backup completed successfully!
echo Location: %BACKUP_DEST%
echo ========================================
pause
