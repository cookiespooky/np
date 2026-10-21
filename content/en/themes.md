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

Example from the documentation template (`.np/theme/` there). Other templates and custom `rules.yaml` setups have other page templates.

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
- `.Meta.Title` — the `<title>`: `seo_title`, else `title`
- `.Meta.OpenGraph`, `.Meta.JSONLD`, `.Meta.Robots`
- `.Meta.Alternates` — language versions (`.Lang`, `.URL`) for hreflang
- `.Meta.Published` — the note's `date` as RFC 3339
- `.FeedURL` — the RSS feed address when `feed.enabled` is set
- `.Settings.<key>` — settings from `config.yaml` and the `Site.md` / `Interface.md` notes
- `.FM.<key>` — the note's frontmatter
- `.SearchMode` (`server` or `static`)

## Template functions

Besides Go's built-ins:

- `humanDate value lang` — a frontmatter date as «4 марта 2025» for `ru`, «March 4, 2025» otherwise;
- `isoDate value` — `2025-03-04`, for `<time datetime>`;
- `dict "Key" value …` — several values for one `{{ template }}` call.

```html
<time datetime="{{ isoDate .FM.date }}">{{ humanDate .FM.date "en" }}</time>
{{ template "card.html" (dict "Root" $ "Item" .) }}
```

## Asset serving

- In `serve`: assets are available via `/assets/*`.
- In `build`: assets are copied to `dist/assets/*`.
