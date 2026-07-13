#!/usr/bin/env bash
# ============================================================
#   Build the whole website (Linux and macOS)
#
#   Run it from a terminal in the website folder:
#       bash render.sh
#
#   It turns on the private Python space (.venv) and rebuilds
#   every page into the _site folder, so pages that draw plots
#   or run code work correctly. Do this before you publish.
#
#   (On Windows, double-click render.bat instead.)
# ============================================================
set -e
cd "$(dirname "$0")"

if [ ! -d ".venv" ]; then
    echo "The .venv folder is missing. Run the setup script first"
    echo "(setup-linux.sh or setup-mac.sh)."
    exit 1
fi

source .venv/bin/activate
quarto render

echo ""
echo "Done. You can close this window."
