# Professor Website Template

A stripped-down Quarto website that carries the look and structure of the
source site, with placeholder content. Supports prose, math, and pages that run
Python for plots, without any heavy toolchain.

Last refreshed from the source site on 2026-08-14.

## What is in here

| File / folder | What it is |
|---|---|
| `_quarto.yml` | Site config: title, menu, theme, layout. **Edit the title, description, and site-url near the top.** |
| `styles.css` | The full visual theme. Copied verbatim from the source site, so it can be refreshed with a single copy. It carries four color themes, three font themes, and the accent tokens every control reads. Some rules style features this template does not ship; unused CSS is inert. |
| `index.qmd`, `about.qmd` | Home and About pages. |
| `notes/` | Content pages. `index.qmd` auto-lists every note and totals their reading times. `first-note.qmd` is a prose + math example; `example-with-a-plot.qmd` shows a page that runs Python to draw a chart. |
| `theme-toggle.js` | The two round buttons in the bottom-right corner. 🎨 cycles four color themes (default indigo, flatly, warm, midnight), Aa cycles three font themes (default, reader, Garamond). Both are remembered per browser. Printing always reverts to Garamond on white. |
| `resume-reading.js` | Remembers the page and scroll position, then offers to take the reader back. |
| `search-scope.js` | Adds scope pills to the search overlay. The scopes are derived from the navbar at load time, so a new menu section needs no edit here. |
| `review-numbering.js` | Renumbers review questions on the page, so every question can be written as `**1.` in the source. |
| `_extensions/reading-time/` | Estimated reading time per page, from prose, figures, math, and code, scaled by an optional `difficulty` (1-5). Also totals a folder on its `index` page. Required by `_quarto.yml`. |
| `.kiro/steering/` | Authoring conventions (also readable by an AI assistant). |
| `setup-windows.ps1` | One-time installer for Windows. Right-click → Run with PowerShell. Installs Quarto + uv + the packages. |
| `setup-linux.sh`, `setup-mac.sh` | The same one-time installer for Linux (Ubuntu/Debian) and macOS. Run with `bash setup-linux.sh` / `bash setup-mac.sh`. |
| `render.bat` | Windows: double-click to rebuild the site. Turns on the `.venv` first so Python pages render. Run before publishing. |
| `render.sh` | Linux/macOS: `bash render.sh` does the same. |
| `requirements.txt` | Python packages for pages that run code (jupyter, numpy, matplotlib, pandas). Installed by the setup script. |
| `.gitignore` | Tracks source **and** the rendered `_site/` (Cloudflare serves `_site`). |
| `CHEATSHEET.md` | One-page daily workflow to print for the professor. |

## What the reader gets

- Four color themes and three font themes, chosen with the two corner buttons
  and kept in that browser.
- An estimated reading time and an optional difficulty rating on each page,
  plus a total on the Notes page.
- A prompt to resume the page they were last reading, at the scroll position
  they left.
- Search that can be narrowed to one section of the site.
- Printing that ignores the screen theme and lays the page out in Garamond on
  white.

Everything above is client-side and stores nothing off the reader's machine.

## Why the render script sometimes builds twice

Each page writes its own reading time into `.quarto/_reading-times.json`, and
the Notes page reads that file to total them. A page whose time just changed
therefore leaves the Notes page one build behind. `render.sh` and `render.bat`
snapshot that file, render, and render a second time only when the numbers
moved. Most runs finish after one pass.

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

## Refreshing from the source site

`styles.css`, `search-scope.js`, `review-numbering.js`, and
`_extensions/reading-time/reading-time.lua` are copies and can be replaced
wholesale from the source site. Two files have deliberately diverged and must
not be overwritten:

- `theme-toggle.js` here has no giscus wiring and no typography-tool API, which
  the source site's copy carries.
- `resume-reading.js` here is local-storage only. The source site's copy also
  mirrors progress to a signed-in account.

The reading-time filter's source-file lookup lists `notes/` here instead of the
source site's course folders.

## Things dropped from the source site (add back only if wanted)

- **Sign-in and cross-device progress** (needs a Firebase project, and brings
  account deletion and retention duties with it).
- **giscus comments** (needs a GitHub Discussions repo and IDs).
- **The browser tools** (chess, astronomy, networking calculators, pastebin).
- **QR margin header**, **yang.xml** syntax, and the course-listing/iconify
  extensions (course-specific).
- **Breadcrumb trail, multi-column navbar menus, and the home-page reading
  history**, which exist for a site with many nested sections.
- The full pinned `requirements.txt` with TensorFlow etc. (replaced with four
  packages).

## Note on Cloudflare and _site

Because he renders locally and commits `_site/`, Cloudflare does not build
anything, it just serves the folder. The one failure mode: if he forgets to run
`quarto render` before pushing, the live site keeps the old content. Build that
habit during the first practice loop.
