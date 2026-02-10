---
type: article_en
slug: getting-started
title: Getting Started
description: Fast path from zero to a deployed site.
hub: docs
order: 2
draft: false
lang: en
---

This guide covers both recommended no-code setup and direct CLI setup.

## Path A: template repo + GitHub Pages (recommended)

1. Create your site from a Notepub recipe repo using **Use this template**.
2. In GitHub repository settings, set Pages source to **GitHub Actions**.
3. Edit `config.yaml`:
- set `site.base_url` to your final URL
- keep a trailing slash in your URL value
4. Add/edit markdown in `content/`.
5. Push to `main`.

What happens in CI:

- Downloads pinned `notepub` binary.
- Runs `notepub validate`.
- Runs `notepub build --dist ./dist`.
- Deploys `dist/` to Pages.

## Path B: run locally with CLI

1. Get `notepub` binary (recommended: download from release):

Linux (amd64):

```bash
NOTEPUB_VERSION=v0.1.1
curl -L -o ./notepub "https://github.com/cookiespooky/notepub/releases/download/${NOTEPUB_VERSION}/notepub_linux_amd64"
chmod +x ./notepub
```

macOS (Apple Silicon):

```bash
NOTEPUB_VERSION=v0.1.1
curl -L -o ./notepub "https://github.com/cookiespooky/notepub/releases/download/${NOTEPUB_VERSION}/notepub_darwin_arm64"
chmod +x ./notepub
```

Windows (PowerShell):

```powershell
$env:NOTEPUB_VERSION="v0.1.1"
Invoke-WebRequest -Uri "https://github.com/cookiespooky/notepub/releases/download/$env:NOTEPUB_VERSION/notepub_windows_amd64.exe" -OutFile ".\\notepub.exe"
```

Alternative: build from source:

```bash
go build -o notepub ./cmd/notepub
```

2. Prepare config:

```bash
cp config.example.yaml config.yaml
cp rules.example.yaml rules.yaml
```

3. Set minimum required values:

- `site.base_url`
- `content.source` (`local` or `s3`)
- `s3.bucket` only if `content.source: s3`

4. Validate:

```bash
./notepub validate --config ./config.yaml --rules ./rules.yaml
```

5. Index:

```bash
./notepub index --config ./config.yaml --rules ./rules.yaml
```

6. Serve locally:

```bash
./notepub serve --config ./config.yaml --rules ./rules.yaml
```

7. Build static output:

```bash
./notepub build --config ./config.yaml --rules ./rules.yaml --dist ./dist
```

Windows equivalents:

```powershell
.\notepub.exe validate --config .\config.yaml --rules .\rules.yaml
.\notepub.exe index --config .\config.yaml --rules .\rules.yaml
.\notepub.exe serve --config .\config.yaml --rules .\rules.yaml
.\notepub.exe build --config .\config.yaml --rules .\rules.yaml --dist .\dist
```

## First content file checklist

Every note should include frontmatter aligned with your rules. With default recipe rules, include at least:

```yaml
---
type: article
slug: my-first-note
title: My First Note
description: Optional summary
draft: false
---
```

## Common first-run mistakes

- `site.base_url` missing or malformed.
- `rules.yaml` path wrong.
- `content.local_dir` points to a folder that has no `.md` files.
- S3 source configured but `s3.bucket` missing.

Continue with [[Configuration Reference]] and [[rules.yaml Reference]].
