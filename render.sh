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
#
#   Why it sometimes builds twice: every page writes its own
#   reading time into .quarto/_reading-times.json while the
#   Notes page reads that same file to total them up. A page
#   whose time just changed therefore leaves the Notes page one
#   build behind. This script notices when the numbers moved
#   and builds a second time to settle them. Most runs change
#   nothing and finish after the first pass.
# ============================================================
set -e
cd "$(dirname "$0")"

if [ ! -d ".venv" ]; then
    echo "The .venv folder is missing. Run the setup script first"
    echo "(setup-linux.sh or setup-mac.sh)."
    exit 1
fi

source .venv/bin/activate

RT=".quarto/_reading-times.json"
BEFORE="$(mktemp)"
trap 'rm -f "$BEFORE"' EXIT
if [ -f "$RT" ]; then cp "$RT" "$BEFORE"; else : > "$BEFORE"; fi

quarto render

if ! cmp -s "$BEFORE" "$RT"; then
    echo ""
    echo "Reading times changed. Building once more so the totals catch up..."
    quarto render
fi

echo ""
echo "Done. You can close this window."
