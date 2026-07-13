#!/usr/bin/env bash
# ============================================================
#   One-time setup for your website (macOS)
#
#   HOW TO RUN:
#   Open Terminal in the website folder and type:
#       bash setup-mac.sh
#
#   It installs Quarto, installs uv, and installs the small
#   set of Python packages listed in requirements.txt.
#   You only need to do this once.
# ============================================================
set -e
cd "$(dirname "$0")"

echo ""
echo "Step 1 of 3: Installing Quarto..."
if command -v quarto >/dev/null 2>&1; then
    echo "Quarto is already installed. Skipping."
elif command -v brew >/dev/null 2>&1; then
    brew install --cask quarto
else
    echo "Please install Quarto first. Download the macOS installer from"
    echo "    https://quarto.org/docs/get-started"
    echo "then run this file again for the rest."
    exit 1
fi

echo ""
echo "Step 2 of 3: Installing uv (the Python package tool)..."
if command -v uv >/dev/null 2>&1; then
    echo "uv is already installed. Skipping."
else
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi
export PATH="$HOME/.local/bin:$PATH"

echo ""
echo "Step 3 of 3: Installing the Python packages..."
uv venv
uv pip install -r requirements.txt

echo ""
echo "All done. From now on, your day-to-day is:"
echo "  1. Edit pages in VSCode (click Preview to watch live)."
echo "  2. Run 'bash render.sh' to rebuild the site."
echo "  3. Publish with GitHub Desktop (Commit, then Push)."
