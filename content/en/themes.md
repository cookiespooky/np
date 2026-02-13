---
type: article_en
slug: themes
title: Themes and Templates
description: Theme structure, template contract, and fallback behavior.
hub: operations
order: 3
draft: false
lang: en
---

Theme is loaded from `<theme.dir>/<theme.name>/` in repository root.

## Structure

Recipe repository example. It can differ when custom `rules.yaml` setup is used.

```text
<theme>/
  templates/
    layout.html
    home.html
    page.html
    article.html
    hub.html
    search.html
    notfound.html
  assets/
    styles.css
    main.js
    favicon.ico
```

## Template selection

- `layout.html` is the common wrapper.
- Route `/` uses home logic.
- For pages, `rules.types.<type>.template` is used.
- If files are missing, engine falls back to embedded templates/assets.

## Data in templates

Most commonly used values:

- `.Title`, `.Description`, `.Canonical`, `.BaseURL`
- `.Page.Type`, `.Page.Slug`, `.Page.Title`
- `.Body` (rendered HTML)
- `.Collections` (evaluated collections)
- `.Meta.OpenGraph`, `.Meta.JSONLD`
- `.SearchMode` (`server` or `static`)

## Asset serving

- In `serve`: assets are available via `/assets/*`.
- In `build`: assets are copied to `dist/assets/*`.
