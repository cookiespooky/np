---
type: article_ru
slug: local-run
title: Локальный запуск
description: Как запускать Notepub локально в режиме разработки и сборки.
hub: docs
order: 5
draft: false
lang: ru
---

Эта страница про быстрый локальный запуск проекта до деплоя.

## Notepub binary

Для сборки/рендера потребуется бинарь `notepub`.

Для recipe-репозитория используйте один из вариантов:

- Скачать release-бинарь `notepub` в корень проекта (обычно файл `./notepub`).
или
- Установить через Go (`go install ...`) и запускать команду `notepub` из `PATH`.
или
- Запускать без отдельного бинаря через `go run`.

Ниже примеры даны через переменную `NOTEPUB_BIN`.

## Из какой папки запускать команды

Запускайте команды из корня вашего сайт-репозитория, где лежат:

- `config.yaml`
- `rules.yaml`
- `content/`

Пример:

```bash
cd /path/to/your-site-repo
```

## Минимальные команды

Index:

```bash
NOTEPUB_BIN=./notepub
$NOTEPUB_BIN index --config ./config.yaml --rules ./rules.yaml
```

Serve:

```bash
$NOTEPUB_BIN serve --config ./config.yaml --rules ./rules.yaml
```

Build:

```bash
$NOTEPUB_BIN build --config ./config.yaml --rules ./rules.yaml --dist ./dist
```

## Когда использовать

- `index` — подготовить `resolve.json` и артефакты.
- `serve` — посмотреть сайт локально в серверном режиме.
- `build` — получить статический output в `dist/`.

Если нужен полный справочник флагов, смотрите [Команды](/ru/docs/commands/).
