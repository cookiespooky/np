---
type: docs_en
slug: docs
title: Documentation
description: Complete Notepub documentation for newcomers and advanced users.
draft: false
order: 0
lang: en
---

Notepub is a single-binary publishing engine that turns Markdown notes into a website.

Use this docs hub in this order if you are new:

1. [[Overview]]
2. [[Getting Started]]
3. [[Template Repos]]
4. [[Build and Deploy]]

Then go deeper by area:

- [[Concepts and Architecture]]
- [[Content Authoring]]
- [[Operations]]
- [[Reference]]

## What you get with Notepub

- Markdown content from local folders or S3.
- Rules-driven routing, templates, links, and collections.
- Two runtimes:
  - `serve` for dynamic rendering from indexed content.
  - `build` for static HTML output in `dist/`.
- SEO outputs by default: sitemap, robots, canonical metadata, OpenGraph, JSON-LD support.

## Default no-code workflow

If you use a recipe repository with GitHub Actions, you usually only edit:

- `content/*.md`
- `config.yaml`
- `rules.yaml` (optional once you need custom behavior)

The workflow runs `validate` + `build` and deploys to GitHub Pages.
