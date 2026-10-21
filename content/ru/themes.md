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

Тема загружается из `<theme.dir>/<theme.name>/` в корне репозитория.

## Структура

На примере шаблона документации (там это `.np/theme/`). У других шаблонов и своих настроек `rules.yaml` набор шаблонов страниц другой.

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
- `.Meta.Title` — содержимое `<title>`: `seo_title`, иначе `title`
- `.Meta.OpenGraph`, `.Meta.JSONLD`, `.Meta.Robots`
- `.Meta.Alternates` — языковые версии (`.Lang`, `.URL`) для hreflang
- `.Meta.Published` — `date` заметки в формате RFC 3339
- `.FeedURL` — адрес RSS-ленты, если включён `feed.enabled`
- `.Settings.<ключ>` — настройки из `config.yaml` и заметок `Site.md` / `Interface.md`
- `.FM.<ключ>` — frontmatter заметки
- `.SearchMode` (`server` или `static`)

## Функции шаблонов

Кроме встроенных в Go:

- `humanDate значение язык` — дата из frontmatter как «4 марта 2025» для `ru`, «March 4, 2025» для остальных;
- `isoDate значение` — `2025-03-04`, для `<time datetime>`;
- `dict "Ключ" значение …` — несколько значений в один вызов `{{ template }}`.

```html
<time datetime="{{ isoDate .FM.date }}">{{ humanDate .FM.date "ru" }}</time>
{{ template "card.html" (dict "Root" $ "Item" .) }}
```

## Раздача ассетов

- В `serve`: ассеты доступны по `/assets/*`.
- В `build`: ассеты копируются в `dist/assets/*`.
