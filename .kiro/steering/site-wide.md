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

1. Edit the `.qmd` file(s) in VSCode. Use `quarto preview` to watch changes live.
2. Render the whole site with `quarto render` (or click **Render** in VSCode).
   This rebuilds the `_site/` folder.
3. In GitHub Desktop, write a short summary, click **Commit to main**, then
   **Push origin**.
4. Cloudflare Pages publishes the new `_site/` automatically within about a minute.

Important. Always render before pushing. If `_site/` is not rebuilt, the live
site will not show the change.

### Environment

- Python is optional. A prose and math site renders with Quarto alone.
- If a page runs Python (for a plot or table), the project uses a virtual
  environment managed with `uv`.
- Install packages with `uv pip install <package>` (never plain `pip`).
- Install everything from the list with `uv pip install -r requirements.txt`.

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
- The site uses the Flatly Bootstrap theme with a custom `styles.css`.

## Git Safety

- Never run git commands (commit, push, checkout, reset) unless explicitly
  asked. The author publishes through GitHub Desktop by hand.
