---
type: article_en
slug: content-model
title: Content Model and Routing
description: How frontmatter, types, and permalinks define site structure.
hub: concepts
order: 2
draft: false
lang: en
---

Notepub does not infer a CMS model. You define it explicitly in rules.

## Building blocks

- Frontmatter fields in each markdown note.
- `rules.fields` contract (required/optional/defaults).
- `rules.types` map from `type` to `template` + `permalink`.

## Route construction

Given:

```yaml
types:
  article:
    template: article.html
    permalink: /en/docs/{{ slug }}/
```

A note with `type: article` and `slug: intro` resolves to `/en/docs/intro` (stored canonical path without trailing slash).

## Special cases

- If `redirect_to` exists in frontmatter, route status becomes `301`.
- If `noindex: true`, route is still served but marked as noindex for SEO metadata/sitemap filtering.
- `canonical` can be overridden per page in frontmatter.

## Validation implications

Depending on `validation` rules, Notepub can fail indexing for:

- duplicate routes
- duplicate slugs
- unknown content type
- missing template/permalink constraints
