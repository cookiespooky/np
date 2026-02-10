---
type: article_ru
slug: search
title: Поиск
description: Режимы server/static, API-эндпоинты и ожидаемые форматы.
hub: operations
order: 2
draft: false
lang: ru
---

Поиск в Notepub двухрежимный и должен быть доступен как в server, так и в static-деплое.

## Эндпоинты

- `GET /v1/search?q=<query>&limit=<n>&cursor=<token>`
- `GET /search` (SSR search page, работает без JS)

Поведение `/v1/search`:

- минимальная длина запроса: 2
- `limit` по умолчанию: 8
- максимум `limit`: 50
- ответ содержит `items` и `next_cursor`

## Static-режим

В build-output search UI должен использовать `/search.json`.

Ожидаемый формат:

```json
{
  "generated_at": "RFC3339",
  "items": [
    {
      "title": "...",
      "path": "/...",
      "snippet": "...",
      "type": "article",
      "updatedAt": "RFC3339",
      "score": 1.23
    }
  ]
}
```

## Влияние rules на поиск

Генерация search index учитывает:

- `search.include_types`
- `search.exclude_drafts`
- веса полей (`search.fields_boost`)
- настройки preview (`search.preview`)
