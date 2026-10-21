---
type: article_ru
slug: media
title: Медиа и изображения
description: Как резолвятся медиа-ссылки в режимах serve и build.
hub: authoring
order: 3
draft: false
lang: ru
---

Notepub переписывает ссылки на изображения из markdown и Obsidian-embed синтаксиса.

Актуальные версии движка поддерживают Obsidian-синтаксис нативно в `serve`/`build`,
поэтому pre-build rewrite-скрипты для markdown обычно нужны только в legacy-пайплайнах.

## Поддерживаемые синтаксисы

- Markdown image: `![alt](path/to/image.png)`
- Obsidian embed: `!\[\[image.png\]\]`
- Obsidian embed с подписью: `!\[\[image.png|Cover image\]\]`
- Video embed: `!\[\[demo.mp4\]\]` (рендерится как `<video ...>` для поддерживаемых расширений)

## Как вставка находит файл

Вставка Obsidian называет файл так же, как его ищет Obsidian, поэтому заметки могут лежать в любых папках:

1. рядом с заметкой (`content/works/photo.jpg` для заметки из `content/works/`);
2. от корня папки контента (`![[photos/photo.jpg]]`);
3. по имени файла в любой папке контента и в `media.dirs` — если файлов с таким именем несколько, побеждает самый короткий путь.

Markdown-картинка (`![alt](photo.jpg)`) остаётся относительной к заметке. Вставку файла, которого нет нигде, `validate --markdown` показывает как `NP-MD-EMBED-MISSING`. Первая картинка заметки — вставка или Markdown — становится её `og:image`, если не задан `og_image`.

В template-репозиториях картинки лежат в `content/` или `media/`, а в конфиге стоит `media.dirs: ["../media"]`.

## Поведение в serve

- Относительные медиа-ссылки преобразуются в `/media/...`, если не задан `site.media_base_url`.
- `/media/*` по умолчанию отдает только медиа, найденные в индексированном markdown.
- `media.expose_all_under_prefix: true` открывает все медиа под заданным prefix.

## Поведение в build

- Для статических хостов медиа должны резолвиться в абсолютную базу.
- Используйте `site.media_base_url` (CDN/bucket URL).
- Без `site.media_base_url` ссылки `/media/*` на чисто статическом хосте обычно не работают.

## Безопасность

- Внешние URL (`http`, `https`, `data`, protocol-relative) не переписываются.
- Небезопасные traversal-пути отбрасываются.
- Пути экранируются перед выводом в URL.
