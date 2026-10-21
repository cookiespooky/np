---
type: article_en
slug: commands
title: Commands
description: Full reference of notepub CLI commands — index, serve, build, validate, template — with flags and exit codes.
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
notepub template check
notepub template update --apply
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
- `--markdown` run markdown diagnostics
- `--markdown-strict` fail command on markdown warnings
- `--markdown-format text|json` diagnostics output format
- `--output <path>` write markdown diagnostics report to file
- `--seo` check titles, descriptions, isolated pages, robots and lastmod ([SEO Reference](/en/docs/seo))
- `--seo-strict` fail command on SEO warnings
- `--seo-format text|json` SEO findings output format

Examples:

```bash
notepub validate --config ./config.yaml --rules ./rules.yaml --resolve ./artifacts/resolve.json --markdown
notepub validate --config ./config.yaml --rules ./rules.yaml --resolve ./artifacts/resolve.json --markdown --markdown-strict
notepub validate --config ./config.yaml --rules ./rules.yaml --resolve ./artifacts/resolve.json --seo
```

## `template check` / `template update`

```bash
notepub template check
notepub template update
notepub template update --apply
```

- `template check`: reports infrastructure status and manual review findings.
- `template update`: dry run by default.
- `template update --apply`: updates recognized infrastructure files (build scripts/workflows/config wiring), while leaving content unchanged.
- `template check` also reports whether pages are dated by commits and whether the build runs the SEO check.

## Exit codes

- `0` success
- `1` runtime/config/content errors
- `2` usage/flag errors
