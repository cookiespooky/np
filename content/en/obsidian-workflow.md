---
type: article_en
slug: obsidian-workflow
title: Obsidian Workflow and Repo Variables
description: End-to-end setup for one-click content updates via Obsidian Git.
hub: operations
order: 17
draft: false
lang: en
---

This setup gives authors a native editing flow: edit in Obsidian, commit, push, auto-deploy.

## Recommended architecture

- Site repo: templates, theme, workflow, rules.
- Content repo: markdown files only.
- Obsidian vault points to the content repo root.

## Content repo setup

Repository variable:

- `NP_SITE_REPO=owner/repo` (target site repository)

Repository secret:

- `NP_DEPLOY_TOKEN` with permission to call `repository_dispatch` on `NP_SITE_REPO`

Workflow in content repo sends `content-updated` dispatch to the site repo.

## Site repo setup for content repo mode

Repository variables:

- `CONTENT_SOURCE=content_repo`
- `CONTENT_REPO=owner/repo` (your content repository)
- `CONTENT_REF=main` (optional)

## Obsidian Git plugin flow

1. Open content repo as vault.
2. Edit markdown notes.
3. Run "Commit-and-sync" in Obsidian Git.
4. Content repo workflow triggers site deploy automatically.

## Obsidian image embeds

In CI, image embeds like `![[cover.webp]]` are normalized to standard markdown image links before index/build.
This lets authors keep wiki-style embeds for images without manual path edits.

## Token scope guidance

- Public repos: fine-grained PAT with access to target repo, repository contents read/write is sufficient.
- Private repos: same, but repo must be explicitly included in token access list.

Use one token per project instead of reusing a global token.
