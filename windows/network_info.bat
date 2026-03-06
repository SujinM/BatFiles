@echo off
REM ========================================
REM Network Information Display
REM Shows detailed network configuration
REM ========================================

title Network Information Tool
color 0A

echo ========================================
echo    NETWORK INFORMATION TOOL
echo ========================================
echo.

echo [IP Configuration]
echo ----------------------------------------
ipconfig /all
echo.

echo [Active Network Connections]
echo ----------------------------------------
netstat -an | findstr "ESTABLISHED LISTENING"
echo.

echo [DNS Cache]
echo ----------------------------------------
ipconfig /displaydns | findstr "Record" | more
echo.

echo [Network Adapters]
echo ----------------------------------------
powershell -Command "Get-CimInstance Win32_NetworkAdapter -Filter 'NetEnabled=true' | Select-Object Name, MACAddress, Speed | Format-Table -AutoSize"
echo.

echo [Public IP Address]
echo ----------------------------------------
powershell -Command "(Invoke-WebRequest -Uri 'https://api.ipify.org' -UseBasicParsing).Content"
echo.

echo ========================================
echo Press any key to exit...
pause >nul
