---
type: article_ru
slug: template-repos
title: Template-репозитории
description: "Три официальных шаблона Notepub — документация, сайт услуг и личный блог: что у них общего и как их обновлять."
hub: docs
order: 3
draft: false
lang: ru
---
Template-репозиторий — основной способ начать работу с Notepub. Нажмите **Use this template** на GitHub, включите Pages с **Source: GitHub Actions** — и каждый push в `main` собирает и публикует сайт.

## Официальные шаблоны

| Шаблон | Репозиторий | Типы страниц |
|---|---|---|
| Документация | https://github.com/cookiespooky/np-template-docs | `home`, `hub`, `article`, `page`, `search`, `footer` |
| Сайт услуг | https://github.com/cookiespooky/np-template-services | `home`, `services`, `service`, `works`, `work`, `page` |
| Личный блог | https://github.com/cookiespooky/np-template-blog | `home` (лента с пагинацией), `post`, `tags`, `page` |

Каждый — рабочий сайт с демо-содержимым, собранный одной и той же закреплённой версией движка (`NOTEPUB_VERSION` в `.github/workflows/deploy.yml`). Прежние recipe-репозитории (`notepub-recipe-blog`, `notepub-recipe-docs`, `np-obsidian-template` и другие) переведены в архив.

## Устройство репозитория

```text
content/        заметки — одна заметка = одна страница
media/          картинки и файлы, публикуются по адресу /media/
Site.md         настройки сайта свойствами заметки (название, язык, логотип, цвет акцента…)
Interface.md    подписи интерфейса свойствами заметки
.np/            сторона движка: config.yaml, rules.yaml, theme/, scripts/
.github/        workflows публикации и проверки качества
```

Корень репозитория открывается в Obsidian как хранилище: авторы работают с `content/`, `media/`, `Site.md` и `Interface.md` и в `.np/` не заглядывают. Разработчики работают в `.np/` и собирают локально:

```bash
NOTEPUB_BIN=/path/to/notepub ./.np/scripts/preview.sh   # собрать и открыть на http://127.0.0.1:8080/
NOTEPUB_BIN=/path/to/notepub ./.np/scripts/build.sh     # собрать в .np/dist/
```

## Что делает сборка

`.np/scripts/build.sh` генерирует `notepub template update`, и он одинаковый во всех шаблонах:

1. превращает `Site.md` и `Interface.md` в настройки (`prepare-settings.py`; любое свойство доходит до шаблонов как `.Settings.<key>`);
2. в CI ставит каждой заметке время её последнего коммита (workflow скачивает всю историю), поэтому `<lastmod>` в карте сайта — день, когда заметка менялась;
3. берёт адрес сайта у GitHub Pages (`actions/configure-pages`), в том числе свой домен, и заменяет `http://` на `https://`;
4. запускает `index`, `validate --links`, `validate --markdown`, `validate --seo`, `build`;
5. копирует файлы из `content/` и `media/`, которые не заметки, в `/media/`.

## Общие файлы

`tokens.css` (цвета, шрифты, скругления), `fonts.css` с шрифтами Golos Text и JetBrains Mono в репозитории, `main.js`, `partials/theme_overrides.html` и всё в `.np/scripts/` одинаковые в трёх шаблонах; различаются только `styles.css`, шаблоны страниц и `rules.yaml`. `theme_accent` в `Site.md` меняет цвет акцента; пусто — цвет из токенов.

## Как обновлять

- Источник правды — контент и правила; тему и скрипты можно заменить.
- Поднимите `NOTEPUB_VERSION` в обоих workflows, затем `notepub template check` и `notepub template update --apply` — они приведут `build.sh` и `deploy.yml` к новой версии.
- После первой публикации прочитайте в журнале Actions предупреждения `validate --seo` и `validate --markdown`.
- `quality-gate.yml` собирает шаблон во всех `compat_mode` (`auto|modern|legacy`), с заметками настроек и без них, и проверяет конфиг для S3.
