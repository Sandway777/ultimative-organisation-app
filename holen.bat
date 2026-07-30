@echo off
cd /d "%~dp0"

echo ============================================
echo   Hole neuesten Stand von GitHub...
echo ============================================
echo.

git remote get-url origin >nul 2>&1
if errorlevel 1 (
    echo Es ist noch kein GitHub-Repo verbunden.
    echo.
    pause
    exit /b 1
)

REM --- Warnen, wenn lokal noch ungespeicherte Aenderungen liegen ---
git diff --quiet --exit-code HEAD 2>nul
if errorlevel 1 (
    echo ACHTUNG: Du hast lokale Aenderungen, die noch nicht gespeichert sind:
    git status --short
    echo.
    echo Bitte erst "speichern.bat" ausfuehren, sonst gibt es Konflikte.
    echo.
    pause
    exit /b 1
)

git pull --rebase
if errorlevel 1 (
    echo.
    echo FEHLER beim Holen. Bitte Meldung oben pruefen.
    echo.
    pause
    exit /b 1
)

echo.
echo ============================================
echo   Fertig - du hast den neuesten Stand.
echo ============================================
echo.
pause
