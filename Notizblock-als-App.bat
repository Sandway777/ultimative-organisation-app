@echo off
REM Legt eine Desktop-Verknuepfung an, die den Notizblock als eigenstaendiges
REM Fenster oeffnet - ohne Adressleiste, mit eigenem Icon, wie ein Programm.
REM
REM Gearbeitet wird mit Chrome/Edge im App-Modus (--app=). Das ist derselbe
REM Weg, den auch "Installieren" im Browser nimmt, nur als Verknuepfung.

setlocal

echo.
echo   Notizblock als App einrichten
echo   =============================
echo.

REM --- Adresse waehlen: online (ueberall gleich) oder lokal ---------------
set "ONLINE=https://sandway777.github.io/ultimative-organisation-app/"
set "LOKAL=file:///%~dp0index.html"
set "LOKAL=%LOKAL:\=/%"

echo   1 = Online-Version  (empfohlen, synchron mit Handy)
echo   2 = Lokale Datei    (nur dieser Rechner)
echo.
set /p WAHL="   Welche Version? [1/2]: "

if "%WAHL%"=="2" (
  set "ZIEL=%LOKAL%"
  set "NAME=Notizblock (lokal)"
) else (
  set "ZIEL=%ONLINE%"
  set "NAME=Notizblock"
)

REM --- Browser suchen ----------------------------------------------------
set "BROWSER="
for %%P in (
  "%ProgramFiles%\Google\Chrome\Application\chrome.exe"
  "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
  "%LocalAppData%\Google\Chrome\Application\chrome.exe"
  "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
  "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
) do (
  if exist "%%~P" if not defined BROWSER set "BROWSER=%%~P"
)

if not defined BROWSER (
  echo.
  echo   Kein Chrome oder Edge gefunden. Ohne den geht der App-Modus nicht.
  pause
  exit /b 1
)

REM --- Icon vorbereiten (PNG nach ICO ueber PowerShell) -------------------
set "ICON=%~dp0notizblock.ico"

REM Immer neu bauen, damit ein ausgetauschtes Logo auch ankommt.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0icon-bauen.ps1"

REM --- Verknuepfung auf dem Desktop anlegen -------------------------------
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$s=(New-Object -ComObject WScript.Shell);" ^
  "$lnk=$s.CreateShortcut([IO.Path]::Combine([Environment]::GetFolderPath('Desktop'),'%NAME%.lnk'));" ^
  "$lnk.TargetPath='%BROWSER%';" ^
  "$lnk.Arguments='--app=%ZIEL%';" ^
  "$lnk.WorkingDirectory=(Split-Path '%BROWSER%');" ^
  "if(Test-Path '%ICON%'){ $lnk.IconLocation='%ICON%,0' } else { $lnk.IconLocation='%BROWSER%,0' };" ^
  "$lnk.Description='Ultimativer Notizblock';" ^
  "$lnk.Save();"

if errorlevel 1 (
  echo.
  echo   Die Verknuepfung konnte nicht angelegt werden.
  pause
  exit /b 1
)

REM Iconcache auffrischen - sonst zeigt der Desktop weiter das alte Bild.
ie4uinit.exe -show >nul 2>&1

echo.
echo   Fertig. Auf dem Desktop liegt jetzt "%NAME%".
echo   Oeffnet sich in einem eigenen Fenster, ohne Adressleiste.
echo.
echo   Tipp: Verknuepfung anfassen und auf die Taskleiste ziehen,
echo   dann ist sie dauerhaft unten angeheftet.
echo.
pause
