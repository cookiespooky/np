---
type: article_en
slug: rules-yaml
title: "rules.yaml Reference"
description: "Full rules schema: fields, types, links, collections, search, sitemap, and validation."
hub: reference
order: 2
draft: false
lang: en
---

`rules.yaml` defines content contract and output behavior.

## Top-level keys

- `version`
- `fields`
- `fm_schema`
- `types`
- `links`
- `collections`
- `sitemap`
- `search`
- `artifacts`
- `validation`

## `fields`

- `required`: required frontmatter keys.
- `optional`: extra recognized keys.
- `defaults`: default values injected into frontmatter if missing.

## `types`

Each type defines:

- `template`
- `permalink`
- `include_in.sitemap`
- `include_in.search`

Permalink supports `{{ slug }}` and `{{slug}}` replacement.

## `links`

Supported kinds:

- `field` (from frontmatter field values)
- `wikilinks` (from wikilink syntax in markdown)

Common attributes:

- `name`
- `from_types`, `to_types`
- `resolve.order`: any of `path`, `filename`, `slug`
- `resolve.ambiguity`: `error` or non-fatal handling
- `resolve.missing`: `error` or `warn_skip`
- `resolve.case`: case mode (often `insensitive`)
- `resolve_by: wikimap` for Obsidian-like keying

## `collections`

Kinds:

- `filter`
- `forward`
- `backrefs`

Supports:

- `where.all` clauses (`type_in`, `fm_eq`)
- sorting (`title`, `slug`, `updated_at`, `created_at`, `fm.<key>`)
- `limit`
- optional `group_by`

## `sitemap` and `search`

- include types by whitelist
- optionally exclude drafts
- search supports title/description/body/FM boosts and preview settings

## `validation`

Important controls:

- `single_page_of_type`
- `duplicate_route.action`
- `unknown_type.action`
- `unique_slug.action`
- `permalink_requires_slug.action`
- `missing_template.action`
- `materialize_requires_limit`
- `materialize_group_by_requires_item_limit`
