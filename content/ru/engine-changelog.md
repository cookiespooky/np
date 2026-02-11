---
type: article_ru
slug: engine-changelog
title: Журнал изменений движка
description: Изменения в движке Notepub после последнего коммита и их влияние на поведение.
hub: reference
order: 5
draft: false
lang: ru
---

Базовая точка отсчета: коммит `4c8f9a8` (`2026-02-06`, `chore: clean core repo, add release workflow`).

Ниже перечислены изменения в коде движка после этого коммита, которые сейчас есть в рабочем дереве.

## Релиз `v0.1.3` (`2026-02-11`)

1. Кроссплатформенная блокировка файла в indexer

- Файлы: `internal/indexer/indexer.go`, `internal/indexer/filelock_unix.go`, `internal/indexer/filelock_nonunix.go`
- Использование `syscall.Flock` вынесено в OS-специфичные обертки.
- Результат: релизная сборка теперь компилируется для `windows_amd64` и всех целевых платформ.
- Поведение в рантайме:
  - unix: сохраняется неблокирующий эксклюзивный lock;
  - non-unix: best-effort fallback lock.

2. Восстановлен релизный pipeline

- Workflow для тега `v0.1.2` падал на шаге `Build binaries` из-за непереносимого lock-кода.
- Релиз `v0.1.3` завершен успешно с полным набором артефактов:
  - `notepub_darwin_amd64`
  - `notepub_darwin_arm64`
  - `notepub_linux_amd64`
  - `notepub_linux_arm64`
  - `notepub_windows_amd64.exe`
  - `checksums.txt`

Что обновить в recipe/docs:

- зафиксировать `NOTEPUB_VERSION` на `v0.1.3` в CI workflows и инструкциях.

1. `internal/serve/server.go`

- В обработчике `/search` добавлена загрузка resolve-индекса и построение `data.Collections`.
- Практический эффект: страница поиска теперь получает ту же структуру коллекций/хабов, что и другие страницы, и может рендерить полноценный sidebar документации.
- Изменение безопасно по обратной совместимости: если индекс недоступен, логика продолжает работать без падения.

- В `renderNotFound` добавлен заголовок `Content-Type: text/html; charset=utf-8`.
- Практический эффект: 404-страница рендерится браузером как HTML, а не как сырой текст.
- Это улучшает отображение и корректную обработку кириллицы.

2. `internal/serve/theme.go`

- В `embed` добавлено включение `embed/templates/partials/*.html`.
- Практический эффект: partial-шаблоны теперь гарантированно попадают во встроенную тему бинарника.
- Это важно для универсальности standalone-режима, когда тема не читается с диска.

Проверка после обновлений:

- Запустить `notepub index --config ./config.yaml --rules ./rules.yaml`.
- Проверить, что `/search` показывает sidebar с хабами и статьями.
- Проверить 404 по несуществующему URL: страница должна отображаться как обычный HTML-шаблон.
