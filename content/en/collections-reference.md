---
type: article_en
slug: collections-reference
title: Collections Reference
description: Collection query model, grouping, sorting, and template access.
hub: reference
order: 3
draft: false
lang: en
---

Collections are declarative queries executed over resolve index data.

## Execution contexts

- Serve/build runtime: collections are computed per request/page and exposed via `.Collections`.
- Index time: collections with `materialize: true` are written to artifacts JSON.

## Collection kinds

## `filter`

Starts from all pages and applies where/sort/limit/group.

## `forward`

Follows a named link from one page to its targets.

Useful keys:

- `link`
- `from_slug`

`from_slug` can use `{{ page.slug }}` placeholder (runtime mode).

## `backrefs`

Finds pages that point to a target via a named link.

Useful keys:

- `link`
- `to_slug`

`to_slug` can use `{{ page.slug }}` placeholder (runtime mode).

## Filtering clauses

Current built-in filters in `where.all`:

- `type_in: ["article", "page"]`
- `fm_eq: { key: "draft", value: false }`

## Sorting and grouping

Sort by:

- `title`, `slug`, `updated_at`, `created_at`
- `fm.<field>`

Group by:

- `type`
- `fm.<field>`

With `group_by.multi: true`, array-valued FM fields can place one item into multiple groups.

## Materialization constraints

When enabled in validation, materialized collections must define:

- `limit`
- `group_by.item_limit` (when grouping is used)

Also, materialized `from_slug`/`to_slug` cannot use `{{ page.slug }}` placeholders.
