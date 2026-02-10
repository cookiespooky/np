---
type: article_en
slug: themes
title: Themes and Templates
description: Theme directory layout, template contract, and fallback behavior.
hub: operations
order: 3
draft: false
lang: en
---

Themes are loaded from:

`<theme.dir>/<theme.name>/`

## Recommended structure

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

- `layout.html` is the wrapper.
- Home route (`/`) uses home template logic.
- For each page, Notepub uses template from `rules.types.<type>.template`.
- Missing custom files can fall back to embedded theme assets/templates.

## Data exposed to templates

Common fields include:

- `.Title`, `.Description`, `.Canonical`, `.BaseURL`
- `.Page.Type`, `.Page.Slug`, `.Page.Title`
- `.Body` rendered HTML
- `.Collections` map of evaluated collections
- `.Meta.OpenGraph`, `.Meta.JSONLD`
- `.SearchMode` (`server` or `static`)

## Asset serving

- Serve mode: assets available under `/assets/*`.
- Build mode: assets copied to `dist/assets/*`.
