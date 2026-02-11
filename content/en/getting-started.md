---
type: article_en
slug: getting-started
title: Getting Started
description: Fast path from zero to a deployed site with default local content mode.
hub: docs
order: 2
draft: false
lang: en
---

This page is the shortest default path. Start with `local` content mode and switch later only if needed.

## Recommended default: local content in the same repo

1. Create your site from a Notepub template repository using **Use this template**.
2. In repo settings, enable GitHub Pages with source **GitHub Actions**.
3. Keep default mode:
- `content.source: local` in `config.yaml`
- markdown files in `content/`
4. Push to `main`.

CI build flow:

- downloads pinned `notepub` binary
- runs index/build scripts
- deploys `dist/` to Pages

## Local run commands

Index:

```bash
./notepub index --config ./config.yaml --rules ./rules.yaml
```

Serve:

```bash
./notepub serve --config ./config.yaml --rules ./rules.yaml
```

Build:

```bash
./notepub build --config ./config.yaml --rules ./rules.yaml --dist ./dist
```

## Content checklist

Every note should have frontmatter compatible with your rules. Minimal example:

```yaml
---
type: article
slug: my-first-note
title: My First Note
draft: false
---
```

## Advanced source modes

- Content from a separate repository: [Content Repository Mode](/en/docs/content-repo/)
- Content from S3-compatible storage: [S3 Content Mode](/en/docs/s3-content/)
- Obsidian one-click flow and required variables/secrets: [Obsidian Workflow](/en/docs/obsidian-workflow/)

Continue with [[Configuration Reference]] and [[rules.yaml Reference]].
