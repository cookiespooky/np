---
type: article_ru
slug: themes
title: Темы и шаблоны
description: Структура темы, контракт шаблонов и fallback-поведение.
hub: operations
order: 3
draft: false
lang: ru
---

Тема загружается из:

`<theme.dir>/<theme.name>/`

## Рекомендуемая структура

```text
<theme>/
  templates/
    layout.html
    home.html
    page.html
    article.html
    hub.html
    search.html
    notfound.html
  assets/
    styles.css
    main.js
    favicon.ico
```

## Выбор шаблона

- `layout.html` — общий wrapper.
- Для `/` используется home-логика.
- Для страниц используется `rules.types.<type>.template`.
- При отсутствии файлов включается fallback на embedded шаблоны/ассеты.

## Данные в шаблонах

Чаще всего используются:

- `.Title`, `.Description`, `.Canonical`, `.BaseURL`
- `.Page.Type`, `.Page.Slug`, `.Page.Title`
- `.Body` (готовый HTML)
- `.Collections` (вычисленные коллекции)
- `.Meta.OpenGraph`, `.Meta.JSONLD`
- `.SearchMode` (`server` или `static`)

## Раздача ассетов

- В `serve`: ассеты доступны по `/assets/*`.
- В `build`: ассеты копируются в `dist/assets/*`.
