@echo off
setlocal
cd /d "%~dp0"
title TEOcean Upstream Localization
where node.exe >nul 2>&1
if errorlevel 1 (
  echo Node.js was not found in PATH.
  echo Install Node.js and try again.
  pause
  exit /b 1
)
node.exe "%~dp0server.js" %*
set "EXIT_CODE=%ERRORLEVEL%"
endlocal & exit /b %EXIT_CODE%
