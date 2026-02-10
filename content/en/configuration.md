---
type: article_en
slug: configuration
title: Configuration Reference
description: Detailed explanation of all major config.yaml sections.
hub: reference
order: 1
draft: false
lang: en
---

## Loading and defaults

Config is loaded from YAML and then normalized.

Path precedence:

1. `--config`
2. `CONFIG_PATH`
3. `config.yaml`

Important defaults:

- `paths.file_root`: `/var/lib/notepub`
- `paths.artifacts_dir`: `<file_root>/artifacts`
- `paths.snapshot_file`: `<file_root>/snapshot/objects.json`
- `paths.cache_root`: `/var/cache/notepub`
- `theme.dir`: `/opt/notepub/themes`
- `theme.name`: `seo-minimal`
- `server.listen`: `:8081`
- `s3.region`: `us-east-1`

## `site`

- `id`: cache namespace identifier.
- `base_url`: required; normalized without trailing slash.
- `title`, `description`: defaults for metadata.
- `default_og_image`: fallback OG image.
- `media_base_url`: optional absolute base for media URLs.
- `host`: optional host allowlist primary value.
- `host_aliases`: optional additional allowed hosts.

## `content`

- `source`: `local` or `s3`.
- `local_dir`: used when source is local; relative paths are resolved from config file directory.

If `content.source` is empty:

- defaults to `local` when `s3.bucket` is empty
- defaults to `s3` when `s3.bucket` exists

## `s3`

- `endpoint`, `region`, `force_path_style`
- `bucket` (required when using source `s3`)
- `prefix` normalized to no leading slash and optional trailing slash
- credentials:
  - both `access_key` and `secret_key`, or neither
  - if both omitted, AWS default credential chain is used
- `anonymous: true` disables signing (public bucket mode)

## `theme`

- `dir`, `name`
- `templates_subdir` (default `templates`)
- `assets_subdir` (default `assets`)

## `paths`

- `artifacts_dir`: where index outputs are read/written
- `snapshot_file`: object snapshot diff cache
- `cache_root`: serve HTML cache root

## `media`

- `expose_all_under_prefix`:
  - `false` default: `/media/*` only for media referenced in indexed markdown
  - `true`: allow all media keys under prefix

## `rules_path`

If omitted, defaults to `rules.yaml` adjacent to config file.
