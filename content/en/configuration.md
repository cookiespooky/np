---
type: article_en
slug: configuration
title: config.yaml Reference
description: Detailed description of major config.yaml sections.
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

Current starter values for template repositories (`notepub-recipe-blog`, `notepub-recipe-docs`):

- `site.id`: `default`
- `content.source`: `local`
- `content.local_dir`: `./content`
- `paths.file_root`: `./.notepub`
- `paths.artifacts_dir`: `./.notepub/artifacts`
- `paths.snapshot_file`: `./.notepub/snapshot/objects.json`
- `paths.cache_root`: `./.notepub/cache`
- `theme.dir`: `.`
- `theme.name`: `theme`
- `theme.templates_subdir`: `templates`
- `theme.assets_subdir`: `assets`
- `server.listen`: `127.0.0.1:8080`
- `cache.html_ttl_seconds`: `600`
- `cache.stale_if_error_seconds`: `604800`

Engine-level defaults (when fields are omitted) may differ from recipe configs.

## `site`

- `id`: cache namespace identifier (default `default`).
- `base_url`: required, normalized without trailing `/`.
- `title`, `description`: default metadata.
- `default_og_image`: OpenGraph fallback image.
- `media_base_url`: optional absolute base URL for media.
- `host`: primary allowlist host for `serve`.
- `host_aliases`: additional allowed hosts for `serve`.

## `content`

- `source`: `local` or `s3`.
- `local_dir`: path for local mode; relative path is resolved from config directory.
  If `source=local` and `local_dir` is missing, `markdown` is used.

If `content.source` is empty:

- `local` is selected when `s3.bucket` is empty
- `s3` is selected when `s3.bucket` is set

## `s3`

- `endpoint`, `region`, `force_path_style`
- `bucket` (required for `content.source: s3`)
- `prefix` is normalized without leading `/`; if set, engine adds trailing `/`
- credentials:
  - either both `access_key` + `secret_key`, or neither
  - when omitted, AWS default credential chain is used
- `anonymous: true` disables request signing (public bucket)

## `og_type_by_type`

Map `type -> og:type` for OpenGraph.  
Example: `article: article`, `page: website`.

## `theme`

- `dir`, `name`
- `templates_subdir` (default `templates`)
- `assets_subdir` (default `assets`)

## `paths`

- `artifacts_dir`: directory for reading/writing index artifacts
- `snapshot_file`: snapshot file for incremental indexing
- `cache_root`: HTML cache root in `serve`

## `robots`

- `disallow`: list of paths for `robots.txt`.
- `extra`: arbitrary text appended to `robots.txt`.

## `cache`

- `html_ttl_seconds`: HTML cache TTL in `serve` (default `600`).
- `stale_if_error_seconds`: stale cache window on errors (default `604800`).

## `media`

- `expose_all_under_prefix`:
  - `false`: `/media/*` only for media referenced in indexed markdown
  - `true`: expose all media under configured prefix

## `rules_path`

If omitted, default is `rules.yaml` next to config file.

## Load-time validation

- `site.base_url` is required.
- `content.source` must be only `local` or `s3`.
- For `source=s3`, `s3.bucket` is required.
- For `source=s3`, `s3.access_key` and `s3.secret_key` must be set as a pair.
