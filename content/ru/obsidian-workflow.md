---
type: article_ru
slug: obsidian-workflow
title: Workflow с Obsidian и переменные репозитория
description: Полная настройка one-click обновлений контента через Obsidian Git.
hub: operations
order: 17
draft: false
lang: ru
---

Этот вариант дает авторам нативный поток: редактирование в Obsidian, commit, push, auto-deploy.

## Рекомендуемая архитектура

- Site repo: тема, шаблоны, workflow, rules.
- Content repo: только markdown-файлы.
- Vault Obsidian указывает на корень content-репозитория.

## Настройка content-репозитория

Repository variable:

- `NP_SITE_REPO=owner/repo` (целевой сайт-репозиторий)

Repository secret:

- `NP_DEPLOY_TOKEN` с правами на `repository_dispatch` в `NP_SITE_REPO`

Workflow контент-репозитория отправляет событие `content-updated` в сайт-репозиторий.

## Настройка сайт-репозитория для режима content_repo

Repository variables:

- `CONTENT_SOURCE=content_repo`
- `CONTENT_REPO=owner/repo` (ваш контент-репозиторий)
- `CONTENT_REF=main` (опционально)

## Поток через Obsidian Git

1. Откройте content-репозиторий как vault.
2. Отредактируйте markdown.
3. Запустите "Commit-and-sync" в Obsidian Git.
4. Workflow контент-репозитория автоматически триггерит deploy сайта.

## Вставка изображений Obsidian

В CI embed-ссылки вида `![[cover.webp]]` автоматически нормализуются в стандартные markdown-ссылки на изображения до index/build.
Это позволяет оставлять wiki-стиль для картинок без ручного редактирования путей.

## Рекомендации по токенам

- Public repo: fine-grained PAT с доступом к целевому репозиторию, обычно достаточно repository contents read/write.
- Private repo: аналогично, но целевой репозиторий должен быть явно включен в доступ токена.

Используйте отдельный токен на проект, а не один общий на все.
