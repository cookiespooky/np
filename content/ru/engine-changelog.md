---
type: article_ru
slug: engine-changelog
title: Журнал изменений движка
description: Ключевые изменения движка в последних релизах и их влияние на шаблоны.
hub: reference
order: 5
draft: false
lang: ru
---

Ниже ключевые релизы, которые существенно повлияли на шаблоны и инфраструктуру.

## Релиз `v0.1.7` (`2026-04-29`)

- Исправлена modern-инфраструктура, генерируемая `template update`:
  - `content.local_dir` теперь резолвится относительно расположения конфига (например `.np/config.yaml` + `../content`).
  - в modern deploy workflow путь контента перед sync вычисляется из конфига как абсолютный.
- Практический эффект: modern-шаблоны с кастомным путём контента больше не теряют медиа/контент в CI.

## Релиз `v0.1.6` (`2026-04-29`)

- Обновлён `template update` для modern (`.np/*`) шаблонов:
  - теперь обновляется modern `./.np/scripts/build.sh` вместе с workflow/config.
  - `build.sh` берёт `content.local_dir` из конфига (без жёсткого `./content`).
  - добавлены env-overrides:
    - `NOTEPUB_CONTENT_DIR`
    - `NOTEPUB_MEDIA_DIR`
    - `NOTEPUB_ARTIFACTS_DIR`
    - `NOTEPUB_DIST_DIR`
- Практический эффект: меньше drift между конфигом и build/deploy инфраструктурой.

## Релиз `v0.1.5` (`2026-04-27`)

- Obsidian markdown стал first-class в serve/build:
  - callouts (`> [!note]`, foldable-варианты),
  - inline-синтаксис (`==mark==`, `~sub~`, `^sup^`),
  - footnotes и math wrappers,
  - безопасный препроцесс wikilinks/embeds вне code fences/inline code.
- Добавлена markdown-диагностика:
  - `validate --markdown`
  - `--markdown-strict`
  - `--markdown-format text|json`
  - `--output <path>`
- Добавлены инструменты шаблонов:
  - `notepub template check`
  - `notepub template update` (`--apply` для записи)
- Добавлен baseline `settings/overrides`:
  - `settings:` — first-class источник,
  - note overrides через `overrides.site_note` / `overrides.interface_note` (опционально),
  - `compat_mode: auto|modern|legacy`.
- SEO/runtime исправления:
  - `/search` использует route/meta/body из `search`-заметки,
  - совместимость sitemap (`sitemap-index.xml` + `sitemap.xml`),
  - улучшена canonical-редирект-логика trailing slash в `serve`,
  - local media учитывает settings-driven assets и sibling `../media`.

## Что стоит сделать в шаблонах и доке

- Держать CI pin бинарника актуальным (сейчас `v0.1.7`).
- Для template-репозиториев добавить matrix gate по:
  - `compat_mode` (`auto|modern|legacy`)
  - наличию заметок (`present|absent`)
  - source mode (`local|s3`)
- Предпочитать встроенную поддержку Obsidian вместо обязательных rewrite-скриптов markdown.
