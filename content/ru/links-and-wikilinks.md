---
type: article_ru
slug: links-and-wikilinks
title: Ссылки и wikilinks
description: Поля-связи, правила резолва wikilinks и обработка коллизий.
hub: authoring
order: 2
draft: false
lang: ru
---

В Notepub есть две системы внутренних ссылок:

- декларативные связи из полей (`rules.links.kind: field`)
- wikilinks из markdown (`rules.links.kind: wikilinks`)

## Field links

Пример:

```yaml
links:
  - name: belongs_to
    kind: field
    field: hub
    from_types: [article]
    to_types: [hub]
```

Индексатор читает значения `hub` из frontmatter и резолвит их по `resolve.order` (path, filename, slug).

## Резолв wikilinks

При `resolve_by: wikimap` используется приоритет:

- basename файла
- aliases из frontmatter
- title
- fallback-порядок (path/filename/slug)

Поддерживаются формы:

- `\[\[My Note\]\]`
- `\[\[My Note|Label\]\]`
- `\[\[My Note#Heading\]\]`

## Неоднозначность и пропуски

Управляются в каждом link rule:

- `resolve.ambiguity: error` — падать при неоднозначности
- `resolve.missing: warn_skip` — логировать и пропускать отсутствующие цели
- `resolve.case: insensitive` — нечувствительность к регистру

## Практика против коллизий

Избегайте повторяющихся aliases/title/filename, которые нормализуются в одинаковый wikimap-ключ.
