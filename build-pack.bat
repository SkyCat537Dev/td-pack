@echo off
REM Rebuilds resourcepack.zip from the assets in this folder and prints the SHA1
REM that server.properties needs. The work is in build-pack.ps1, because a zip
REM entry name has to use forward slashes and Windows PowerShell 5.1's
REM Compress-Archive writes backslashes, which produces a pack the client
REM applies and then finds nothing inside.
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0build-pack.ps1"
echo.
echo Commit and push, then the raw link serves the new file.
pause
