# Professor Website Template

A stripped-down Quarto website that carries the look and structure of the
source site, with placeholder content. Supports prose, math, and pages that run
Python for plots, without any heavy toolchain.

## What is in here

| File / folder | What it is |
|---|---|
| `_quarto.yml` | Site config: title, menu, theme, layout. **Edit the title, description, and site-url near the top.** |
| `styles.css` | The full visual theme (colors, fonts). Copied verbatim from the source site. |
| `index.qmd`, `about.qmd` | Home and About pages. |
| `notes/` | Content pages. `index.qmd` auto-lists every note. `first-note.qmd` is a prose + math example; `example-with-a-plot.qmd` shows a page that runs Python to draw a chart. |
| `theme-toggle.js`, `resume-reading.js`, `search-scope.js`, `review-numbering.js` | Client-side UX (dark/light toggle, resume reading, scoped search, review-question numbering). |
| `_extensions/reading-time/` | Adds an estimated reading time to each page. Required by `_quarto.yml`. |
| `.kiro/steering/` | Authoring conventions (also readable by an AI assistant). |
| `setup-windows.ps1` | One-time installer for Windows. Right-click → Run with PowerShell. Installs Quarto + uv + the packages. |
| `setup-linux.sh`, `setup-mac.sh` | The same one-time installer for Linux (Ubuntu/Debian) and macOS. Run with `bash setup-linux.sh` / `bash setup-mac.sh`. |
| `render.bat` | Windows: double-click to rebuild the site. Turns on the `.venv` first so Python pages render. Run before publishing. |
| `render.sh` | Linux/macOS: `bash render.sh` does the same. |
| `requirements.txt` | Python packages for pages that run code (jupyter, numpy, matplotlib, pandas). Installed by the setup script. |
| `.gitignore` | Tracks source **and** the rendered `_site/` (Cloudflare serves `_site`). |
| `CHEATSHEET.md` | One-page daily workflow to print for the professor. |

## One-time setup (you do this)

1. Push this folder to a new GitHub repo. On GitHub, Settings → check
   **"Template repository"** so future sites start with "Use this template."
2. On his machine: install **Quarto**, the VSCode **Quarto extension**, and
   **GitHub Desktop**.
3. Clone the repo to his machine with GitHub Desktop.
4. Run the setup script for his machine, once. Windows: right-click
   `setup-windows.ps1` → **Run with PowerShell**. Linux: `bash setup-linux.sh`.
   macOS: `bash setup-mac.sh`. It installs Quarto, uv, and the packages.
   (This is the single "run" the professor does.)
5. Edit `_quarto.yml`: set `title`, `description`, and `site-url`.
6. Render once by double-clicking `render.bat` (or `source .venv/bin/activate &&
   quarto render` on your own machine). Confirm a Python page such as
   `example-with-a-plot` renders its chart.
7. Cloudflare Pages → connect the GitHub repo → **Framework preset: None**,
   **Build command: (empty)**, **Output directory: `_site`**. Deploy.
8. Confirm the live URL loads, then do the first edit-render-push loop together.

Note on Preview: for the live **Preview** button to run Python, VSCode must use
the `.venv`. The included `.vscode/settings.json` points at it, but the first
time you may need to pick it once with **Python: Select Interpreter** (choose the
one under `.venv`). `render.bat` does not depend on this, it always uses `.venv`.

## Things dropped from the source site (add back only if wanted)

- **giscus comments** (needs a GitHub Discussions repo and IDs).
- **QR margin header**, **yang.xml** syntax, and the course-listing/iconify
  extensions (course-specific).
- The full pinned `requirements.txt` with TensorFlow etc. (replaced with three
  packages).

## Note on Cloudflare and _site

Because he renders locally and commits `_site/`, Cloudflare does not build
anything, it just serves the folder. The one failure mode: if he forgets to run
`quarto render` before pushing, the live site keeps the old content. Build that
habit during the first practice loop.
