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
