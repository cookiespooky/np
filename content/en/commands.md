---
type: article_en
slug: commands
title: Commands
description: Full CLI command reference and behavior notes.
hub: operations
order: 1
draft: false
lang: en
---

## Command list

```bash
notepub index
notepub serve
notepub build
notepub validate
notepub help
notepub version
```

## Shared path precedence

Config path resolution:

1. `--config`
2. `CONFIG_PATH`
3. `config.yaml`

Rules path resolution:

1. `--rules`
2. `RULES_PATH`
3. `rules_path` from config
4. `rules.yaml` near config/current directory fallback

## `index`

```bash
notepub index --config ./config.yaml --rules ./rules.yaml
```

- validates rules
- scans source content
- updates snapshot and artifacts
- fails if content/rules validation fails

## `serve`

```bash
notepub serve --config ./config.yaml --rules ./rules.yaml --addr :8081
```

- loads theme and resolve store
- serves routes, assets, media, search endpoints
- supports graceful shutdown on SIGINT/SIGTERM

## `build`

```bash
notepub build --config ./config.yaml --rules ./rules.yaml --dist ./dist
```

Flags:

- `--dist` output directory
- `--artifacts` artifacts directory
- `--no-index` do not auto-index when resolve is missing
- `--generate-search` generate `search.json` when missing

## `validate`

```bash
notepub validate --config ./config.yaml --rules ./rules.yaml --links
```

Flags:

- `--resolve` explicit resolve path
- `--links` validate resolved links (requires resolve.json)

## Exit codes

- `0` success
- `1` runtime/config/content errors
- `2` usage/flag errors
