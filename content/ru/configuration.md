---
type: article_ru
slug: configuration
title: Справочник config.yaml
description: Подробное описание основных секций config.yaml.
hub: reference
order: 1
draft: false
lang: ru
---

## Загрузка и defaults

Config читается из YAML, затем нормализуется.

Приоритет пути:

1. `--config`
2. `CONFIG_PATH`
3. `config.yaml`

Важные значения по умолчанию:

- `paths.file_root`: `/var/lib/notepub`
- `paths.artifacts_dir`: `<file_root>/artifacts`
- `paths.snapshot_file`: `<file_root>/snapshot/objects.json`
- `paths.cache_root`: `/var/cache/notepub`
- `theme.dir`: `/opt/notepub/themes`
- `theme.name`: `seo-minimal`
- `server.listen`: `:8081`
- `s3.region`: `us-east-1`

## `site`

- `id`: идентификатор пространства кеша.
- `base_url`: обязательный, нормализуется без завершающего `/`.
- `title`, `description`: default-метаданные.
- `default_og_image`: fallback-картинка OpenGraph.
- `media_base_url`: опциональная абсолютная база для медиа.
- `host`: основной allowlist host.
- `host_aliases`: дополнительные разрешенные host.

## `content`

- `source`: `local` или `s3`.
- `local_dir`: путь для local-режима; относительный путь резолвится от директории config.

Если `content.source` пуст:

- выбирается `local`, если `s3.bucket` пуст
- выбирается `s3`, если `s3.bucket` задан

## `s3`

- `endpoint`, `region`, `force_path_style`
- `bucket` (обязателен для `content.source: s3`)
- `prefix` нормализуется без ведущего `/` и с опциональным завершающим `/`
- credentials:
  - либо обе пары `access_key` + `secret_key`, либо ни одной
  - при отсутствии пары используется AWS default credential chain
- `anonymous: true` выключает подпись запросов (публичный bucket)

## `theme`

- `dir`, `name`
- `templates_subdir` (по умолчанию `templates`)
- `assets_subdir` (по умолчанию `assets`)

## `paths`

- `artifacts_dir`: директория чтения/записи index-артефактов
- `snapshot_file`: snapshot-файл для инкрементальной индексации
- `cache_root`: корень HTML-кеша в serve

## `media`

- `expose_all_under_prefix`:
  - `false`: `/media/*` только для медиа, найденных в индексированном markdown
  - `true`: открыть все медиа под заданным prefix

## `rules_path`

Если не указан, по умолчанию ищется `rules.yaml` рядом с config-файлом.
