---
type: article_en
slug: links-and-wikilinks
title: Links and Wikilinks
description: Field links, wikilink resolution rules, and collision handling.
hub: authoring
order: 2
draft: false
lang: en
---

Notepub supports two internal linking systems:

- declarative field links (`rules.links.kind: field`)
- markdown wikilinks (`rules.links.kind: wikilinks` with bracket-link syntax)

## Field links

Example:

```yaml
links:
  - name: belongs_to
    kind: field
    field: hub
    from_types: [article]
    to_types: [hub]
```

The indexer reads `hub` values from frontmatter and resolves them based on `resolve.order` (path, filename, slug).

## Wikilink resolution

`resolve_by: wikimap` uses this priority set:

- filename basename
- aliases frontmatter
- title
- fallback resolve order (path/filename/slug)

Supported forms include:

- `\[\[My Note\]\]`
- `\[\[My Note|Label\]\]`
- `\[\[My Note#Heading\]\]`

## Ambiguity and missing targets

Controlled in each link rule:

- `resolve.ambiguity: error` to fail on collisions
- `resolve.missing: warn_skip` to log and skip unresolved targets
- `resolve.case: insensitive` for case-insensitive lookups

## Collision guidance

Avoid duplicate aliases/titles/filenames that normalize to the same wikimap key.
