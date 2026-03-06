@echo off
REM ========================================
REM System Information Display
REM Shows comprehensive system details
REM ========================================

title System Information
color 0B

echo ========================================
echo    SYSTEM INFORMATION REPORT
echo ========================================
echo.

echo [Computer Name]
echo ----------------------------------------
hostname
echo.

echo [Operating System]
echo ----------------------------------------
powershell -Command "Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version, OSArchitecture, BuildNumber | Format-List"
echo.

echo [Processor]
echo ----------------------------------------
powershell -Command "Get-CimInstance Win32_Processor | Select-Object Name, MaxClockSpeed, NumberOfCores, NumberOfLogicalProcessors | Format-List"
echo.

echo [Memory]
echo ----------------------------------------
powershell -Command "$cs = Get-CimInstance Win32_ComputerSystem; $os = Get-CimInstance Win32_OperatingSystem; Write-Host 'Total Physical Memory:' ([math]::Round($cs.TotalPhysicalMemory/1GB, 2)) 'GB'; Write-Host 'Available Memory:' ([math]::Round($os.FreePhysicalMemory/1MB, 2)) 'GB'; Write-Host 'Total Virtual Memory:' ([math]::Round($os.TotalVirtualMemorySize/1MB, 2)) 'GB'"
echo.

echo [Disk Drives]
echo ----------------------------------------
powershell -Command "Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' | Select-Object DeviceID, @{Name='Size(GB)';Expression={[math]::Round($_.Size/1GB, 2)}}, @{Name='Free(GB)';Expression={[math]::Round($_.FreeSpace/1GB, 2)}}, FileSystem | Format-Table -AutoSize"
echo.

echo [BIOS]
echo ----------------------------------------
powershell -Command "Get-CimInstance Win32_BIOS | Select-Object Manufacturer, SMBIOSBIOSVersion, ReleaseDate | Format-List"
echo.

echo [Motherboard]
echo ----------------------------------------
powershell -Command "Get-CimInstance Win32_BaseBoard | Select-Object Manufacturer, Product, Version | Format-List"
echo.

echo [Graphics Card]
echo ----------------------------------------
powershell -Command "Get-CimInstance Win32_VideoController | Select-Object Name, DriverVersion, VideoProcessor | Format-List"
echo.

echo ========================================
echo Report Complete
echo ========================================
pause
