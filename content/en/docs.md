---
type: docs_en
slug: docs
title: Documentation
description: Full Notepub documentation for beginners and advanced users.
draft: false
order: 0
lang: en
---

Notepub is a single-binary publishing engine that generates HTML from markdown using rules in `rules.yaml` and settings in `config.yaml`.

If you are just starting, follow this order:

1. [[overview|Overview]]
2. [[getting-started|Getting Started]]
3. [[template-repos|Template Repositories]]
4. [[recipe-structure|Content Structure in Template Repositories]]
5. [[build-and-deploy|Build and Deploy]]
6. [[local-run|Local Run]]
7. [[ai-agent-brief|AI/MCP Agent Brief]]

Then go deeper by area:

- [[concepts|Concepts and Architecture]]
- [[content-authoring|Content Authoring]]
- [[operations|Operations]]
- [[reference|Reference]]

## What Notepub gives you

- Markdown content from local folders or S3.
- Declarative routing, templates, links, and collections.
- Two operation modes:
  - `serve` for dynamic rendering.
  - `build` for static HTML in `dist/`.
- SEO by default: sitemap with real change dates, robots, canonical, OpenGraph, hreflang, JSON-LD, RSS and a `validate --seo` check — see [[seo|SEO Reference]].

## Basic no-code workflow

If you use a template repository with GitHub Actions, most of the time you only edit:

- `content/*.md` and `media/`
- `Site.md` and `Interface.md`
- `.np/rules.yaml` (as needed)

Workflow runs `validate` + `build` and deploys site to GitHub Pages.

For template repositories, also keep infrastructure aligned with engine releases using:

- `notepub template check`
- `notepub template update --apply`
