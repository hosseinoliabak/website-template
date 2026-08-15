---
inclusion: fileMatch
fileMatchPattern: "notes/*.qmd"
---

# Writing a Note Page

Rules for writing or editing a `.qmd` file in the `notes/` folder.

## Front Matter

Every note starts with a front-matter block between two `---` lines:

```yaml
---
title: "The Page Title"
description: "One plain sentence about what the page covers."
date: "YYYY-MM-DD"
categories: [topic-tag]
difficulty: 2
---
```

- `title` is what shows at the top of the page and in the Notes list.
- `description` is required (used for search engines and the Notes list).
- `date` controls the order on the Notes page (newest first). Use today's date.
- `categories` is optional. It groups related notes with clickable tags.
- `difficulty` is optional, from 1 to 5. It draws the filled circles under the
  title and scales the estimated reading time (0.85, 1.0, 1.2, 1.5, 2.0), so a
  dense page is not sold as a quick read. Rate 1 for light reading, 3 for
  standard technical content, and 5 for material that needs pen and paper.
- `show-reading-time: false` hides the estimate on a page where it makes no
  sense, such as a landing page.

The estimate itself comes from the prose, the figures, the mathematics, and the
code, each billed separately. Change a page's `difficulty` rather than padding
the words when the number looks wrong.

## Structure

- Start with a short introductory sentence before any list or heading. Do not
  jump straight into bullet points under a heading.
- Use `##` for main sections and `###` for sub-sections.
- Keep paragraphs short. Leave a blank line between them.

## Common Elements

- Bold with `**text**`, italic with `*text*`.
- Links: `[visible words](../index.qmd)` for a page, or a full `https://` URL.
- Lists use `-` at the start of a line.
- Inline math `$...$`, displayed math `$$...$$`. No setup needed.
- Note or tip boxes use callouts:

```
::: {.callout-note}
A short remark or tip.
:::
```

## Review Questions (optional)

To add practice questions at the end of a section, use this pattern. The
questions are renumbered automatically on the page, so always write `**1.`
for every question.

```
### Review Questions {.unnumbered}

**1. The question text goes here?**

::: {.callout-tip collapse="true"}
## Answer
The answer, revealed when the reader clicks.
:::
```

Separate multiple questions with a line containing only `---`.

## Images and Data

- Put image and data files in the `media/` folder at the project root.
- Reference an image in text with an absolute path from the root, for example
  `![A caption](/media/photo.png)`.

## Do Not

- Do not add manual "Previous" or "Next" links. Quarto adds page navigation.
- Do not invent facts. If reference material is provided, follow it and check
  claims, dates, and names before writing them.
