@echo off
REM ============================================================
REM   Build the whole website (Windows)
REM
REM   Double-click this file to rebuild every page into the
REM   _site folder. It first turns on the private Python space
REM   so pages that draw plots or run code work correctly.
REM
REM   Do this before you publish in GitHub Desktop.
REM
REM   Why it sometimes builds twice: every page writes its own
REM   reading time into .quarto\_reading-times.json while the
REM   Notes page reads that same file to total them up. A page
REM   whose time just changed therefore leaves the Notes page
REM   one build behind. This file notices when the numbers moved
REM   and builds a second time to settle them. Most runs change
REM   nothing and finish after the first pass.
REM ============================================================

call ".venv\Scripts\activate.bat"

set "RT=.quarto\_reading-times.json"
set "BEFORE=%TEMP%\_reading-times-before.json"
if exist "%RT%" (copy /Y "%RT%" "%BEFORE%" >nul) else (break > "%BEFORE%")

quarto render

fc "%BEFORE%" "%RT%" >nul 2>&1
if errorlevel 1 (
    echo.
    echo Reading times changed. Building once more so the totals catch up...
    quarto render
)
del "%BEFORE%" >nul 2>&1

echo.
echo Done. You can close this window.
pause
