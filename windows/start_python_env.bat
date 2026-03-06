@echo off
REM ========================================
REM Start PowerShell with Python Virtual Environment
REM Opens PowerShell in PythonScripts folder with .venv activated
REM ========================================

title Starting Python Environment

echo Starting PowerShell with Python virtual environment...
echo.

REM Change to the target directory and start PowerShell with venv activation
powershell.exe -NoExit -Command "cd 'D:\GitHubProjects\PythonScripts'; & '.\\.venv\\Scripts\\Activate.ps1'"
