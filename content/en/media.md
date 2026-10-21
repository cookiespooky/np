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

Current engine versions support Obsidian syntax natively in serve/build paths,
so pre-build markdown rewrite scripts are optional and mostly legacy.

## Supported image syntaxes

- Markdown image: `![alt](path/to/image.png)`
- Obsidian embed: `!\[\[image.png\]\]`
- Obsidian embed with alt-like label: `!\[\[image.png|Cover image\]\]`
- Video embed: `!\[\[demo.mp4\]\]` (renders as `<video ...>` for supported extensions)

## How an embed finds its file

An Obsidian embed names a file the way Obsidian does, so notes can live in any folder:

1. next to the note (`content/works/photo.jpg` for a note in `content/works/`);
2. from the content root (`![[photos/photo.jpg]]`);
3. by file name anywhere in the content folder and in `media.dirs` — the shortest path wins when several files share a name.

A Markdown image (`![alt](photo.jpg)`) stays relative to the note. `validate --markdown` reports an embed whose file exists nowhere as `NP-MD-EMBED-MISSING`. The first image of a note — embed or Markdown — becomes its `og:image` unless `og_image` is set.

Template repositories keep images in `content/` or `media/` and set `media.dirs: ["../media"]`.

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
