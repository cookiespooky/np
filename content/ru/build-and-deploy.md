---
type: article_ru
slug: build-and-deploy
title: Сборка и деплой
description: Стратегии деплоя в static и server режимах с production-чеклистом.
hub: docs
order: 4
draft: false
lang: ru
---

Эта страница про выбор модели деплоя и проверку production-готовности.

## Режим сборки (`notepub build`)

```bash
notepub build --config ./config.yaml --rules ./rules.yaml --dist ./dist
```

Поведение:

- использует `resolve.json` из artifacts
- автоматически запускает `index`, если `resolve.json` отсутствует (кроме `--no-index`)
- копирует ассеты темы в `dist/assets`
- копирует `sitemap*`, `robots.txt`, `search.json` (если есть)
- генерирует минимальные sitemap/robots, если артефактов нет
- создает `404.html`
- записывает redirect-страницы для `redirect_to`

## Режим сервера (`notepub serve`)

```bash
notepub serve --config ./config.yaml --rules ./rules.yaml
```

`serve` лучше, когда:

- нужен живой контент из S3/local без пересборки
- сервис работает за reverse proxy как долгоживущий процесс

## Куда деплоить

- GitHub Pages: только build-output
- Netlify / Cloudflare Pages / Vercel static: только build-output
- VPS + reverse proxy: serve или static
- S3 static + CDN: build-output и обязательно `site.media_base_url`

## Production-чеклист

- `site.base_url` указывает на финальный canonical URL
- `site.media_base_url` задан для static-хостинга с внешними медиа
- `validate` проходит в CI
- `search.json` присутствует для статического поиска
- в теме есть `notfound.html` для кастомной 404

## Диагностика деплоя

Если страницы открываются, но медиа не грузятся на static-хосте, сначала проверьте `site.media_base_url`.

## Политика источника бинарника

Для воспроизводимой сборки в команде и CI:

- фиксируйте `NOTEPUB_VERSION` (например, `v0.1.3`)
- берите бинарники из GitHub Releases, а не через `latest`
- держите локальные инструкции/скрипты и CI workflow на одной версии
