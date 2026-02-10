---
type: article_ru
slug: troubleshooting
title: Диагностика проблем
description: Быстрый гайд по диагностике типовых ошибок конфигурации, индексации и рендера.
hub: operations
order: 4
draft: false
lang: ru
---

## `config file not found`

Причина:

- неверный путь в `--config`
- отсутствует ожидаемый `config.yaml`

Что делать:

- передать корректный абсолютный/относительный путь
- проверить рабочую директорию в CI

## `rules file not found` или rules path is directory

Причина: неверный `--rules`, `RULES_PATH` или `rules_path`.

Что делать: убедиться, что путь указывает на файл.

## `site.base_url is required`

Причина: отсутствует `site.base_url`.

Что делать: задать абсолютный базовый URL.

## `index validation failed`

Обычно это:

- отсутствуют обязательные поля frontmatter (`type`, `title`, иногда `slug`)
- дубли slug или route
- тип контента не описан в `rules.types`
- не выполнены требования template/permalink

Что делать: запустить `notepub validate` и проверить проблемные markdown-файлы.

## Медиа не работают на static-деплое

Причина: на статическом хосте нет runtime-обработчика `/media/*`.

Что делать: задать `site.media_base_url` и пересобрать сайт.

## Поиск работает в serve, но не работает в static

Причина: в static-выводе нет `search.json`.

Что делать:

- проверить, что `index` создал `artifacts/search.json`
- или запускать `build --generate-search`

## Контент изменился, но показываются старые title/body

Причина: устаревшее состояние `resolve.json`/snapshot/cache.

Что делать:

```bash
rm ./.notepub/snapshot/objects.json ./.notepub/artifacts/resolve.json
notepub index --config ./config.yaml --rules ./rules.yaml
```

Если `serve` уже запущен — перезапустить после reindex.

## 404 из-за host-проверки в serve

Причина: host запроса не входит в `site.host`/`site.host_aliases`.

Что делать: обновить host-настройки или конфигурацию reverse proxy.
