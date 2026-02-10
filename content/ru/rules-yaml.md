---
type: article_ru
slug: rules-yaml
title: "Справочник rules.yaml"
description: "Полная схема rules: поля, типы, связи, коллекции, поиск, sitemap и валидация."
hub: reference
order: 2
draft: false
lang: ru
---

`rules.yaml` определяет контракт контента и поведение output.

## Ключи верхнего уровня

- `version`
- `fields`
- `fm_schema`
- `types`
- `links`
- `collections`
- `sitemap`
- `search`
- `artifacts`
- `validation`

## `fields`

- `required`: обязательные ключи frontmatter.
- `optional`: дополнительные распознаваемые ключи.
- `defaults`: значения по умолчанию, если поле отсутствует.

## `types`

Каждый тип задает:

- `template`
- `permalink`
- `include_in.sitemap`
- `include_in.search`

`permalink` поддерживает подстановки `{{ slug }}` и `{{slug}}`.

## `links`

Поддерживаемые виды:

- `field` (из значений frontmatter-поля)
- `wikilinks` (из wiki-ссылок в markdown)

Частые атрибуты:

- `name`
- `from_types`, `to_types`
- `resolve.order`: `path`, `filename`, `slug`
- `resolve.ambiguity`: `error` или мягкая обработка
- `resolve.missing`: `error` или `warn_skip`
- `resolve.case`: режим регистра (часто `insensitive`)
- `resolve_by: wikimap` для Obsidian-подобного резолва

## `collections`

Виды:

- `filter`
- `forward`
- `backrefs`

Поддерживаются:

- `where.all` (`type_in`, `fm_eq`)
- сортировки (`title`, `slug`, `updated_at`, `created_at`, `fm.<key>`)
- `limit`
- опциональный `group_by`

## `sitemap` и `search`

- include-списки типов
- опциональное исключение draft-страниц
- веса полей поиска и настройки preview

## `validation`

Важные проверки:

- `single_page_of_type`
- `duplicate_route.action`
- `unknown_type.action`
- `unique_slug.action`
- `permalink_requires_slug.action`
- `missing_template.action`
- `materialize_requires_limit`
- `materialize_group_by_requires_item_limit`
