@echo off
REM ========================================
REM File Search Utility
REM Advanced file search with multiple options
REM ========================================

title File Search Utility
color 0E

:MENU
cls
echo ========================================
echo      FILE SEARCH UTILITY
echo ========================================
echo.
echo 1. Search by File Name
echo 2. Search by Extension
echo 3. Search by Content
echo 4. Search Modified in Last N Days
echo 5. Search by File Size
echo 6. Search Duplicate Files
echo 7. Exit
echo.
echo ========================================
set /p CHOICE="Enter your choice (1-7): "

if "%CHOICE%"=="1" goto SEARCH_NAME
if "%CHOICE%"=="2" goto SEARCH_EXT
if "%CHOICE%"=="3" goto SEARCH_CONTENT
if "%CHOICE%"=="4" goto SEARCH_MODIFIED
if "%CHOICE%"=="5" goto SEARCH_SIZE
if "%CHOICE%"=="6" goto SEARCH_DUPLICATES
if "%CHOICE%"=="7" goto EXIT
goto MENU

:SEARCH_NAME
cls
echo ========================================
echo Search by File Name
echo ========================================
echo.
set /p FILENAME="Enter file name (use * for wildcards): "
if "%FILENAME%"=="" goto MENU
set /p SEARCHPATH="Enter search path (e.g., C:\Users): "
if "%SEARCHPATH%"=="" goto MENU

echo.
echo Searching for: %FILENAME% in %SEARCHPATH%...
echo ----------------------------------------
dir "%SEARCHPATH%\%FILENAME%" /s /b 2>nul
echo.
pause
goto MENU

:SEARCH_EXT
cls
echo ========================================
echo Search by Extension
echo ========================================
echo.
set /p EXT="Enter extension (e.g., txt, jpg, pdf): "
if "%EXT%"=="" goto MENU
set /p SEARCHPATH="Enter search path: "
if "%SEARCHPATH%"=="" goto MENU

echo.
echo Searching for *.%EXT% files in %SEARCHPATH%...
echo ----------------------------------------
dir "%SEARCHPATH%\*.%EXT%" /s /b 2>nul
echo.
pause
goto MENU

:SEARCH_CONTENT
cls
echo ========================================
echo Search by Content
echo ========================================
echo.
set /p CONTENT="Enter text to search for: "
if "%CONTENT%"=="" goto MENU
set /p SEARCHPATH="Enter search path: "
if "%SEARCHPATH%"=="" goto MENU

echo.
echo Searching for "%CONTENT%" in files...
echo ----------------------------------------
findstr /s /i /m "%CONTENT%" "%SEARCHPATH%\*.*" 2>nul
echo.
pause
goto MENU

:SEARCH_MODIFIED
cls
echo ========================================
echo Search Modified in Last N Days
echo ========================================
echo.
set /p DAYS="Enter number of days: "
if "%DAYS%"=="" goto MENU
set /p SEARCHPATH="Enter search path: "
if "%SEARCHPATH%"=="" goto MENU

echo.
echo Searching for files modified in last %DAYS% days...
echo ----------------------------------------
powershell -Command "Get-ChildItem -Path '%SEARCHPATH%' -Recurse -File -ErrorAction SilentlyContinue | Where-Object {$_.LastWriteTime -gt (Get-Date).AddDays(-%DAYS%)} | Select-Object FullName, LastWriteTime | Format-Table -AutoSize"
echo.
pause
goto MENU

:SEARCH_SIZE
cls
echo ========================================
echo Search by File Size
echo ========================================
echo.
echo 1. Files larger than X MB
echo 2. Files smaller than X MB
echo 3. Files between X and Y MB
echo.
set /p SIZECHOICE="Choose option (1-3): "

if "%SIZECHOICE%"=="1" goto SIZE_LARGER
if "%SIZECHOICE%"=="2" goto SIZE_SMALLER
if "%SIZECHOICE%"=="3" goto SIZE_BETWEEN
goto MENU

:SIZE_LARGER
set /p SIZE="Enter minimum size in MB: "
set /p SEARCHPATH="Enter search path: "
echo.
echo Searching for files larger than %SIZE% MB...
echo ----------------------------------------
powershell -Command "Get-ChildItem -Path '%SEARCHPATH%' -Recurse -File -ErrorAction SilentlyContinue | Where-Object {$_.Length -gt (%SIZE%*1MB)} | Select-Object FullName, @{Name='Size(MB)';Expression={[math]::Round($_.Length/1MB, 2)}} | Format-Table -AutoSize"
pause
goto MENU

:SIZE_SMALLER
set /p SIZE="Enter maximum size in MB: "
set /p SEARCHPATH="Enter search path: "
echo.
echo Searching for files smaller than %SIZE% MB...
echo ----------------------------------------
powershell -Command "Get-ChildItem -Path '%SEARCHPATH%' -Recurse -File -ErrorAction SilentlyContinue | Where-Object {$_.Length -lt (%SIZE%*1MB)} | Select-Object FullName, @{Name='Size(MB)';Expression={[math]::Round($_.Length/1MB, 2)}} | Format-Table -AutoSize"
pause
goto MENU

:SIZE_BETWEEN
set /p MINSIZE="Enter minimum size in MB: "
set /p MAXSIZE="Enter maximum size in MB: "
set /p SEARCHPATH="Enter search path: "
echo.
echo Searching for files between %MINSIZE% MB and %MAXSIZE% MB...
echo ----------------------------------------
powershell -Command "Get-ChildItem -Path '%SEARCHPATH%' -Recurse -File -ErrorAction SilentlyContinue | Where-Object {$_.Length -gt (%MINSIZE%*1MB) -and $_.Length -lt (%MAXSIZE%*1MB)} | Select-Object FullName, @{Name='Size(MB)';Expression={[math]::Round($_.Length/1MB, 2)}} | Format-Table -AutoSize"
pause
goto MENU

:SEARCH_DUPLICATES
cls
echo ========================================
echo Search Duplicate Files
echo ========================================
echo.
set /p SEARCHPATH="Enter search path: "
if "%SEARCHPATH%"=="" goto MENU

echo.
echo Searching for duplicate files by name...
echo This may take a while...
echo ----------------------------------------
powershell -Command "Get-ChildItem -Path '%SEARCHPATH%' -Recurse -File -ErrorAction SilentlyContinue | Group-Object Name | Where-Object {$_.Count -gt 1} | ForEach-Object { Write-Host \"`nDuplicate: $($_.Name)\"; $_.Group | Select-Object FullName | ForEach-Object { Write-Host \"  $($_.FullName)\" } }"
echo.
pause
goto MENU

:EXIT
exit
