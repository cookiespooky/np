---
type: article_ru
slug: content-repo
title: Режим Content Repository
description: Использование отдельного репозитория как источника markdown-контента.
hub: operations
order: 15
draft: false
lang: ru
---

Этот режим подходит, когда редакторский процесс отделен от кода сайта.

## Когда использовать

- Контент редактируется в Obsidian и хранится отдельно от шаблонов/темы.
- Над текстами работает несколько авторов без доступа к коду сайта.
- Нужен one-click сценарий "commit and sync" из контент-репозитория.

## Обязательные настройки в сайт-репозитории

Repository variables:

- `CONTENT_SOURCE=content_repo`
- `CONTENT_REPO=owner/repo`
- `CONTENT_REF=main` (опционально, по умолчанию `main`)

Workflow в сайт-репозитории подтягивает контент из `CONTENT_REPO` и синхронизирует его в `content/` перед сборкой.

## Структура контента

Для мультиязычного рецепта `np` храните языковые папки в контент-репозитории:

- `en/*.md`
- `ru/*.md`

Обязательные страницы по правилам:

- EN: по одной `redirect_root`, `home_en`, `docs_en`
- RU: по одной `home_ru`, `docs_ru`

## Примечания

- Frontmatter должен соответствовать `rules.yaml` и `rules.ru.yaml`.
- Избегайте дублирующихся slug внутри одного языка.
- Оставляйте search-страницу для каждого языка, если она требуется правилами.

Дальше: [Workflow с Obsidian](/ru/docs/obsidian-workflow/).
