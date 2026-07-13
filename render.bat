@echo off
REM ============================================================
REM   Build the whole website (Windows)
REM
REM   Double-click this file to rebuild every page into the
REM   _site folder. It first turns on the private Python space
REM   so pages that draw plots or run code work correctly.
REM
REM   Do this before you publish in GitHub Desktop.
REM ============================================================

call ".venv\Scripts\activate.bat"
quarto render

echo.
echo Done. You can close this window.
pause
