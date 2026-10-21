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

Для типового шаблона каждая заметка должна содержать минимум:

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
- `seo_title` — `<title>`, если `title` длинный для выдачи
- `date`, `updated` — даты публикации и изменения (`updated` становится `<lastmod>` в карте сайта)
- `alternates` — языковые версии для hreflang
- `schema_type` — тип schema.org для страницы при `seo.jsonld: auto`

См. [[seo|Справочник по SEO]].

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
- В официальных шаблонах `title` из frontmatter уже рендерится как `h1`; в теле страницы обычно начинайте с `h2`, чтобы не дублировать `h1`.
- Для предсказуемого сниппета в поиске заполняйте `description` во frontmatter: именно он попадает в `snippet`.
- Первый абзац полезен как краткое вступление и может использоваться как fallback для `og:description`, но это не основной источник search snippet.
