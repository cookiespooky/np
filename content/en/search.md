---
type: article_en
slug: search
title: Search
description: Server and static search modes, endpoints, and expected formats.
hub: operations
order: 2
draft: false
lang: en
---

Notepub search is dual-mode and should remain available in both server and static deployments.

## Endpoints

- `GET /v1/search?q=<query>&limit=<n>&cursor=<token>`
- `GET /search` (SSR search page, works without JS)

`/v1/search` behavior:

- minimum query length: 2
- default `limit`: 8
- max `limit`: 50
- response includes `items` and `next_cursor`

## Static mode

In build output, search UIs should use `/search.json`.

Expected shape:

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

## Rules impact on search

Search index generation honors:

- `search.include_types`
- `search.exclude_drafts`
- field boost settings (`search.fields_boost`)
- preview settings (`search.preview`)
