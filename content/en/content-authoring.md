---
type: article_en
slug: content-authoring
title: Authoring Guide
description: Frontmatter rules, markdown conventions, and page metadata behavior.
hub: authoring
order: 1
draft: false
lang: en
---

## Required frontmatter

With typical recipe rules, each note needs:

```yaml
---
type: article
slug: my-slug
title: Human readable title
---
```

Optional but common:

- `description`
- `draft`
- `hub`
- `related`
- `aliases`
- `noindex`
- `redirect_to`
- `jsonld`

## Draft behavior

`draft` default is usually set in rules (`fields.defaults.draft: false`).

- If `draft: true`, inclusion in search/sitemap depends on your rules (`exclude_drafts`).
- Draft pages may still exist in resolve/meta unless filtered out by rules.

## Metadata behavior

- `canonical`: auto-built from `site.base_url + route` unless overridden.
- `robots`: auto-generated from `noindex` unless overridden.
- OpenGraph fields are derived from frontmatter/content/site defaults.
- `jsonld` is injected only if valid JSON.

## Practical writing conventions

- Use stable slugs; avoid changing them after publishing unless you create redirects.
- Keep one clear H1 in markdown body.
- Write first paragraph as summary for better snippets and previews.
- Use explicit `description` for reliable search preview text.
