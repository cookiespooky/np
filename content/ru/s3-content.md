---
type: article_ru
slug: s3-content
title: Режим S3
description: Сборка и публикация с markdown-контентом из S3-совместимого хранилища.
hub: operations
order: 16
draft: false
lang: ru
---

Используйте этот режим, когда markdown лежит в объектном хранилище S3.

## Обязательные настройки в сайт-репозитории

Repository variables:

- `CONTENT_SOURCE=s3`
- `S3_ENDPOINT`
- `S3_REGION`
- `S3_BUCKET`
- `S3_PREFIX_EN` (опционально, по умолчанию `content/en`)
- `S3_PREFIX_RU` (опционально, по умолчанию `content/ru`)
- `S3_USE_PATH_STYLE` (опционально, по умолчанию `true`)

Repository secrets:

- `S3_ACCESS_KEY`
- `S3_SECRET_KEY`

## Как workflow применяет S3-режим

- Workflow генерирует runtime override-конфиги для EN и RU.
- `content.source` переключается на `s3`.
- Префиксы задаются отдельно для каждого языка (`S3_PREFIX_EN`, `S3_PREFIX_RU`).
- Сборка выполняется с этими эффективными конфигами.

## Рекомендуемая структура bucket

Ключи объектов:

- `content/en/*.md`
- `content/ru/*.md`

Это соответствует дефолтным префиксам и явно разделяет языки.

## Диагностика

- При отсутствии `S3_BUCKET` или ключей workflow завершится ошибкой до build.
- При отсутствии обязательных типов markdown rules validation остановит index.
- Если локальный `serve` работает, а CI нет, проверьте scope ключей и bucket policy.
