---
type: article_ru
slug: content-authoring
title: Руководство по авторингу
description: Правила frontmatter, markdown-конвенции и поведение метаданных страницы.
hub: authoring
order: 1
draft: false
lang: ru
---

## Обязательный frontmatter

Для типового recipe каждая заметка должна содержать минимум:

```yaml
---
type: article
slug: my-slug
title: Понятный заголовок
---
```

Часто используемые необязательные поля:

- `description`
- `draft`
- `hub`
- `related`
- `aliases`
- `noindex`
- `redirect_to`
- `jsonld`

## Поведение draft

Обычно по умолчанию задается в rules (`fields.defaults.draft: false`).

- При `draft: true` попадание в search/sitemap зависит от правил (`exclude_drafts`).
- Draft-страницы могут быть в resolve/meta, если явно не исключены.

## Поведение метаданных

- `canonical`: строится автоматически из `site.base_url + route`, если не переопределен.
- `robots`: строится из `noindex`, если не задан явно.
- OpenGraph: собирается из frontmatter, контента и site-defaults.
- `jsonld`: встраивается только при валидном JSON.

## Практика написания

- Используйте стабильные slug и меняйте их только с редиректами.
- Держите один понятный H1 в теле markdown.
- Пишите первый абзац как сжатое summary для сниппетов.
- Заполняйте `description` для предсказуемого preview в поиске.
