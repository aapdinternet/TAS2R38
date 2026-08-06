@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
cd /d "%~dp0"
echo ============================================
echo   Push nach GitHub (TAS2R38)
echo ============================================
echo.

rem --- Haengengebliebene Git-Lock-Dateien entfernen (OneDrive-Problem) ---
del /q /s ".git\*.lock" >nul 2>&1
rmdir /s /q ".git\rebase-merge" >nul 2>&1

rem --- Aktuelle Aenderungen anzeigen ---
echo Aenderungen:
git status --short
echo.

rem --- Lokale Aenderungen (inkl. neue/untracked Dateien) ermitteln ---
set "changes="
for /f "delims=" %%i in ('git status --porcelain') do set "changes=1"

rem --- Falls lokale Aenderungen vorliegen: committen ---
if defined changes (
  set "msg="
  set /p "msg=Commit-Nachricht (Enter = 'update'): "
  if "!msg!"=="" set "msg=update"
  echo.
  echo Committe lokale Aenderungen...
  git add -A
  git commit -m "!msg!"
) else (
  echo Keine neuen lokalen Aenderungen zum Committen.
)

echo.
echo Hole neueste Stand von GitHub (z.B. README.md)...
git pull origin main --no-rebase

echo.
echo Pushe nach origin main...
git push origin main

echo.
if "!errorlevel!"=="0" (
  echo FERTIG - Push erfolgreich.
) else (
  echo FEHLER beim Push - siehe Meldung oben.
)
echo.
pause