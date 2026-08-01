@echo off
REM Rebuilds resourcepack.zip from the assets in this folder and prints the SHA1
REM that server.properties needs.
cd /d "%~dp0"
if exist resourcepack.zip del resourcepack.zip
powershell -NoProfile -Command "Compress-Archive -Path assets,pack.mcmeta,pack.png -DestinationPath resourcepack.zip -Force"
echo.
echo New SHA1:
powershell -NoProfile -Command "(Get-FileHash resourcepack.zip -Algorithm SHA1).Hash.ToLower()"
echo.
echo Commit and push, then the raw link serves the new file.
pause
