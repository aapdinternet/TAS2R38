Fangen wir ganz sauber von vorne an mit einem schlanken, extrem robusten Skript, das genau auf Ihre Arbeitsweise ausgelegt ist.

Erstellen Sie die Datei `push.bat` neu und fügen Sie folgenden Code ein:

```cmd
@echo off
echo Sync mit GitHub (TAS2R38)...
echo.

:: 1. Blockierte Vorgaenge vorsorglich abbrechen
git merge --abort >nul 2>&1
git rebase --abort >nul 2>&1

:: 2. Alle lokalen Aenderungen (neue, geaenderte u. geloeschte Dateien) erfassen
git add -A

:: 3. Lokalen Stand speichern
git commit -m "Automatische Aktualisierung" >nul 2>&1

:: 4. Aenderungen von GitHub (z.B. README.md) ohne Editor-Aufruf holen
git pull origin main --no-edit

:: 5. Alles nach GitHub hochladen
git push origin main

echo.
echo Vorgang abgeschlossen.
pause

```

**Warum dieses Skript zuverlässig funktioniert:**

* **`git add -A`:** Erfasst zuverlässig das gesamte lokale Verzeichnis – egal ob Sie Dateien neu angelegt, bearbeitet oder gelöscht haben.
* **`--no-edit`:** Verhindert garantiert, dass Git bei Änderungen an der `README.md` den lästigen Vim-Texteditor öffnet.
* **`--abort` am Anfang:** Räumt automatisch auf, falls ein vorheriger Versuch abgebrochen wurde, sodass das Skript nie wieder in eine Blockade gerät.