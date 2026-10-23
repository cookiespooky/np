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

## Релиз `v0.1.10` (`2026-10-23`)

- `notepub audit --dist ./dist`: проверка готового сайта по SEO-чек-листу без интернета — ссылки, которые никуда не ведут или ведут через перенаправление, страницы-сироты с учётом меню, canonical, OpenGraph и размер `og:image`, карта сайта против сборки, `robots.txt`, `llms.txt`, `404.html`. Ошибки валят команду, поэтому она может остановить деплой. См. [[seo|Справочник по SEO]].
- `llms.txt` собирается из заметок при `llms.enabled` (разделы по типам, в заданном порядке).
- `notepub type add <имя>`: новый вид страниц одной командой — тип в `rules.yaml` и его шаблон. См. [[commands|Команды]].
- Шаблоны: `.PublicPath` у элементов коллекций — адрес со слэшем в конце.
- Исправлено: `[[вики-ссылки]]` вели на адрес без слэша в конце, и статический хостинг отвечал на каждую перенаправлением 301.

## Релиз `v0.1.9` (`2026-10-22`)

- SEO:
  - `validate --seo` (`--seo-strict`, `--seo-format json`): нет заголовка или описания, слишком длинные или повторяющиеся, изолированные страницы, сайт под путём, чей `robots.txt` не читается, одинаковый `lastmod`;
  - `<lastmod>` берётся из `updated` заметки (`lastmod`, `modified`), а сборка шаблонов в CI ставит заметкам время последнего коммита — раньше каждый деплой помечал все страницы изменёнными;
  - `seo_title` для `<title>`, `alternates` для hreflang, разметка schema.org по желанию (`seo.jsonld: auto`, `schema_type`), RSS-лента (`feed`), `site.language`.
- Obsidian: `![[файл]]` находит файл по имени в любой папке контента и `media.dirs`, как сам Obsidian; `validate --markdown` сообщает о вставке несуществующего файла (`NP-MD-EMBED-MISSING`).
- Шаблоны: `.Meta.Title`, `.Meta.Alternates`, `.Meta.Published`, `.FeedURL`; функции `humanDate`, `isoDate`, `dict`.
- Исправлено: инкрементальный `index` оставлял старые canonical/`og:url` после смены `base_url`; страницы 2…N списка с пагинацией несли `og:url` первой страницы.
- `template update`: workflow публикации скачивает всю историю, `build.sh` датирует заметки по коммитам, заменяет `http://` адреса Pages на `https://` и запускает проверку SEO.

См. [[seo|Справочник по SEO]].

## Релиз `v0.1.8` (`2026-09-10`)

- Пагинация: тип объявляет `paginate: { collection, per_page, path }`; страницы 2…N каноничны сами себе и есть в карте сайта; шаблоны читают `.Collections.<имя>.Page` (`Current`, `Total`, `PrevURL`, `NextURL`).
- Повторяемая сборка: теги OpenGraph, порядок коллекций и карта сайта больше не зависят от порядка обхода map.
- id заголовков транслитерируются (у кириллических заголовков есть рабочие якоря, `[[page#Заголовок]]` работает).
- Canonical, `og:url` и адреса в карте сайта — с завершающим слэшем, как реально отдаёт сайт.

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
