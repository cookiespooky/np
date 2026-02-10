---
type: article_en
slug: troubleshooting
title: Troubleshooting
description: Fast diagnosis guide for common configuration, indexing, and rendering issues.
hub: operations
order: 4
draft: false
lang: en
---

## `config file not found`

Cause:

- wrong `--config` path
- expected local `config.yaml` missing

Fix:

- pass absolute/relative correct path
- verify working directory in CI

## `rules file not found` or rules path is directory

Cause: bad `--rules`, `RULES_PATH`, or `rules_path` value.

Fix: ensure path points to a file.

## `site.base_url is required`

Cause: missing `site.base_url` in config.

Fix: set absolute base URL and keep route base consistent.

## `index validation failed`

Typical causes:

- missing required frontmatter field (`type`, `title`, sometimes `slug` by permalink)
- duplicate slug or duplicate route
- unknown type not declared in `rules.types`
- missing type template/permalink constraints

Fix: run `notepub validate` and inspect affected markdown files.

## Broken media in static deployment

Cause: no runtime `/media/*` handler on static hosts.

Fix: set `site.media_base_url` and rebuild.

## Search works on serve but not static

Cause: static site missing `search.json`.

Fix:

- ensure `index` generated `artifacts/search.json`
- or run `build --generate-search`

## Content changed, but old titles/body still render

Cause: stale `resolve.json`/snapshot/cache state after large content rewrites.

Fix:

```bash
rm ./.notepub/snapshot/objects.json ./.notepub/artifacts/resolve.json
notepub index --config ./config.yaml --rules ./rules.yaml
```

If a server process is running, restart `serve` after reindexing.

## Host-based 404 on serve

Cause: request host not in `site.host`/`site.host_aliases` allowlist.

Fix: update host config or reverse proxy headers/domain mapping.
