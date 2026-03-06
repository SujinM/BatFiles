@echo off
REM ========================================
REM Performance Monitor
REM Monitor CPU, Memory, and Disk usage
REM ========================================

title Performance Monitor
color 0A

:MENU
cls
echo ========================================
echo     PERFORMANCE MONITOR
echo ========================================
echo.
echo 1. Quick System Overview
echo 2. CPU Information
echo 3. Memory Usage
echo 4. Disk Usage
echo 5. Top Processes by CPU
echo 6. Top Processes by Memory
echo 7. Continuous Monitoring (10 sec refresh)
echo 8. Exit
echo.
echo ========================================
set /p CHOICE="Enter your choice (1-8): "

if "%CHOICE%"=="1" goto OVERVIEW
if "%CHOICE%"=="2" goto CPU_INFO
if "%CHOICE%"=="3" goto MEMORY
if "%CHOICE%"=="4" goto DISK
if "%CHOICE%"=="5" goto TOP_CPU
if "%CHOICE%"=="6" goto TOP_MEMORY
if "%CHOICE%"=="7" goto CONTINUOUS
if "%CHOICE%"=="8" goto EXIT
goto MENU

:OVERVIEW
cls
echo System Performance Overview:
echo ========================================
echo.
echo [CPU Usage]
powershell -Command "Get-CimInstance Win32_Processor | Select-Object Name, LoadPercentage | Format-Table -AutoSize"
echo.
echo [Memory Usage]
powershell -Command "$os = Get-CimInstance Win32_OperatingSystem; $totalMem = [math]::Round($os.TotalVisibleMemorySize/1MB, 2); $freeMem = [math]::Round($os.FreePhysicalMemory/1MB, 2); $usedMem = $totalMem - $freeMem; $percentUsed = [math]::Round(($usedMem/$totalMem)*100, 2); Write-Host \"Total: $totalMem GB | Used: $usedMem GB | Free: $freeMem GB | Usage: $percentUsed%%\""
echo.
echo [Disk Usage]
powershell -Command "Get-CimInstance Win32_LogicalDisk -Filter \"DriveType=3\" | Select-Object DeviceID, @{Name='Size(GB)';Expression={[math]::Round($_.Size/1GB, 2)}}, @{Name='Free(GB)';Expression={[math]::Round($_.FreeSpace/1GB, 2)}}, @{Name='Used%%';Expression={[math]::Round((($_.Size-$_.FreeSpace)/$_.Size)*100, 2)}} | Format-Table -AutoSize"
echo.
pause
goto MENU

:CPU_INFO
cls
echo CPU Information:
echo ========================================
powershell -Command "Get-CimInstance Win32_Processor | Select-Object Name, MaxClockSpeed, NumberOfCores, NumberOfLogicalProcessors, LoadPercentage | Format-List"
echo.
echo Current CPU Usage:
powershell -Command "while($true) { $cpu = (Get-CimInstance Win32_Processor).LoadPercentage; Write-Host \"CPU: $cpu%%\" -NoNewline; Write-Host \"`r\" -NoNewline; Start-Sleep -Seconds 1 }"
pause
goto MENU

:MEMORY
cls
echo Memory Usage:
echo ========================================
powershell -Command "$os = Get-CimInstance Win32_OperatingSystem; $totalMem = [math]::Round($os.TotalVisibleMemorySize/1MB, 2); $freeMem = [math]::Round($os.FreePhysicalMemory/1MB, 2); $usedMem = $totalMem - $freeMem; $percentUsed = [math]::Round(($usedMem/$totalMem)*100, 2); Write-Host \"Total Memory: $totalMem GB\"; Write-Host \"Used Memory: $usedMem GB\"; Write-Host \"Free Memory: $freeMem GB\"; Write-Host \"Usage: $percentUsed%%\""
echo.
echo Memory by Type:
powershell -Command "Get-CimInstance Win32_PhysicalMemory | Select-Object @{Name='Capacity(GB)';Expression={[math]::Round($_.Capacity/1GB, 2)}}, Manufacturer, Speed, MemoryType | Format-Table -AutoSize"
echo.
pause
goto MENU

:DISK
cls
echo Disk Usage:
echo ========================================
powershell -Command "Get-CimInstance Win32_LogicalDisk -Filter \"DriveType=3\" | ForEach-Object { $size = [math]::Round($_.Size/1GB, 2); $free = [math]::Round($_.FreeSpace/1GB, 2); $used = $size - $free; $percent = [math]::Round(($used/$size)*100, 2); Write-Host \"`nDrive: $($_.DeviceID)\"; Write-Host \"Total: $size GB\"; Write-Host \"Used: $used GB\"; Write-Host \"Free: $free GB\"; Write-Host \"Usage: $percent%%\" }"
echo.
pause
goto MENU

:TOP_CPU
cls
echo Top 10 Processes by CPU Usage:
echo ========================================
powershell -Command "Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 Name, CPU, @{Name='Memory(MB)';Expression={[math]::Round($_.WorkingSet/1MB, 2)}} | Format-Table -AutoSize"
echo.
pause
goto MENU

:TOP_MEMORY
cls
echo Top 10 Processes by Memory Usage:
echo ========================================
powershell -Command "Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 10 Name, @{Name='Memory(MB)';Expression={[math]::Round($_.WorkingSet/1MB, 2)}}, CPU | Format-Table -AutoSize"
echo.
pause
goto MENU

:CONTINUOUS
cls
echo ========================================
echo Continuous Performance Monitoring
echo Press Ctrl+C to stop
echo ========================================
echo.
:LOOP
powershell -Command "$cpu = (Get-CimInstance Win32_Processor).LoadPercentage; $os = Get-CimInstance Win32_OperatingSystem; $totalMem = [math]::Round($os.TotalVisibleMemorySize/1MB, 2); $freeMem = [math]::Round($os.FreePhysicalMemory/1MB, 2); $usedMem = $totalMem - $freeMem; $memPercent = [math]::Round(($usedMem/$totalMem)*100, 2); $disk = Get-CimInstance Win32_LogicalDisk -Filter \"DeviceID='C:'\"; $diskPercent = [math]::Round((($disk.Size-$disk.FreeSpace)/$disk.Size)*100, 2); Clear-Host; Write-Host \"=== Performance Monitor ===\"; Write-Host \"Time: $(Get-Date -Format 'HH:mm:ss')\"; Write-Host \"\"; Write-Host \"CPU Usage: $cpu%%\"; Write-Host \"Memory Usage: $memPercent%% ($usedMem GB / $totalMem GB)\"; Write-Host \"Disk C: Usage: $diskPercent%%\""
timeout /t 10 >nul
goto LOOP

:EXIT
exit
