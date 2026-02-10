---
type: article_ru
slug: content-model
title: Модель контента и маршрутизация
description: Как frontmatter, типы и permalink определяют структуру сайта.
hub: concepts
order: 2
draft: false
lang: ru
---

Notepub не навязывает CMS-модель. Вы задаете ее явно через правила.

## Базовые элементы

- поля frontmatter в markdown-файлах
- контракт `rules.fields` (required/optional/defaults)
- маппинг `rules.types` от `type` к `template` и `permalink`

## Как строится route

Например:

```yaml
types:
  article:
    template: article.html
    permalink: /ru/docs/{{ slug }}/
```

Заметка с `type: article` и `slug: intro` даст маршрут `/ru/docs/intro`.

## Специальные случаи

- Если в frontmatter есть `redirect_to`, route получает статус `301`.
- Если `noindex: true`, страница рендерится, но помечается как noindex для SEO.
- `canonical` можно переопределить на уровне страницы.

## Влияние на валидацию

В зависимости от блока `validation` индексатор может падать при:

- дублирующихся маршрутах
- дублирующихся slug
- неизвестном типе контента
- нарушениях требований template/permalink
