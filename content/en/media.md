---
type: article_en
slug: media
title: Media and Images
description: How media links are resolved in serve and build modes.
hub: authoring
order: 3
draft: false
lang: en
---

Notepub rewrites image references from markdown and Obsidian embeds.

## Supported image syntaxes

- Markdown image: `![alt](path/to/image.png)`
- Obsidian embed: `!\[\[image.png\]\]`
- Obsidian embed with alt-like label: `!\[\[image.png|Cover image\]\]`

## Serve mode behavior

- Relative media links are resolved to `/media/...` unless `site.media_base_url` is set.
- `/media/*` is guarded by indexed references by default.
- Set `media.expose_all_under_prefix: true` to expose all media under prefix.

## Build mode behavior

- Relative media links should resolve to an absolute asset base for static hosts.
- Set `site.media_base_url` to CDN/bucket base URL.
- Without `site.media_base_url`, static output may contain `/media/*` URLs that do not work on pure static hosts.

## Security and path handling

- External URLs (`http`, `https`, `data`, protocol-relative) are not rewritten.
- Unsafe traversal keys are rejected.
- Media paths are escaped before URL output.
