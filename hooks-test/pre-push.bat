@echo off
REM Block push if any staged .env files exist
git diff --cached --name-only | findstr /R "\.env$" >nul
IF %ERRORLEVEL% EQU 0 (
    echo Push blocked: .env files are staged for commit.
    exit /b 1
)
exit /b 0