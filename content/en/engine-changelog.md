---
type: article_en
slug: engine-changelog
title: Engine Changelog
description: Engine updates after the latest commit and their runtime impact.
hub: reference
order: 5
draft: false
lang: en
---

Baseline commit: `4c8f9a8` (`2026-02-06`, `chore: clean core repo, add release workflow`).

This page lists engine changes added after that commit.

## Release `v0.1.3` (`2026-02-11`)

1. Cross-platform file lock in indexer

- Files: `internal/indexer/indexer.go`, `internal/indexer/filelock_unix.go`, `internal/indexer/filelock_nonunix.go`
- `syscall.Flock` usage was moved behind OS-specific wrappers.
- Result: release builds now compile for `windows_amd64` and all configured targets.
- Runtime behavior:
  - unix: keeps non-blocking exclusive lock behavior;
  - non-unix: best-effort fallback lock implementation.

2. Release pipeline recovered

- Tag `v0.1.2` workflow failed at `Build binaries` because of non-portable lock code.
- `v0.1.3` release completed successfully with full artifact set:
  - `notepub_darwin_amd64`
  - `notepub_darwin_arm64`
  - `notepub_linux_amd64`
  - `notepub_linux_arm64`
  - `notepub_windows_amd64.exe`
  - `checksums.txt`

Action for recipes and docs:

- update pinned `NOTEPUB_VERSION` to `v0.1.3` in CI workflows and setup instructions.

1. `internal/serve/server.go`

- `/search` handler now loads resolve index and sets `data.Collections`.
- Result: search page can render the same docs hub/sidebar structure as other docs pages.
- Compatibility: if resolve index is unavailable, rendering continues without panic.

- `renderNotFound` now sets `Content-Type: text/html; charset=utf-8`.
- Result: 404 is rendered as HTML, not plain text.
- This also improves non-latin text rendering.

2. `internal/serve/theme.go`

- `embed` now includes `embed/templates/partials/*.html`.
- Result: partial templates are bundled into the embedded fallback theme.
- This keeps standalone binary behavior consistent when filesystem theme is unavailable.

Verification checklist:

- Run `notepub index --config ./config.yaml --rules ./rules.yaml`.
- Open `/search` and confirm docs sidebar is visible.
- Open a non-existing URL and confirm 404 is rendered by the theme template.
