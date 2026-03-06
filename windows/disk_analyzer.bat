@echo off
REM ========================================
REM Disk Space Analyzer
REM Shows disk usage and large files
REM ========================================

title Disk Space Analyzer
color 0E

:MENU
cls
echo ========================================
echo     DISK SPACE ANALYZER
echo ========================================
echo.
echo 1. Show All Drives Space
echo 2. Analyze Specific Drive
echo 3. Find Large Files (over 100MB)
echo 4. Show Folder Sizes
echo 5. Exit
echo.
echo ========================================
set /p CHOICE="Enter your choice (1-5): "

if "%CHOICE%"=="1" goto SHOW_DRIVES
if "%CHOICE%"=="2" goto ANALYZE_DRIVE
if "%CHOICE%"=="3" goto LARGE_FILES
if "%CHOICE%"=="4" goto FOLDER_SIZES
if "%CHOICE%"=="5" goto EXIT
goto MENU

:SHOW_DRIVES
cls
echo Disk Space Information:
echo ----------------------------------------
powershell -Command "Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' | Select-Object DeviceID, @{Name='Size(GB)';Expression={[math]::Round($_.Size/1GB, 2)}}, @{Name='Free(GB)';Expression={[math]::Round($_.FreeSpace/1GB, 2)}}, FileSystem | Format-Table -AutoSize"
echo.
echo Detailed View:
echo ----------------------------------------
for %%d in (C D E F G H) do (
    if exist %%d:\ (
        echo Drive %%d:
        powershell -Command "$drive = Get-PSDrive %%d; $total = [math]::Round($drive.Used/1GB + $drive.Free/1GB, 2); $used = [math]::Round($drive.Used/1GB, 2); $free = [math]::Round($drive.Free/1GB, 2); $percent = [math]::Round(($drive.Used/($drive.Used + $drive.Free))*100, 2); Write-Host \"  Total: $total GB | Used: $used GB | Free: $free GB | Usage: $percent%%\""
    )
)
echo.
pause
goto MENU

:ANALYZE_DRIVE
cls
echo ========================================
echo Analyze Specific Drive
echo ========================================
echo.
set /p DRIVE="Enter drive letter (e.g., C): "
if "%DRIVE%"=="" goto MENU

if not exist %DRIVE%:\ (
    echo Drive %DRIVE%: does not exist!
    pause
    goto MENU
)

echo.
echo Analyzing drive %DRIVE%:...
echo ----------------------------------------
powershell -Command "$drive = Get-PSDrive %DRIVE%; $total = [math]::Round($drive.Used/1GB + $drive.Free/1GB, 2); $used = [math]::Round($drive.Used/1GB, 2); $free = [math]::Round($drive.Free/1GB, 2); $percent = [math]::Round(($drive.Used/($drive.Used + $drive.Free))*100, 2); Write-Host \"Total Space: $total GB\"; Write-Host \"Used Space: $used GB\"; Write-Host \"Free Space: $free GB\"; Write-Host \"Usage: $percent%%\""
echo.
pause
goto MENU

:LARGE_FILES
cls
echo ========================================
echo Finding Large Files (over 100MB)
echo ========================================
echo.
set /p SEARCH_PATH="Enter path to search (e.g., C:\Users): "
if "%SEARCH_PATH%"=="" goto MENU

echo.
echo Searching for large files in %SEARCH_PATH%...
echo This may take a while...
echo ----------------------------------------
powershell -Command "Get-ChildItem -Path '%SEARCH_PATH%' -Recurse -File -ErrorAction SilentlyContinue | Where-Object {$_.Length -gt 100MB} | Sort-Object Length -Descending | Select-Object -First 20 FullName, @{Name='Size(MB)';Expression={[math]::Round($_.Length/1MB, 2)}} | Format-Table -AutoSize"
echo.
pause
goto MENU

:FOLDER_SIZES
cls
echo ========================================
echo Folder Sizes
echo ========================================
echo.
set /p FOLDER_PATH="Enter folder path: "
if "%FOLDER_PATH%"=="" goto MENU

if not exist "%FOLDER_PATH%" (
    echo Folder does not exist!
    pause
    goto MENU
)

echo.
echo Calculating folder sizes in %FOLDER_PATH%...
echo ----------------------------------------
powershell -Command "Get-ChildItem -Path '%FOLDER_PATH%' -Directory | ForEach-Object { $size = (Get-ChildItem -Path $_.FullName -Recurse -File -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum / 1MB; [PSCustomObject]@{Folder=$_.Name; 'Size(MB)'=[math]::Round($size, 2)} } | Sort-Object 'Size(MB)' -Descending | Format-Table -AutoSize"
echo.
pause
goto MENU

:EXIT
exit
