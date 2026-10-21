---
type: article_ru
slug: configuration
title: Справочник config.yaml
description: Подробное описание основных секций config.yaml — разделы site, content, seo, feed, media, robots и другие.
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

Стартовые значения в официальных шаблонах (`np-template-docs`, `np-template-services`, `np-template-blog`), конфиг которых лежит в `.np/config.yaml`:

- `site.id`: имя шаблона
- `content.source`: `local`
- `content.local_dir`: `../content` (относительно `.np/`)
- `media.dirs`: `["../media"]`
- `runtime.mode`: `auto`
- `paths.file_root`: `./.notepub`
- `paths.artifacts_dir`: `./.notepub/artifacts`
- `paths.snapshot_file`: `./.notepub/snapshot/objects.json`
- `paths.cache_root`: `./.notepub/cache`
- `theme.dir`: `./.np`
- `theme.name`: `theme`
- `theme.templates_subdir`: `templates`
- `theme.assets_subdir`: `assets`
- `server.listen`: `127.0.0.1:8080`
- `cache.html_ttl_seconds`: `600`
- `cache.stale_if_error_seconds`: `604800`

Системные defaults движка (если поля не заданы) могут отличаться от конфигов шаблонов.

## `site`

- `id`: идентификатор пространства кеша (по умолчанию `default`).
- `base_url`: обязательный, нормализуется без завершающего `/`.
- `title`, `description`: default-метаданные.
- `default_og_image`: fallback-картинка OpenGraph.
- `media_base_url`: опциональная абсолютная база для медиа.
- `host`: основной allowlist host для `serve`.
- `host_aliases`: дополнительные разрешенные host для `serve`.
- `language`: язык разметки schema.org и RSS-ленты; то же значение, что настройка `site_language` (по умолчанию `en`).

## `content`

- `source`: `local` или `s3`.
- `local_dir`: путь для local-режима; относительный путь резолвится от директории config.
  Если `source=local` и `local_dir` не задан, используется `markdown`.

Если `content.source` пуст:

- выбирается `local`, если `s3.bucket` пуст
- выбирается `s3`, если `s3.bucket` задан

## `s3`

- `endpoint`, `region`, `force_path_style`
- `bucket` (обязателен для `content.source: s3`)
- `prefix` нормализуется без ведущего `/`; если задан, движок добавляет завершающий `/`
- credentials:
  - либо обе пары `access_key` + `secret_key`, либо ни одной
  - при отсутствии пары используется AWS default credential chain
- `anonymous: true` выключает подпись запросов (публичный bucket)

## `og_type_by_type`

Карта соответствия `type -> og:type` для OpenGraph.  
Пример: `article: article`, `page: website`.

## `theme`

- `dir`, `name`
- `templates_subdir` (по умолчанию `templates`)
- `assets_subdir` (по умолчанию `assets`)

## `seo`

- `jsonld`: `auto` — генерировать разметку schema.org для страниц без своего `jsonld`; пусто или `off` — разметку пишет тема.
- `article_types`: типы, размечаемые как `Article` (по умолчанию — типы, которые `og_type_by_type` называет `article`).
- `author_name`: `author` по умолчанию в разметке `Article`.

См. [[seo|Справочник по SEO]].

## `feed`

- `enabled`: писать RSS 2.0 (`build`) и отдавать ленту (`serve`).
- `types`: типы контента в ленте (по умолчанию — типы-статьи).
- `limit` (по умолчанию `20`), `path` (по умолчанию `feed.xml`), `title`, `description`.

## `paths`

- `artifacts_dir`: директория чтения/записи index-артефактов
- `snapshot_file`: snapshot-файл для инкрементальной индексации
- `cache_root`: корень HTML-кеша в serve

## `robots`

- `disallow`: список путей для `robots.txt`.
- `extra`: произвольный текст, который дописывается в `robots.txt`.

## `cache`

- `html_ttl_seconds`: TTL HTML-кеша в `serve` (по умолчанию `600`).
- `stale_if_error_seconds`: период выдачи stale-кеша при ошибках (по умолчанию `604800`).

## `media`

- `expose_all_under_prefix`:
  - `false`: `/media/*` только для медиа, найденных в индексированном markdown
  - `true`: открыть все медиа под заданным prefix
- `dirs`: локальные папки помимо папки контента, файлы которых сборка публикует в `/media/` (папка `media/` хранилища); вставки `![[файл]]` находят там файлы по имени. Относительные пути — от папки конфига.

## `rules_path`

Если не указан, по умолчанию ищется `rules.yaml` рядом с config-файлом.

## Валидация при загрузке

- `site.base_url` обязателен.
- `content.source` должен быть только `local` или `s3`.
- Для `source=s3` обязателен `s3.bucket`.
- Для `source=s3` ключи `s3.access_key` и `s3.secret_key` задаются только парой.
