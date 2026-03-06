@echo off
REM ========================================
REM Git Quick Commit Tool
REM Quickly stage, commit and push changes
REM ========================================

title Git Quick Commit
color 0E

echo ========================================
echo      GIT QUICK COMMIT TOOL
echo ========================================
echo.

REM Check if git is installed
git --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Git is not installed or not in PATH!
    pause
    exit /b 1
)

REM Check if current directory is a git repository
git rev-parse --git-dir >nul 2>&1
if errorlevel 1 (
    echo ERROR: Current directory is not a Git repository!
    pause
    exit /b 1
)

echo Current Git Status:
echo ----------------------------------------
git status -s
echo.

echo ----------------------------------------
set /p COMMIT_MSG="Enter commit message: "

if "%COMMIT_MSG%"=="" (
    echo ERROR: Commit message cannot be empty!
    pause
    exit /b 1
)

echo.
echo [1/3] Staging all changes...
git add -A

echo [2/3] Committing changes...
git commit -m "%COMMIT_MSG%"

echo [3/3] Pushing to remote...
git push

echo.
echo ========================================
echo Git operations completed!
echo ========================================
pause
