---
type: article_en
slug: overview
title: Overview
description: Architecture, data flow, and core behavior of Notepub.
hub: docs
order: 1
draft: false
lang: en
---

Notepub has one core idea: keep your content in Markdown, then apply declarative rules to produce routes and HTML.

## End-to-end flow

1. `notepub index`
- Reads markdown from `content.source` (`local` or `s3`).
- Parses frontmatter.
- Applies `rules.yaml` (types, permalinks, validations, links, collections).
- Writes artifacts to `paths.artifacts_dir`:
  - `resolve.json`
  - `search.json`
  - `sitemap-index.xml` and chunked `sitemap-*.xml`
  - `robots.txt`
  - `collections/*.json` (if materialization is enabled)

2. `notepub serve`
- Loads `resolve.json`.
- Renders markdown on request with theme templates.
- Exposes endpoints like `/health`, `/metrics`, `/v1/search`, `/search`, `/media/*`, `/assets/*`.

3. `notepub build`
- Uses the same resolve/render model.
- Produces static files in `dist/`.
- Copies theme assets and SEO artifacts.
- Generates `404.html`.

## Core concepts

- Content contract comes from frontmatter + `rules.fields`.
- URL structure comes from `rules.types.<type>.permalink`.
- Template selection comes from `rules.types.<type>.template`.
- Internal links can be resolved from fields and wikilinks.
- Collections are query definitions available in templates (runtime) and optionally materialized as JSON.

## Serve vs build

- Use `serve` when you want a running app that can read from local/S3 and return dynamic routes.
- Use `build` when you need pure static hosting (GitHub Pages, Netlify, Cloudflare Pages, S3 static hosting).

## Newcomer recommendation

Start with [[Getting Started]] and do one full deploy before changing rules deeply.
