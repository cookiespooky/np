---
type: docs_ru
slug: docs
title: Документация
description: Полная документация Notepub для новичков и продвинутых пользователей.
draft: false
order: 0
lang: ru
---

Notepub — это publishing-движок в одном бинарнике, который генерирует html из markdown по правилам и конфигу, описанным в `rules.yaml` и `config.yaml`, соответственно.

Если вы только начинаете, идите по порядку:

1. [[overview|Обзор]]
2. [[getting-started|Быстрый старт]]
3. [[template-repos|Template-репозитории]]
4. [[recipe-structure|Структура контента в template-репозиториях]]
5. [[build-and-deploy|Сборка и деплой]]
6. [[local-run|Локальный запуск]]
7. [[ai-agent-brief|Бриф для AI/MCP-агента]]

Дальше углубляйтесь по разделам:

- [[concepts|Концепции и архитектура]]
- [[content-authoring|Авторинг контента]]
- [[operations|Эксплуатация]]
- [[reference|Справочник]]

## Что дает Notepub

- Markdown-контент из локальных папок или S3.
- Декларативную маршрутизацию, шаблоны, связи и коллекции.
- Два режима работы:
  - `serve` для динамического рендеринга.
  - `build` для статического HTML в `dist/`.
- SEO по умолчанию: карта сайта с настоящими датами изменений, robots, canonical, OpenGraph, hreflang, JSON-LD, RSS и проверка `validate --seo` — см. [[seo|Справочник по SEO]].

## Базовый no-code workflow

Если вы используете template-репозиторий с GitHub Actions, чаще всего вы редактируете только:

- `content/*.md` и `media/`
- `Site.md` и `Interface.md`
- `.np/rules.yaml` (по необходимости)

Workflow запускает `validate` + `build` и деплоит сайт в GitHub Pages.

Для template-репозиториев также держите инфраструктуру синхронизированной с релизами движка через:

- `notepub template check`
- `notepub template update --apply`
