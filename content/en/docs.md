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

1. [Overview](/en/docs/overview)
2. [Getting Started](/en/docs/getting-started)
3. [Template Repositories](/en/docs/template-repos)
4. [Content Structure in Recipe Repositories](/en/docs/recipe-structure)
5. [Build and Deploy](/en/docs/build-and-deploy)
6. [Local Run](/en/docs/local-run)
7. [AI/MCP Agent Brief](/en/docs/ai-agent-brief)

Then go deeper by area:

- [Concepts and Architecture](/en/docs/concepts)
- [Content Authoring](/en/docs/content-authoring)
- [Operations](/en/docs/operations)
- [Reference](/en/docs/reference)

## What Notepub gives you

- Markdown content from local folders or S3.
- Declarative routing, templates, links, and collections.
- Two operation modes:
  - `serve` for dynamic rendering.
  - `build` for static HTML in `dist/`.
- SEO artifacts by default: sitemap, robots, canonical, OpenGraph, JSON-LD.

## Basic no-code workflow

If you use a recipe repository with GitHub Actions, most of the time you only edit:

- `content/*.md`
- `config.yaml`
- `rules.yaml` (as needed)

Workflow runs `validate` + `build` and deploys site to GitHub Pages.
