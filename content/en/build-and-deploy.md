---
type: article_en
slug: build-and-deploy
title: Build and Deploy
description: Static and server deployment strategies with production checklists.
hub: docs
order: 4
draft: false
lang: en
---

This page focuses on deployment decisions and production safety checks.

## Build mode (`notepub build`)

```bash
notepub build --config ./config.yaml --rules ./rules.yaml --dist ./dist
```

Build behavior:

- Uses `resolve.json` from artifacts.
- Runs `index` automatically if `resolve.json` is missing (unless `--no-index`).
- Copies theme assets to `dist/assets`.
- Copies `sitemap*`, `robots.txt`, and `search.json` if present.
- Generates minimal sitemap/robots if artifacts are missing.
- Creates `404.html`.
- Writes redirect pages for `redirect_to` routes.

## Serve mode (`notepub serve`)

```bash
notepub serve --config ./config.yaml --rules ./rules.yaml
```

Serve mode is best when:

- you want live content from S3/local without rebuilding static files
- you run behind a reverse proxy and keep one long-running process

## Hosting targets

- GitHub Pages: build output only.
- Netlify/Cloudflare Pages/Vercel static mode: build output only.
- VPS + reverse proxy: use serve mode or static mode.
- S3 static hosting + CDN: build output; strongly set `site.media_base_url`.

## Production checklist

- `site.base_url` points to the final canonical domain/path.
- `site.media_base_url` is set for static hosting if media assets are external.
- `validate` passes in CI.
- `search.json` is generated/copied for static search pages.
- theme contains `notfound.html` for custom 404.
- `validate --seo` has no warnings you did not mean to keep.
- a site under a path (`https://example.com/docs/`) lists its sitemap in the root `robots.txt` of the host.

## Deploy debugging

If pages render but media is broken on static host, fix `site.media_base_url` first.

If canonical URLs name another host than the one the site opens on, or every menu link opens in a new tab, the site was built for a different address. On GitHub Pages, take the address from `actions/configure-pages` (`steps.pages.outputs.base_url`) rather than building `owner.github.io/repo` yourself: when the account's user site has a custom domain, every project site moves to that domain, and it is only reflected after the project site is rebuilt.

## Binary source policy

For reproducible builds in teams and CI:

- pin `NOTEPUB_VERSION` (for example, `v0.1.9`)
- download binaries from GitHub Releases instead of using `latest`
- keep local docs/scripts and CI workflow on the same pinned version

For template-based repos, also run:

```bash
notepub template check
```

before rollouts to catch infrastructure drift.
