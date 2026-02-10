---
type: article_ru
slug: collections-reference
title: Справочник коллекций
description: Модель запросов коллекций, группировка, сортировка и доступ в шаблонах.
hub: reference
order: 3
draft: false
lang: ru
---

Коллекции — это декларативные запросы поверх данных resolve-индекса.

## Контексты выполнения

- В runtime (`serve`/`build`): коллекции вычисляются для страницы и доступны в `.Collections`.
- На этапе index: коллекции с `materialize: true` записываются в JSON-артефакты.

## Виды коллекций

## `filter`

Берет все страницы и применяет where/sort/limit/group.

## `forward`

Идет по именованной связи от одной страницы к целям.

Основные ключи:

- `link`
- `from_slug`

`from_slug` может содержать `{{ page.slug }}` (runtime-контекст).

## `backrefs`

Находит страницы, которые ссылаются на цель по именованной связи.

Основные ключи:

- `link`
- `to_slug`

`to_slug` может содержать `{{ page.slug }}` (runtime-контекст).

## Фильтрация

Базовые where-клаузы в `where.all`:

- `type_in: ["article", "page"]`
- `fm_eq: { key: "draft", value: false }`

## Сортировка и группировка

Сортировка по:

- `title`, `slug`, `updated_at`, `created_at`
- `fm.<field>`

Группировка по:

- `type`
- `fm.<field>`

При `group_by.multi: true` элементы с массивом в FM могут попасть в несколько групп.

## Ограничения materialize

Если включены соответствующие validation-проверки, materialized-коллекции обязаны иметь:

- `limit`
- `group_by.item_limit` (если используется grouping)

Также в materialized-режиме `from_slug`/`to_slug` не должны использовать `{{ page.slug }}`.
