---
type: article_ru
slug: media
title: Медиа и изображения
description: Как резолвятся медиа-ссылки в режимах serve и build.
hub: authoring
order: 3
draft: false
lang: ru
---

Notepub переписывает ссылки на изображения из markdown и Obsidian-embed синтаксиса.

В шаблонных репозиториях и CI обычно используется pre-build скрипт нормализации Obsidian embed-ссылок.
Этот же скрипт может нормализовать и `hub`-викиссылки во frontmatter для стабильной фильтрации хабов на клиенте.

## Поддерживаемые синтаксисы

- Markdown image: `![alt](path/to/image.png)`
- Obsidian embed: `!\[\[image.png\]\]`
- Obsidian embed с подписью: `!\[\[image.png|Cover image\]\]`

## Поведение в serve

- Относительные медиа-ссылки преобразуются в `/media/...`, если не задан `site.media_base_url`.
- `/media/*` по умолчанию отдает только медиа, найденные в индексированном markdown.
- `media.expose_all_under_prefix: true` открывает все медиа под заданным prefix.

## Поведение в build

- Для статических хостов медиа должны резолвиться в абсолютную базу.
- Используйте `site.media_base_url` (CDN/bucket URL).
- Без `site.media_base_url` ссылки `/media/*` на чисто статическом хосте обычно не работают.

## Безопасность

- Внешние URL (`http`, `https`, `data`, protocol-relative) не переписываются.
- Небезопасные traversal-пути отбрасываются.
- Пути экранируются перед выводом в URL.
