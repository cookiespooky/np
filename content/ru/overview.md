---
type: article_ru
slug: overview
title: Обзор
description: Архитектура, поток данных и базовая логика работы Notepub.
hub: docs
order: 1
draft: false
lang: ru
---

Ключевая идея Notepub: хранить контент в Markdown и через декларативные правила получать маршруты и HTML.

## Сквозной процесс

1. `notepub index`
- Читает markdown из `content.source` (`local` или `s3`).
- Парсит frontmatter.
- Применяет `rules.yaml` (типы, permalink, валидации, связи, коллекции).
- Пишет артефакты в `paths.artifacts_dir`:
  - `resolve.json`
  - `search.json`
  - `sitemap-index.xml` и `sitemap-*.xml`
  - `robots.txt`
  - `collections/*.json` (если включена материализация)

2. `notepub serve`
- Загружает `resolve.json`.
- Рендерит markdown по запросу через тему.
- Отдает эндпоинты `/health`, `/metrics`, `/v1/search`, `/search`, `/media/*`, `/assets/*`.

3. `notepub build`
- Использует ту же модель резолва и рендера.
- Генерирует статические файлы в `dist/`.
- Копирует ассеты темы и SEO-артефакты.
- Создает `404.html`.

## Основные концепции

- Контракт контента задается frontmatter + `rules.fields`.
- Структура URL задается в `rules.types.<type>.permalink`.
- Выбор шаблона задается в `rules.types.<type>.template`.
- Внутренние ссылки резолвятся из полей и wikilinks.
- Коллекции — это декларативные выборки для шаблонов и артефактов.

## Serve и Build

- `serve` подходит, когда нужен живой сервер с контентом из local/S3.
- `build` нужен для полностью статического хостинга (GitHub Pages, Netlify, Cloudflare Pages, S3 static hosting).

## Рекомендация для старта

Начните с [Быстрого старта](/ru/docs/getting-started) и сделайте один полный деплой до глубоких изменений правил.
