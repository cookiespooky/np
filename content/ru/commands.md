---
type: article_ru
slug: commands
title: Команды
description: Полный справочник CLI-команд и нюансов поведения.
hub: operations
order: 1
draft: false
lang: ru
---

## Список команд

```bash
notepub index
notepub serve
notepub build
notepub validate
notepub help
notepub version
```

## Приоритет путей

Разрешение пути config:

1. `--config`
2. `CONFIG_PATH`
3. `config.yaml`

Разрешение пути rules:

1. `--rules`
2. `RULES_PATH`
3. `rules_path` из config
4. `rules.yaml` рядом с config или в текущей директории

## `index`

```bash
notepub index --config ./config.yaml --rules ./rules.yaml
```

- валидирует rules
- сканирует контент-источник
- обновляет snapshot и artifacts
- завершает работу с ошибкой при нарушениях контракта

## `serve`

```bash
notepub serve --config ./config.yaml --rules ./rules.yaml --addr :8081
```

- загружает тему и resolve store
- отдает маршруты, assets, media, search endpoints
- поддерживает graceful shutdown по SIGINT/SIGTERM

## `build`

```bash
notepub build --config ./config.yaml --rules ./rules.yaml --dist ./dist
```

Флаги:

- `--dist` — директория output
- `--artifacts` — директория артефактов
- `--no-index` — не запускать auto-index при отсутствии resolve
- `--generate-search` — сгенерировать `search.json`, если он отсутствует

## `validate`

```bash
notepub validate --config ./config.yaml --rules ./rules.yaml --links
```

Флаги:

- `--resolve` — явный путь к resolve-файлу
- `--links` — валидация связей (нужен resolve.json)

## Коды выхода

- `0` — успех
- `1` — runtime/config/content ошибки
- `2` — ошибки использования/флагов
