---
type: docs_ru
slug: docs
title: Документация
description: Полная документация Notepub для новичков и продвинутых пользователей.
draft: false
order: 0
lang: ru
---

Notepub — это publishing-движок в одном бинарнике, который превращает Markdown-заметки в сайт.

Если вы только начинаете, идите по порядку:

1. [Обзор](/ru/docs/overview)
2. [Быстрый старт](/ru/docs/getting-started)
3. [Template-репозитории](/ru/docs/template-repos)
4. [Сборка и деплой](/ru/docs/build-and-deploy)

Дальше углубляйтесь по разделам:

- [Концепции и архитектура](/ru/docs/concepts)
- [Авторинг контента](/ru/docs/content-authoring)
- [Эксплуатация](/ru/docs/operations)
- [Справочник](/ru/docs/reference)

## Что дает Notepub

- Markdown-контент из локальных папок или S3.
- Декларативную маршрутизацию, шаблоны, связи и коллекции.
- Два режима работы:
  - `serve` для динамического рендеринга.
  - `build` для статического HTML в `dist/`.
- SEO-артефакты по умолчанию: sitemap, robots, canonical, OpenGraph, JSON-LD.

## Базовый no-code workflow

Если вы используете recipe-репозиторий с GitHub Actions, чаще всего вы редактируете только:

- `content/*.md`
- `config.yaml`
- `rules.yaml` (по необходимости)

Workflow запускает `validate` + `build` и деплоит сайт в GitHub Pages.
