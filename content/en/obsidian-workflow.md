---
type: article_en
slug: obsidian-workflow
title: Obsidian Workflow and Repository Variables
description: Full setup of one-click content updates via Obsidian Git.
hub: operations
order: 17
draft: false
lang: en
---
This option gives authors a native flow: edit in Obsidian, commit, push, auto-deploy.

## Recommended architecture

- Site repo: theme, templates, workflow, rules.
- Content repo: markdown files only.
- Obsidian vault points to content repository root.

## Content repository setup

Repository variable:

- `NP_SITE_REPO=owner/repo` (target site repository)

Repository secret:

- `NP_DEPLOY_TOKEN` with permission to call `repository_dispatch` in `NP_SITE_REPO`

Content repository workflow sends `content-updated` event to site repository.

## Site repository setup for content_repo mode

Repository variables:

- `CONTENT_SOURCE=content_repo`
- `CONTENT_REPO=owner/repo` (your content repository)
- `CONTENT_REF=main` (optional)

## Obsidian Git flow

1. Open content repository as vault.
2. Edit markdown.
3. Run "Commit-and-sync" in Obsidian Git.
4. Content repository workflow automatically triggers site deploy.

## Obsidian handling in current engine

Recent engine versions handle Obsidian markdown syntax natively during `index`/`serve`/`build`.
Pre-build markdown normalization scripts are optional and usually kept only for legacy pipelines.

For `hub` relationships in frontmatter, keep values consistent with your template rules:

- direct slug-like value (`product`)
- or repository conventions documented by your template (if wikilink frontmatter is normalized in that project)

## Token guidance

- Public repo: fine-grained PAT with target repo access, usually repository contents read/write is enough.
- Private repo: same, but target repository must be explicitly included in token access.

Use a dedicated token per project, not one shared token for all projects.
