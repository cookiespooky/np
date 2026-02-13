---
type: article_en
slug: local-run
title: Local Run
description: How to run Notepub locally for development and build flows.
hub: docs
order: 5
draft: false
lang: en
---

This page covers a quick local run workflow before deploy.

## Notepub binary

You need the `notepub` binary for build/render.

For recipe repositories, use one of these options:

- Download release binary `notepub` into project root (usually `./notepub`).
or
- Install via Go (`go install ...`) and run `notepub` from `PATH`.
or
- Run without a separate binary using `go run`.

Examples below use `NOTEPUB_BIN`.

## Where to run commands

Run commands from the root of your site repository, where you have:

- `config.yaml`
- `rules.yaml`
- `content/`

Example:

```bash
cd /path/to/your-site-repo
```

## Minimal commands

Index:

```bash
NOTEPUB_BIN=./notepub
$NOTEPUB_BIN index --config ./config.yaml --rules ./rules.yaml
```

Serve:

```bash
$NOTEPUB_BIN serve --config ./config.yaml --rules ./rules.yaml
```

Build:

```bash
$NOTEPUB_BIN build --config ./config.yaml --rules ./rules.yaml --dist ./dist
```

## When to use

- `index` - prepare `resolve.json` and artifacts.
- `serve` - preview site locally in server mode.
- `build` - produce static output in `dist/`.

For full flags reference, see [Commands](/en/docs/commands/).
