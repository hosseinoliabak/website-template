#!/usr/bin/env bash
# ============================================================
#   One-time setup for your website (Linux, Ubuntu or Debian)
#
#   HOW TO RUN:
#   Open a terminal in the website folder and type:
#       bash setup-linux.sh
#
#   It installs Quarto, installs uv, and installs the small
#   set of Python packages listed in requirements.txt.
#   It may ask for your password once, to install Quarto.
#   You only need to do this once.
#
#   Note: this script downloads the amd64 build of Quarto. On
#   another distribution or an ARM machine, install Quarto by
#   hand from https://quarto.org/docs/get-started and run this
#   file again for the rest.
# ============================================================
set -e
cd "$(dirname "$0")"

echo ""
echo "Step 1 of 3: Installing Quarto..."
if command -v quarto >/dev/null 2>&1; then
    echo "Quarto is already installed. Skipping."
else
    VER=$(curl -s https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest \
          | sed -n 's/.*"tag_name": *"v\([^"]*\)".*/\1/p')
    DEB="/tmp/quarto-${VER}-linux-amd64.deb"
    curl -Lo "$DEB" "https://github.com/quarto-dev/quarto-cli/releases/download/v${VER}/quarto-${VER}-linux-amd64.deb"
    sudo dpkg -i "$DEB" || { sudo apt-get update && sudo apt-get -f install -y; }
    rm -f "$DEB"
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
echo "  3. Publish with the Source Control panel in VSCode (Commit, then Push)."
