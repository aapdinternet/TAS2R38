@echo off
echo ============================================
echo  Push nach GitHub (TAS2R38)
echo ============================================

:: 1. Verfangene Merges automatisch bereinigen
if exist .git\MERGE_HEAD (
    echo [INFO] Unvollstaendigen Merge entdeckt. Setze zurueck...
    git merge --abort > nul 2>&1
)

:: 2. Lokale Aenderungen committen (falls vorhanden)
git add .
git commit -m "Automatisches Update" > nul 2>&1

:: 3. Neuesten Stand von GitHub holen
echo Hole neuesten Stand von GitHub...
git pull origin main --no-rebase
if %errorlevel% neq 0 (
    echo.
    echo [FEHLER] Pull fehlgeschlagen (Konflikt vorhanden).
    echo Setze lokalen Zustand zurueck...
    git merge --abort > nul 2>&1
    echo Bitte pruefen Sie die Dateien manuell auf Konflikte.
    pause
    exit /b %errorlevel%
)

:: 4. Pushen
echo.
echo Pushe nach origin main...
git push origin main
if %errorlevel% neq 0 (
    echo.
    echo [FEHLER] Push fehlgeschlagen - siehe Meldung oben.
) else (
    echo.
    echo [ERFOLG] Push erfolgreich abgeschlossen!
)

pause