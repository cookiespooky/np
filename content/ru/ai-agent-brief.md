---
type: article_ru
slug: ai-agent-brief
title: Бриф для AI/MCP-агента
description: Минимальный контракт задачи, чтобы агент мог собрать и задеплоить сайт на Notepub без длинных уточнений.
hub: docs
order: 7
draft: false
lang: ru
---

Эта страница нужна, если вы хотите делегировать запуск/настройку сайта AI-агенту.

Если вы только знакомитесь с Notepub, сначала пройдите:
[Быстрый старт](/ru/docs/getting-started/), [Template-репозитории](/ru/docs/template-repos/) и [Структура контента в recipe-репозиториях](/ru/docs/recipe-structure/).

Короткая ссылка на общую документацию:

- RU: https://cookiespooky.github.io/np/ru/docs/
- EN: https://cookiespooky.github.io/np/en/docs/

## Что сообщить агенту в начале

1. Цель проекта: `blog` или `docs`.
2. Сценарий: `one-repo` (template site repo) или `content_repo`.
`one-repo` = один сайт-репозиторий с контентом и темой - простой дефолтный способ.  
`content_repo` = отдельный репозиторий с контентом. Подробно: [Режим Content Repository](/ru/docs/content-repo/).
3. URL и имя репозитория: `owner/repo` (и контент-репозитория, если выбрали режим `content-repo`).
4. Рабочая директория на вашей локальной машине (абсолютный путь).
5. Язык(и) и структура контента (например, только RU или RU+EN).
6. Что можно менять: только `content/` или также `theme/`, `rules.yaml`, workflow.
Если нужен S3-источник, смотрите: [Режим S3](/ru/docs/s3-content/).

## Какие доступы нужны агенту

1. Доступ к Git-репозиторию (clone/push).
2. Права на GitHub Actions и GitHub Pages в целевом репозитории.
3. Право читать/создавать Repository Variables и Secrets (если нужен `content_repo` или `s3`).
4. Если используется custom domain: доступ к DNS/настройкам домена.

## Минимальные значения, без которых агент обычно стопорится

1. `site.base_url` (финальный canonical URL).
2. Название и описание сайта (`site.title`, `site.description`).
3. Стартовый набор страниц (хотя бы `home`, `search`, 2-3 рабочие статьи/страницы).
4. Политика slug: можно ли менять существующие slug или только через редиректы.

Справочники по этим пунктам:

- [Справочник config.yaml](/ru/docs/configuration/)
- [Справочник rules.yaml](/ru/docs/rules-yaml/)
- [Руководство по авторингу](/ru/docs/content-authoring/)

## Definition of Done (критерии готовности)

1. Build/deploy workflow завершился успешно на `main`.
2. Сайт открывается по Pages URL без 404 на ключевых маршрутах.
3. Поиск работает и возвращает результаты по `title/description`.
4. `sitemap.xml` и `robots.txt` доступны.
5. В репозитории есть краткий README "как обновлять контент дальше".

Про локальный прогон и деплой:

- [Локальный запуск](/ru/docs/local-run/)
- [Сборка и деплой](/ru/docs/build-and-deploy/)

## Готовый шаблон сообщения агенту

```text
Сделай сайт на Notepub под ключ.

Контекст:
- Сценарий: one-repo
- Шаблон: notepub-recipe-blog
- Репозиторий: <owner/repo>
- Локальная папка: <abs-path>
- Язык: RU
- Брендинг: <site title>, <description>
- Base URL: <https://.../>

Ограничения:
- Можно менять: content/, config.yaml, rules.yaml, theme/
- Нельзя менять: <если есть ограничения>

Критерии done:
1) workflow deploy зеленый
2) сайт доступен по Pages URL
3) поиск работает
4) sitemap/robots доступны
5) добавь README с шагами контент-редактирования
```

## Что проверить вручную после работы агента

1. Правильность `base_url` и canonical ссылок.
2. Наличие дублей slug и конфликтов маршрутов.
3. Корректность меню/хабов и внутренних ссылок.
4. Соответствие визуала и структуры ожиданиям.
