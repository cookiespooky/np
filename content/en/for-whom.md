---
type: article_en
slug: for-whom
title: Who Notepub Is For
description: Typical use cases, team fit, and where Notepub is not the best choice.
hub: concepts
order: 1
draft: false
lang: en
---

## Great fit

- Writers and teams that keep content in Markdown.
- Obsidian users that want wikilink-friendly publishing.
- Documentation and knowledge-base projects that need static output.
- Projects needing transparent, Git-based content review.

## Possible fit with extra work

- Large multi-site deployments using custom CI and theme systems.
- Catalog-like websites that need declarative grouping and link graph logic.

## Poor fit

- Teams requiring built-in WYSIWYG editorial workflow, drafts approval UI, and role permissions in-app.
- Highly dynamic products where server-side app logic is the core product (Notepub is a publishing engine, not a full app platform).

## Why teams choose it

- Predictable output from plain text + YAML rules.
- No database schema migrations for content changes.
- Portable stack: Markdown + templates + static artifacts.
