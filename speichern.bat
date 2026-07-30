@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo ============================================
echo   Sichere aktuellen Stand auf GitHub...
echo ============================================
echo.

REM --- Pruefen, ob es ueberhaupt etwas zu speichern gibt ---
git diff --quiet --exit-code HEAD 2>nul
set HAT_AENDERUNG=%errorlevel%
git ls-files --others --exclude-standard >"%TEMP%\nb_neu.txt" 2>nul
for %%A in ("%TEMP%\nb_neu.txt") do set NEU_GROESSE=%%~zA
del "%TEMP%\nb_neu.txt" >nul 2>&1

if "%HAT_AENDERUNG%"=="0" if "%NEU_GROESSE%"=="0" (
    echo Keine Aenderungen vorhanden - nichts zu speichern.
    git remote get-url origin >nul 2>&1
    if not errorlevel 1 (
        echo.
        echo Hole trotzdem neuesten Stand vom Laptop...
        git pull --rebase
    )
    echo.
    pause
    exit /b 0
)

REM --- Zufaelligen Titel bauen: Verb + Thema ---
set V1=Stand gesichert
set V2=Zwischenstand
set V3=Fortschritt
set V4=Weiter gebaut
set V5=Aktualisiert
set V6=Verbessert
set V7=Ueberarbeitet
set V8=Angepasst

set /a R=%RANDOM% %% 8 + 1
for /f "delims=" %%V in ("!V%R%!") do set VERB=%%V

REM --- Datum sauber als JJJJ-MM-TT HH:MM formatieren ---
for /f "delims=" %%D in ('powershell -NoProfile -Command "Get-Date -Format \"yyyy-MM-dd HH:mm\"" 2^>nul') do set "STAMP=%%D"

REM --- Geaenderte Dateien als Detail in die Commit-Message ---
echo Aenderungen:
git status --short
echo.

git add -A
git commit -m "!VERB! (!STAMP!)" -m "Automatisch gespeichert durch speichern.bat"
if errorlevel 1 (
    echo.
    echo FEHLER beim Commit. Abbruch - es wurde nichts hochgeladen.
    echo.
    pause
    exit /b 1
)

REM --- Ist ueberhaupt ein GitHub-Repo verbunden? ---
git remote get-url origin >nul 2>&1
if errorlevel 1 (
    echo.
    echo Gespeichert als: !VERB! (!STAMP!)
    echo.
    echo ############################################
    echo #                                          #
    echo #   ACHTUNG: NICHT AUF GITHUB!             #
    echo #                                          #
    echo ############################################
    echo.
    echo Es ist kein GitHub-Repo verbunden. Dein Stand liegt
    echo NUR auf diesem Computer - nicht in der Cloud.
    echo.
    echo So verbindest du es einmalig:
    echo    git remote add origin https://github.com/DEIN-NAME/DEIN-REPO.git
    echo    git push -u origin main
    echo.
    pause
    exit /b 1
)

REM --- Erst holen (Laptop-Stand), dann hochladen ---
echo.
echo Hole erst neuesten Stand vom Laptop...
git pull --rebase
if errorlevel 1 (
    echo.
    echo ACHTUNG: Konflikt beim Zusammenfuehren!
    echo Dein Commit ist lokal gespeichert, aber NICHT hochgeladen.
    echo Bitte Konflikt loesen, dann "git rebase --continue" und erneut speichern.
    echo.
    pause
    exit /b 1
)

echo.
echo Lade auf GitHub hoch...
git push
if errorlevel 1 (
    echo.
    echo ############################################
    echo #   FEHLER: NICHT HOCHGELADEN!             #
    echo ############################################
    echo.
    echo Dein Stand ist lokal gespeichert, aber NICHT auf GitHub.
    echo.
    echo Haeufigste Ursache: du bist nicht bei GitHub angemeldet.
    echo Anmelden mit:  gh auth login
    echo Pruefen mit:   gh auth status
    echo.
    pause
    exit /b 1
)

echo.
echo ============================================
echo   Fertig! Gespeichert als: !VERB! (!STAMP!)
echo ============================================
echo.
echo Erfolgreich auf GitHub hochgeladen:
for /f "delims=" %%U in ('git remote get-url origin 2^>nul') do echo    %%U
echo.
pause
