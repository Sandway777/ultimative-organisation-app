@echo off
cd /d "%~dp0"
echo Sichere aktuellen Stand auf GitHub...
git add -A
git commit -m "Update %date% %time%"
git push
echo.
pause
