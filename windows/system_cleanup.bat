@echo off
REM ========================================
REM System Cleanup Utility
REM Cleans temporary files and system cache
REM ========================================

echo ========================================
echo      SYSTEM CLEANUP UTILITY
echo ========================================
echo.

echo [1/5] Cleaning Windows Temp folder...
del /q /f /s %TEMP%\* 2>nul
echo Done!

echo [2/5] Cleaning Windows Prefetch...
del /q /f /s C:\Windows\Prefetch\* 2>nul
echo Done!

echo [3/5] Cleaning Recycle Bin...
rd /s /q %systemdrive%\$Recycle.bin 2>nul
echo Done!

echo [4/5] Cleaning Windows Update Cache...
del /q /f /s C:\Windows\SoftwareDistribution\Download\* 2>nul
echo Done!

echo [5/5] Running Disk Cleanup...
cleanmgr /sagerun:1
echo Done!

echo.
echo ========================================
echo Cleanup Complete!
echo ========================================
pause
