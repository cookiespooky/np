---
type: article_en
slug: s3-content
title: S3 Content Mode
description: Build and serve using markdown from S3-compatible storage.
hub: operations
order: 16
draft: false
lang: en
---

Use this mode when markdown is stored in S3-compatible object storage.

## Required settings in site repository

Repository variables:

- `CONTENT_SOURCE=s3`
- `S3_ENDPOINT`
- `S3_REGION`
- `S3_BUCKET`
- `S3_PREFIX_EN` (optional, default `content/en`)
- `S3_PREFIX_RU` (optional, default `content/ru`)
- `S3_USE_PATH_STYLE` (optional, default `true`)

Repository secrets:

- `S3_ACCESS_KEY`
- `S3_SECRET_KEY`

## How workflow applies S3 mode

- Workflow generates runtime config overrides for EN and RU.
- `content.source` is set to `s3`.
- Prefixes are split by language (`S3_PREFIX_EN`, `S3_PREFIX_RU`).
- Build then runs with those effective configs.

## Bucket layout

Recommended object keys:

- `content/en/*.md`
- `content/ru/*.md`

This matches default prefixes and keeps language separation explicit.

## Troubleshooting

- Missing `S3_BUCKET` or keys causes workflow failure before build.
- Missing required markdown types still fails validation at index stage.
- If serve mode works locally but CI fails, check S3 credentials scope and bucket policy.
