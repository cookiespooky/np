---
type: article_en
slug: recipe-structure
title: Content Structure in Recipe Repositories
description: How Notepub templates organize page types, homepage, hubs, search, and links between notes.
hub: docs
order: 6
draft: false
lang: en
---

This page explains the baseline content model for templates:

- `notepub-recipe-blog`
- `notepub-recipe-docs`

## Page types in recipe templates

Both recipe templates follow the same core type model:

- `home` - homepage (`/`)
- `page` - regular page (`/{{ slug }}/` in docs recipe, `/{{ slug }}/` for page in blog recipe)
- `article` - article (in blog recipe usually `/articles/{{ slug }}/`, in docs recipe `/{slug}/`)
- `hub` - topic section/hub page
- `search` - search page (`/search/`)

Minimal required frontmatter fields:

- `type`
- `slug`
- `title`

In docs portal template (`np`), language-specific types are used (`home_en`, `article_en`, `hub_ru`, etc.), but the model is the same.

## How homepage works

`home` is a special single page type at route `/`.

Recipe validation expects exactly one page of this type (and exactly one `search` as well).

Homepage usually shows:

- article/page collections
- list of hubs
- featured content cards (in blog recipe)

Block composition is controlled by collections in `rules.yaml` and template `home.html`.

## How hubs work

`hub` is a section page that receives content through frontmatter links.

Baseline mechanism:

- in page/article, set `hub: ["some-hub"]`
- `belongs_to` link rule connects content to hub by `slug`
- `hub_items` collection builds hub page items

Result: hub pages are assembled automatically when `hub` is filled correctly.

## How pages and articles work

In practice:

- `page` is usually for static sections (about, contacts, landing pages)
- `article` is the primary stream of notes/docs

What goes into search and sitemap is defined in `rules.yaml`:

- usually search includes `page` and `article`
- `home`, `hub`, `search` are usually excluded from search index

## How search works

Recipe templates include a dedicated `search` page and `search` rules in `rules.yaml`.

Typical setup:

- search index is built from `page` and `article`
- draft content is excluded (`exclude_drafts: true`)
- snippet is taken from `description` (`preview.from: "description"`)

So for predictable results, fill `description`.

## How relations and links work

Recipe templates usually have three relation kinds:

- `belongs_to` - membership in hubs via `hub`
- `related` - manual links via `related`
- `wiki` - wiki-links in markdown body (double-bracket wikilink syntax)

For wikilink syntax, aliases, and resolver order, see:
[Links and Wikilinks](/en/docs/links-and-wikilinks/)

## Practical modeling pattern for notes

If you want to use your own markdown-world structure:

1. Define top-level hub pages first.
2. Attach articles to hubs via `hub`.
3. Add `related` only where explicit editorial relation is needed.
4. Fill `title` and `description` for each note to improve search quality.
5. Keep `slug` stable; when changed, add redirects.
