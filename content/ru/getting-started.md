---
type: article_ru
slug: getting-started
title: Быстрый старт
description: Краткий путь от нуля до опубликованного сайта с дефолтным local-режимом.
hub: docs
order: 2
draft: false
lang: ru
---

Это самый короткий дефолтный сценарий. Начните с `local` и переключайтесь на другие источники только при необходимости.

## Рекомендуемый дефолт: local-контент в этом же репозитории

1. Создайте сайт через **Use this template** из шаблона Notepub.
2. В настройках репозитория включите GitHub Pages с источником **GitHub Actions**.
3. Оставьте дефолтный режим:
- `content.source: local` в `config.yaml`
- markdown-файлы в `content/`
4. Запушьте изменения в `main`.

Что делает CI:

- скачивает зафиксированный бинарник `notepub`
- выполняет index/build
- деплоит `dist/` в Pages

## Команды для локального запуска

Index:

```bash
./notepub index --config ./config.yaml --rules ./rules.yaml
```

Serve:

```bash
./notepub serve --config ./config.yaml --rules ./rules.yaml
```

Build:

```bash
./notepub build --config ./config.yaml --rules ./rules.yaml --dist ./dist
```

## Минимальный frontmatter

Для типового recipe:

```yaml
---
type: article
slug: my-first-note
title: Моя первая заметка
draft: false
---
```

## Продвинутые режимы источника контента

- Контент из отдельного репозитория: [Режим Content Repository](/ru/docs/content-repo/)
- Контент из S3-совместимого хранилища: [Режим S3](/ru/docs/s3-content/)
- Поток через Obsidian и настройки variables/secrets: [Workflow с Obsidian](/ru/docs/obsidian-workflow/)

Дальше: [Справочник config.yaml](/ru/docs/configuration) и [Справочник rules.yaml](/ru/docs/rules-yaml).
