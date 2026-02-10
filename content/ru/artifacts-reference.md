---
type: article_ru
slug: artifacts-reference
title: Артефакты и output
description: Какие файлы создаются в index/build и для чего они используются.
hub: reference
order: 4
draft: false
lang: ru
---

## Директория index-артефактов

Путь по умолчанию задается `paths.artifacts_dir`.

Типовые файлы:

- `resolve.json`
- `search.json`
- `robots.txt`
- `sitemap-index.xml`
- `sitemap-0001.xml`, `sitemap-0002.xml`, ...
- `collections/<name>.json` (если включена материализация)

## Snapshot-файл

`paths.snapshot_file` хранит hash/mtime метаданные объектов для инкрементальной индексации.

## Build-output

`notepub build` записывает:

- рендер маршрутов в `index.html`
- `assets/*`
- скопированные/сгенерированные sitemap и robots
- опциональный `search.json`
- `404.html`

## Структура `resolve.json` (верхний уровень)

- `generated_at`
- `routes` (status, redirects, etag, source key)
- `meta` (title, description, canonical, OG, FM)
- `links` (резолвленный граф)
- `link_targets` (сырые extracted targets)
- `media` (разрешенные media keys по route)

## Где это используется

- `serve` использует `resolve.json` для резолва маршрутов.
- `validate --links` проверяет корректность графа ссылок.
- статический search UI читает `search.json`.
