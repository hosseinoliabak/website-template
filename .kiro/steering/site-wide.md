---
inclusion: auto
---

# Site-Wide Conventions

These rules apply across the whole Quarto website. They are meant for anyone
(including an AI assistant such as Claude Code) editing this site, so the pages
stay consistent.

## Deployment Workflow

This site is rendered on the author's own computer and served by Cloudflare
Pages from the committed `_site/` folder. There is no build step on
Cloudflare's side.

The steps to publish a change are:

1. Edit the `.qmd` file(s) in VSCode. Use **Preview** to watch changes live.
2. Rebuild the `_site/` folder with the render script (`render.bat` on Windows,
   `bash render.sh` on Linux or macOS). It turns on the `.venv` and runs
   `quarto render`. Each page writes its own reading time into
   `.quarto/_reading-times.json`, and the Notes page reads that file to total
   them, so the script builds a second time whenever those numbers moved. Most
   runs finish after one pass.
3. In GitHub Desktop, write a short summary, click **Commit to main**, then
   **Push origin**.
4. Cloudflare Pages publishes the new `_site/` automatically within about a minute.

Important. Always render before pushing. If `_site/` is not rebuilt, the live
site will not show the change.

### Environment

- Some pages run Python (for plots, tables, or small calculations), so the
  project uses a virtual environment (`.venv`) managed with `uv`.
- The packages are listed in `requirements.txt` and installed by
  `setup-windows.ps1` the first time.
- Install packages by hand with `uv pip install <package>` (never plain `pip`),
  or all at once with `uv pip install -r requirements.txt`.
- **Rendering must use that `.venv`.** On Windows, double-click `render.bat`.
  On Linux or macOS, run `bash render.sh`. Both turn on the `.venv` and then
  run `quarto render`. From a terminal the equivalent is activating the venv
  (`.venv\Scripts\activate` on Windows, `source .venv/bin/activate` elsewhere)
  and then `quarto render`.

## Adding and Removing Pages

- Notes live in the `notes/` folder. To add a note, copy an existing `.qmd`
  file, rename it, and edit it. It appears on the Notes page automatically
  because that page uses a Quarto `listing:`. No `_quarto.yml` edit is needed.
- Only edit `_quarto.yml` to change the top menu, the site title, or the theme.

## Page Metadata (SEO)

Every content page must include a `description` line in its front matter, right
after `title`. It becomes the page's search-engine and social-preview summary.

- Write one sentence, roughly 120 to 155 characters.
- Summarize what the page is about, do not just repeat the title.

```yaml
---
title: "My First Note"
description: "A short, plain sentence describing what this page covers."
date: "2026-01-01"
---
```

## Math Notation

- Inline math goes between single dollar signs, for example `$E = mc^2$`.
- Displayed (centered) math goes between double dollar signs `$$ ... $$`.
- Keep notation consistent within a page. If a symbol means one thing, do not
  reuse it for something else later.

## Style

The following are the site owner's writing preferences. Keep them for a
consistent voice, or adjust them to taste. They are conventions, not
technical requirements.

- Prefer clear, plain language aimed at a general reader.
- The source site avoids em dashes, contractions, and colons used to introduce
  a list or explanation in prose. Rewrite sentences into separate clauses
  instead. (Colons in times, URLs, math, and code are fine.)
- Section headings (`##` and `###`) do not start with an article (the, a, an).
- When adding new CSS, append it to the global `styles.css` rather than making
  per-page styles, unless the style is truly specific to one page.

## Themes and Colors

The site loads the Flatly Bootstrap theme and then overrides it in
`styles.css`. Four color themes and three font themes ship with it, cycled by
the two round buttons in the bottom-right corner (`theme-toggle.js`). A theme
is a CSS class on `<html>`, and the default theme is the absence of a class.

- Never hardcode an accent color on a button, badge, focus ring, or any other
  control. Use the tokens that every theme redefines near the top of
  `styles.css`.
  - `var(--site-accent)` for an accent fill, border, or text color.
  - `var(--site-accent-contrast)` for text sitting on an accent fill. Do not
    write `color: #fff` next to an accent background, because the midnight
    theme needs near-black text there.
  - `var(--site-accent-hover)`, `var(--site-accent-soft)`,
    `var(--site-accent-ring)`, and `var(--site-accent-muted)` for hover
    states, tinted fills, focus rings, and faint states.
- Colors that carry meaning rather than branding stay hardcoded. Plot palettes
  and red or green status colors do not use the accent tokens.
- Font families are never named outside the token block. `--site-font-body`,
  `--site-font-heading`, `--site-font-size`, and `--site-line-height` are what
  the font themes swap.

## Git Safety

- Never run git commands (commit, push, checkout, reset) unless explicitly
  asked. The author publishes through GitHub Desktop by hand.
