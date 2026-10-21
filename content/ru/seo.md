---
type: article_ru
slug: seo
title: Справочник по SEO
description: Что движок пишет для поисковиков на каждой странице, какие свойства заметки на это влияют, разметка schema.org, RSS и проверка validate --seo.
hub: reference
order: 6
draft: false
lang: ru
---
Метаданные для поиска Notepub пишет сам; тема их только выводит. Здесь — что генерируется, какие свойства frontmatter это меняют и что сообщает `validate --seo`.

## На каждой странице

| Что | Откуда |
|---|---|
| `<title>` | `.Meta.Title`: `seo_title`, иначе `title` (`title` остаётся заголовком страницы) |
| `<meta name="description">` | `description` |
| canonical | `site.base_url` + permalink с завершающим слэшем; `canonical` переопределяет |
| robots | `index, follow`; `noindex: true` → `noindex, follow`; `robots` переопределяет |
| `og:title` | `og_title` → `seo_title` → `title` |
| `og:description` | `og_description` → `description` → первые 180 символов текста |
| `og:image` | `og_image` → первая картинка заметки → `site.default_og_image` (с `og:image:alt`) |
| `og:type` | `og_type` → `og_type_by_type` → `website` |
| hreflang | `alternates: {en: /en/page/, ru: /ru/page/, x-default: /en/page/}` → `.Meta.Alternates` |
| JSON-LD | `jsonld` как написан, либо сгенерированная разметка при `seo.jsonld: auto` |

Страницы 2…N списка с пагинацией — каноничны сами себе и несут свой `og:url`.

## На весь сайт

- `sitemap.xml` / `sitemap-index.xml` — индексируемые адреса, частями по 50 000, без `noindex`, перенаправлений и черновиков (`sitemap.exclude_drafts`). `<lastmod>` — `updated` заметки (также `lastmod`, `modified`, `date_modified`), иначе время файла; скрипты сборки шаблонов в CI ставят файлу время последнего коммита заметки.
- `robots.txt` — `robots.disallow`, `robots.extra` и ссылка на карту сайта. Поисковики читают его только в корне домена: у сайта под путём (`/docs/`) ссылка на карту сайта должна стоять в корневом `robots.txt` домена.
- перенаправления — заметка с `redirect_to` отвечает 301 в `serve`; `build` пишет страницу с мгновенным переходом и canonical на цель.
- `404.html` — из шаблона темы `notfound.html`.

## Разметка schema.org

```yaml
site:
  language: "ru"      # inLanguage разметки и ленты
seo:
  jsonld: "auto"      # по умолчанию выключено
  article_types: ["post"]
  author_name: "Анна"
```

С `auto` каждая индексируемая страница без своего `jsonld` получает граф из `WebSite` и `WebPage` (с `dateModified` и картинкой страницы). Страницы `article_types` (по умолчанию — типы, которые `og_type_by_type` называет `article`) добавляют `Article` с `headline`, `datePublished` (из `date`), `dateModified` и `author` (свойство `author` заметки или `seo.author_name`). Заметка может назвать главную сущность сама: `schema_type: Service`, `LocalBusiness`, `FAQPage`, `Person`… По умолчанию выключено, чтобы не удваивать разметку тем, которые пишут её сами.

## RSS

```yaml
feed:
  enabled: true
  types: ["post"]   # по умолчанию — типы-статьи
  limit: 20
  path: "feed.xml"
```

`build` пишет ленту, `serve` отдаёт её; шаблоны ставят ссылку через `.FeedURL`. Записи идут по `date`, черновики и `noindex` пропускаются, `lastBuildDate` — дата самой новой записи, поэтому файл меняется только вместе с контентом.

## validate --seo

```bash
notepub validate --config ./config.yaml --rules ./rules.yaml --seo
notepub validate --config ./config.yaml --rules ./rules.yaml --seo --seo-strict        # падать на предупреждениях
notepub validate --config ./config.yaml --rules ./rules.yaml --seo --seo-format json
```

Читает `resolve.json` и проверяет страницы, которые идут в карту сайта:

| Код | Уровень | Что значит |
|---|---|---|
| `title-missing`, `title-long`, `title-duplicate` | warning | нет заголовка, длиннее 70 символов или как у другой страницы |
| `description-missing`, `description-short`, `description-long`, `description-duplicate` | warning | нет описания, короче 50 или длиннее 200 символов, или повторяется |
| `robots-under-path` | warning | сайт живёт под путём, где `robots.txt` не читается |
| `page-isolated` | info | на страницу не ссылается ни одна заметка и она ни на что не ссылается (меню темы не учитывается) |
| `canonical-offsite` | info | `canonical` ведёт на другой домен |
| `lastmod-uniform` | info | у всех страниц одна дата и ни одна заметка не задаёт свою |

Скрипты сборки шаблонов запускают проверку при каждой сборке без `--seo-strict`; находки видны в журнале GitHub Actions.
