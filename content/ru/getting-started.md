---
type: article_ru
slug: getting-started
title: Быстрый старт
description: Краткий путь от нуля до опубликованного сайта.
hub: docs
order: 2
draft: false
lang: ru
---

Этот гайд покрывает и рекомендуемый no-code путь, и прямой запуск через CLI.

## Путь A: template repo + GitHub Pages (рекомендуется)

1. Создайте репозиторий из recipe-шаблона Notepub через **Use this template**.
2. В настройках репозитория включите Pages с источником **GitHub Actions**.
3. Отредактируйте `config.yaml`:
- задайте `site.base_url` под ваш итоговый URL
- оставьте завершающий `/`
4. Добавьте/измените markdown-файлы в `content/`.
5. Запушьте изменения в `main`.

Что делает CI:

- скачивает зафиксированный бинарник `notepub`
- запускает `notepub validate`
- запускает `notepub build --dist ./dist`
- деплоит `dist/` в Pages

## Путь B: локальный запуск через CLI

1. Соберите бинарник:

```bash
go build -o notepub ./cmd/notepub
```

2. Подготовьте конфиги:

```bash
cp config.example.yaml config.yaml
cp rules.example.yaml rules.yaml
```

3. Укажите минимум:

- `site.base_url`
- `content.source` (`local` или `s3`)
- `s3.bucket`, если `content.source: s3`

4. Проверьте конфигурацию:

```bash
./notepub validate --config ./config.yaml --rules ./rules.yaml
```

5. Постройте индекс:

```bash
./notepub index --config ./config.yaml --rules ./rules.yaml
```

6. Запустите сервер:

```bash
./notepub serve --config ./config.yaml --rules ./rules.yaml
```

7. Соберите статический сайт:

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
description: Краткое описание
draft: false
---
```

## Частые ошибки на старте

- отсутствует или некорректен `site.base_url`
- неверный путь к `rules.yaml`
- `content.local_dir` указывает на папку без `.md`
- указан S3-режим, но отсутствует `s3.bucket`

Дальше: [Справочник config.yaml](/ru/docs/configuration) и [Справочник rules.yaml](/ru/docs/rules-yaml).
