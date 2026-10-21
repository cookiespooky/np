---
type: article_en
slug: seo
title: SEO Reference
description: What the engine writes for search engines on every page, the frontmatter that controls it, schema.org markup, RSS, and the validate --seo check.
hub: reference
order: 6
draft: false
lang: en
---
Notepub writes the search metadata itself; a theme only prints it. This page lists what is generated, which frontmatter keys change it, and what `validate --seo` reports.

## Per page

| Output | Source |
|---|---|
| `<title>` | `.Meta.Title`: `seo_title`, else `title` (`title` stays the page heading) |
| `<meta name="description">` | `description` |
| canonical | `site.base_url` + permalink with its trailing slash; `canonical` overrides |
| robots meta | `index, follow`; `noindex: true` → `noindex, follow`; `robots` overrides |
| `og:title` | `og_title` → `seo_title` → `title` |
| `og:description` | `og_description` → `description` → first 180 characters of the text |
| `og:image` | `og_image` → first image of the note → `site.default_og_image` (with `og:image:alt`) |
| `og:type` | `og_type` → `og_type_by_type` → `website` |
| hreflang | `alternates: {en: /en/page/, ru: /ru/page/, x-default: /en/page/}` → `.Meta.Alternates` |
| JSON-LD | `jsonld` as written, or generated with `seo.jsonld: auto` |

Pages 2…N of a paginated list are canonical to themselves and carry their own `og:url`.

## Site-wide

- `sitemap.xml` / `sitemap-index.xml` — indexable routes, split every 50 000 URLs, without `noindex`, redirects and drafts (`sitemap.exclude_drafts`). `<lastmod>` is the note's `updated` (also `lastmod`, `modified`, `date_modified`), else the file time; template build scripts set the file time to the note's last commit in CI.
- `robots.txt` — `robots.disallow`, `robots.extra` and the sitemap link. Crawlers read it only at the host root: a site under a path (`/docs/`) must have its sitemap listed in the root `robots.txt` of the host.
- redirects — a note with `redirect_to` answers 301 in `serve`; `build` writes a page with an instant redirect and a canonical to the target.
- `404.html` — rendered from the theme's `notfound.html`.

## schema.org markup

```yaml
site:
  language: "en"      # inLanguage of the markup and the feed
seo:
  jsonld: "auto"      # off by default
  article_types: ["post"]
  author_name: "Anna"
```

With `auto`, every indexable page without its own `jsonld` gets a graph of `WebSite` and `WebPage` (with `dateModified` and the page image). Pages of `article_types` (by default, types that `og_type_by_type` maps to `article`) add an `Article` with `headline`, `datePublished` (from `date`), `dateModified` and `author` (the note's `author` or `seo.author_name`). A note can name its main entity: `schema_type: Service`, `LocalBusiness`, `FAQPage`, `Person`… The default is off so themes that print their own markup are not doubled.

## RSS

```yaml
feed:
  enabled: true
  types: ["post"]   # default: article types
  limit: 20
  path: "feed.xml"
```

`build` writes the feed, `serve` answers it; templates link it through `.FeedURL`. Items are sorted by `date`, drafts and `noindex` pages are skipped, and `lastBuildDate` is the newest item's date, so the file changes only when content does.

## validate --seo

```bash
notepub validate --config ./config.yaml --rules ./rules.yaml --seo
notepub validate --config ./config.yaml --rules ./rules.yaml --seo --seo-strict        # fail on warnings
notepub validate --config ./config.yaml --rules ./rules.yaml --seo --seo-format json
```

It reads `resolve.json` and checks the pages that go to the sitemap:

| Code | Level | Meaning |
|---|---|---|
| `title-missing`, `title-long`, `title-duplicate` | warning | no title, over 70 characters, or the same as another page |
| `description-missing`, `description-short`, `description-long`, `description-duplicate` | warning | none, under 50 or over 200 characters, or repeated |
| `robots-under-path` | warning | the site lives under a path, where `robots.txt` is not read |
| `page-isolated` | info | no note links to the page and it links to none (theme menus are not seen) |
| `canonical-offsite` | info | `canonical` points to another host |
| `lastmod-uniform` | info | every page has the same date and no note sets one |

Template build scripts run it on every build without `--seo-strict`; findings appear in the GitHub Actions log.
