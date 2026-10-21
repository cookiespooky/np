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

For a typical template, each note should contain at minimum:

```yaml
---
type: article
slug: my-slug
title: Clear title
---
```

Common optional fields:

- `description`
- `draft`
- `hub`
- `related`
- `aliases`
- `noindex`
- `redirect_to`
- `jsonld`
- `seo_title` — the `<title>` when `title` is too long for search results
- `date`, `updated` — publication and change dates (`updated` becomes the sitemap `<lastmod>`)
- `alternates` — language versions for hreflang
- `schema_type` — schema.org type of the page with `seo.jsonld: auto`

See [SEO Reference](/en/docs/seo).

## Draft behavior

Default is usually defined in rules (`fields.defaults.draft: false`).

- With `draft: true`, inclusion in search/sitemap depends on rules (`exclude_drafts`).
- Draft pages may exist in resolve/meta unless explicitly filtered out.

## Metadata behavior

- `canonical`: built automatically from `site.base_url + route`, unless overridden.
- `robots`: built from `noindex`, unless explicitly set.
- OpenGraph: built from frontmatter, content, and site defaults.
- `jsonld`: embedded only when JSON is valid.

## Writing practice

- Use stable slugs and change them only with redirects.
- In the official templates, frontmatter `title` is already rendered as `h1`; in page body, usually start with `h2` to avoid duplicate `h1`.
- For predictable search snippets, fill frontmatter `description`: this field is used as `snippet`.
- The first paragraph is useful as a concise intro and can be used as fallback for `og:description`, but it is not the main source for search snippet.
