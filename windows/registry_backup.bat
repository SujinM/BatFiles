@echo off
REM ========================================
REM Registry Backup Utility
REM Backup important registry keys
REM ========================================

title Registry Backup Utility
color 0C

echo ========================================
echo    REGISTRY BACKUP UTILITY
echo ========================================
echo.
echo WARNING: This will backup registry keys
echo Run as Administrator for full access
echo.

REM Create backup directory with timestamp
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /format:list') do set datetime=%%I
set TIMESTAMP=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%_%datetime:~8,2%-%datetime:~10,2%

set BACKUP_DIR=%USERPROFILE%\Desktop\RegistryBackup_%TIMESTAMP%
mkdir "%BACKUP_DIR%" 2>nul

echo Backup Directory: %BACKUP_DIR%
echo.
echo Press any key to start backup or Ctrl+C to cancel...
pause >nul

echo.
echo [1/6] Backing up HKEY_CURRENT_USER...
reg export HKCU "%BACKUP_DIR%\HKCU_backup.reg" /y
echo Done!

echo [2/6] Backing up HKEY_LOCAL_MACHINE\Software...
reg export "HKLM\Software" "%BACKUP_DIR%\HKLM_Software_backup.reg" /y 2>nul
echo Done!

echo [3/6] Backing up HKEY_LOCAL_MACHINE\System...
reg export "HKLM\System" "%BACKUP_DIR%\HKLM_System_backup.reg" /y 2>nul
echo Done!

echo [4/6] Backing up User Environment Variables...
reg export "HKCU\Environment" "%BACKUP_DIR%\User_Environment_backup.reg" /y
echo Done!

echo [5/6] Backing up System Environment Variables...
reg export "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" "%BACKUP_DIR%\System_Environment_backup.reg" /y 2>nul
echo Done!

echo [6/6] Creating backup info file...
echo Registry Backup > "%BACKUP_DIR%\backup_info.txt"
echo Date: %DATE% %TIME% >> "%BACKUP_DIR%\backup_info.txt"
echo Computer: %COMPUTERNAME% >> "%BACKUP_DIR%\backup_info.txt"
echo User: %USERNAME% >> "%BACKUP_DIR%\backup_info.txt"
echo Done!

echo.
echo ========================================
echo Registry backup completed successfully!
echo Location: %BACKUP_DIR%
echo ========================================
echo.
echo To restore, double-click the .reg files
echo or use: reg import filename.reg
echo.
pause
