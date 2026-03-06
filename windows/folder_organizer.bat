@echo off
REM ========================================
REM Folder Organizer
REM Organizes files by extension into folders
REM ========================================

title Folder Organizer
color 0D

echo ========================================
echo      FOLDER ORGANIZER
echo ========================================
echo.

REM Set target folder (current directory by default)
set TARGET=%cd%

echo Target Folder: %TARGET%
echo.
echo This will organize files by extension.
echo Press Ctrl+C to cancel or any key to continue...
pause >nul

echo.
echo Organizing files...
echo.

REM Create folders for common file types
if not exist "%TARGET%\Images" mkdir "%TARGET%\Images"
if not exist "%TARGET%\Documents" mkdir "%TARGET%\Documents"
if not exist "%TARGET%\Videos" mkdir "%TARGET%\Videos"
if not exist "%TARGET%\Music" mkdir "%TARGET%\Music"
if not exist "%TARGET%\Archives" mkdir "%TARGET%\Archives"
if not exist "%TARGET%\Executables" mkdir "%TARGET%\Executables"
if not exist "%TARGET%\Others" mkdir "%TARGET%\Others"

REM Move image files
echo Moving image files...
move "%TARGET%\*.jpg" "%TARGET%\Images\" 2>nul
move "%TARGET%\*.jpeg" "%TARGET%\Images\" 2>nul
move "%TARGET%\*.png" "%TARGET%\Images\" 2>nul
move "%TARGET%\*.gif" "%TARGET%\Images\" 2>nul
move "%TARGET%\*.bmp" "%TARGET%\Images\" 2>nul
move "%TARGET%\*.svg" "%TARGET%\Images\" 2>nul

REM Move document files
echo Moving document files...
move "%TARGET%\*.pdf" "%TARGET%\Documents\" 2>nul
move "%TARGET%\*.doc" "%TARGET%\Documents\" 2>nul
move "%TARGET%\*.docx" "%TARGET%\Documents\" 2>nul
move "%TARGET%\*.txt" "%TARGET%\Documents\" 2>nul
move "%TARGET%\*.xls" "%TARGET%\Documents\" 2>nul
move "%TARGET%\*.xlsx" "%TARGET%\Documents\" 2>nul
move "%TARGET%\*.ppt" "%TARGET%\Documents\" 2>nul
move "%TARGET%\*.pptx" "%TARGET%\Documents\" 2>nul

REM Move video files
echo Moving video files...
move "%TARGET%\*.mp4" "%TARGET%\Videos\" 2>nul
move "%TARGET%\*.avi" "%TARGET%\Videos\" 2>nul
move "%TARGET%\*.mkv" "%TARGET%\Videos\" 2>nul
move "%TARGET%\*.mov" "%TARGET%\Videos\" 2>nul
move "%TARGET%\*.wmv" "%TARGET%\Videos\" 2>nul

REM Move music files
echo Moving music files...
move "%TARGET%\*.mp3" "%TARGET%\Music\" 2>nul
move "%TARGET%\*.wav" "%TARGET%\Music\" 2>nul
move "%TARGET%\*.flac" "%TARGET%\Music\" 2>nul
move "%TARGET%\*.m4a" "%TARGET%\Music\" 2>nul

REM Move archive files
echo Moving archive files...
move "%TARGET%\*.zip" "%TARGET%\Archives\" 2>nul
move "%TARGET%\*.rar" "%TARGET%\Archives\" 2>nul
move "%TARGET%\*.7z" "%TARGET%\Archives\" 2>nul
move "%TARGET%\*.tar" "%TARGET%\Archives\" 2>nul
move "%TARGET%\*.gz" "%TARGET%\Archives\" 2>nul

REM Move executable files
echo Moving executable files...
move "%TARGET%\*.exe" "%TARGET%\Executables\" 2>nul
move "%TARGET%\*.msi" "%TARGET%\Executables\" 2>nul

echo.
echo ========================================
echo Organization Complete!
echo ========================================
pause
