---
type: article_en
slug: artifacts-reference
title: Artifacts and Outputs
description: Exact files produced by index/build and what each one is used for.
hub: reference
order: 4
draft: false
lang: en
---

## Index artifacts directory

Default path comes from `paths.artifacts_dir`.

Common files:

- `resolve.json`
- `search.json`
- `robots.txt`
- `sitemap-index.xml`
- `sitemap-0001.xml`, `sitemap-0002.xml`, ...
- `collections/<name>.json` (if enabled and materialized)

## Snapshot file

`paths.snapshot_file` stores object hash/modification metadata used for incremental indexing decisions.

## Dist output (build)

`notepub build` writes:

- rendered routes as `index.html` files
- `assets/*`
- copied/generated sitemap and robots files
- optional `search.json`
- `404.html`

## `resolve.json` structure (high level)

- `generated_at`
- `routes` map (status, redirects, etag, source key)
- `meta` map (title, description, canonical, OG, FM)
- `links` map (resolved graph)
- `link_targets` map (raw extracted link targets)
- `media` map (allowed media keys per route)

## Operational usage

- `serve` depends on `resolve.json` for route resolution.
- `validate --links` uses resolve data to check link correctness.
- static search UI consumes `search.json`.
