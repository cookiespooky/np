---
type: article_en
slug: content-repo
title: Content Repository Mode
description: Use a separate repository as the source of markdown content.
hub: operations
order: 15
draft: false
lang: en
---

This mode is useful when your writing workflow is separate from your site codebase.

## When to use

- You edit content in Obsidian and keep only markdown in a separate repository.
- Multiple editors contribute content without touching site templates/config.
- You want one-click "commit and sync" from the content repository.

## Required settings in site repository

Repository variables:

- `CONTENT_SOURCE=content_repo`
- `CONTENT_REPO=owner/repo`
- `CONTENT_REF=main` (optional, default `main`)

The deploy workflow pulls content from `CONTENT_REPO` and syncs it into `content/` before build.

## Content layout

For the multilingual `np` recipe, keep language folders in the content repository:

- `en/*.md`
- `ru/*.md`

Mandatory pages expected by rules:

- EN: one `redirect_root`, one `home_en`, one `docs_en`
- RU: one `home_ru`, one `docs_ru`

## Notes

- Keep frontmatter schema compatible with your `rules.yaml` and `rules.ru.yaml`.
- Avoid duplicate slugs per language.
- Keep `search` page in each language if your rules require it.

Continue with [Obsidian Workflow](/en/docs/obsidian-workflow/) for trigger setup.
