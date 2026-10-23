---
type: article_ru
slug: seo
title: Справочник по SEO
description: Что движок пишет для поисковиков на каждой странице, какие свойства заметки на это влияют, разметка schema.org, RSS, llms.txt и проверки validate --seo и audit.
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
- `404.html` — из шаблона темы `notfound.html`, без общего каркаса страницы: делайте его полноценным документом со своим `<head>`.
- `llms.txt` — при `llms.enabled`, см. ниже.

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

## audit — готовый сайт

```bash
notepub audit --config ./config.yaml --dist ./dist             # base_url из конфига
notepub audit --dist ./dist --base-url https://example.com/ --strict
```

`validate --seo` видит заметки, а `audit` — готовые страницы вместе с шаблонами и меню. Именно оттуда берутся ссылка без слэша в конце, квадратная `og:image` или страница 404 без `<head>`. Интернет не нужен. Ошибки валят команду, `--strict` — и предупреждения.

| Код | Уровень | Что значит |
|---|---|---|
| `link-broken`, `sitemap-broken` | error | ссылка или адрес из карты сайта не ведут ни на одну страницу сборки |
| `title-missing`, `jsonld-invalid` | error | нет `<title>`; JSON-LD не разбирается |
| `link-redirect` | warning | ссылка без слэша в конце: статический хостинг отвечает на неё 301 |
| `title-long`, `title-duplicate`, `description-missing`, `description-long`, `description-duplicate` | warning | как в `validate --seo`, но на готовых страницах |
| `h1-missing`, `h1-multiple` | warning | нет `<h1>` или их несколько |
| `canonical-missing`, `canonical-relative`, `canonical-host` | warning | нет canonical, он относительный или на другом домене (в сборке остался локальный `base_url`) |
| `og-missing`, `og-image-relative`, `og-image-small` | warning | нет тега OpenGraph, картинка по относительному адресу, картинка меньше 1200×630 |
| `favicon-missing`, `viewport-missing`, `img-alt-missing`, `image-heavy` | warning | нет значка, нет viewport для телефона, картинки без `alt`, картинка больше 500 КБ |
| `page-orphan` | warning | ни одна другая страница сюда не ссылается, с учётом меню |
| `robots-missing`, `robots-no-sitemap`, `sitemap-missing`, `sitemap-noindex`, `404-missing`, `404-bare` | warning | файлов сайта нет или они неправильные; `404.html` — не полноценный документ |
| `llms-broken` | warning | `llms.txt` ссылается на страницу, которой нет |
| `heading-skip`, `description-short`, `jsonld-missing`, `text-thin`, `html-heavy` | info | стоит посмотреть, но не ошибка |
| `canonical-other`, `sitemap-absent`, `link-outside-build`, `robots-under-path`, `llms-missing`, `analytics-missing` | info | замечания по сайту целиком |

Вне проверки: HTTPS, заголовки ответа, перенаправления с www и скорость — их задаёт хостинг, проверяйте на живом сайте.

## llms.txt

```yaml
llms:
  enabled: true
  intro: "Что это за сайт, одним абзацем."
  sections:
    - type: article
      title: Документация
    - type: service
      title: Услуги
```

`build` пишет `llms.txt` (llmstxt.org), `serve` отдаёт его: название и описание сайта, вступление, затем индексируемые страницы типа каждого раздела с описаниями. Без `sections` — все индексируемые типы по алфавиту; `limit` ограничивает раздел, `path` меняет имя файла. Файл собирается из заметок при каждой сборке, поэтому не устаревает. По умолчанию выключен.

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
