---
type: article_en
slug: vendor-lock-in
title: Portability and Vendor Lock-in
description: Why Markdown + declarative rules reduce platform lock-in risk.
hub: concepts
order: 3
draft: false
lang: en
---

Notepub keeps lock-in low by separating concerns cleanly:

- Content: plain Markdown files.
- Structure: YAML rules.
- Presentation: templates + CSS/JS assets.
- Output: static HTML and JSON/XML artifacts.

## Practical portability outcomes

- You can move content to another static generator with a transform step.
- You can change hosting providers without changing your source files.
- You can keep old generated snapshots independent from runtime servers.

## What is still coupled

- Your chosen frontmatter conventions.
- Your theme template contract.
- Custom rules semantics around links/collections.

These are still easier to migrate than database-driven CMS internals.
