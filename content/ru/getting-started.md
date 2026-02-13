---
type: article_ru
slug: getting-started
title: Быстрый старт
description: Краткий путь от нуля до опубликованного сайта с дефолтным local-режимом.
hub: "[[docs]]"
order: 2
draft: false
lang: ru
---
Это самый короткий дефолтный сценарий. Начните с него.
## Рекомендуемый дефолт: local-контент в этом же репозитории

1. Создайте репозиторий для вашего сайта через **Use this template** из шаблона Notepub. [Доступные шаблоны](/ru/docs/template-repos/)
![](/media/use-this-template.webp)
2. В настройках репозитория включите GitHub Pages с источником **GitHub Actions**. Здесь же можно указать собственный домен.
![](/media/github-pages.webp)
3. Push изменения в `main`. Сборка занимает менее минуты. Процесс можно наблюдать в разделе **Actions**.
![](/media/actions.webp)
После сборки сайт будет доступен по адресу: https://USER.github.io/REPOSITORY, где USER - ваш GitHub username, а REPOSITORY - название репозитория. Актуальную ссылку можно посмотреть в разделе Settings - Pages репозитория.

Чтобы отредактировать контент вашего сайта, положите ваши markdown-файлы в content/ и удалите лишние.

>**Важно учитывать frontmatter-разметку в ваших markdown-файлах**, чтобы Notepub правильно понимал как собирать ваш сайт.
>Читайте ниже.

![](/media/content.webp)
Что делает CI:

- скачивает зафиксированный бинарник `notepub`
- выполняет index/build
- деплоит `dist/` в Pages

## Что обычно делают дальше

После первого деплоя обычно нужно:

- Изменить данные сайта (title, description, base_url и другие параметры): [Справочник config.yaml](/ru/docs/configuration/)
- Изменить шаблоны и внешний вид: [Темы и шаблоны](/ru/docs/themes/)
- Запускать проект локально перед push: [Локальный запуск](/ru/docs/local-run/)
- Если хотите делегировать setup агенту: [Бриф для AI/MCP-агента](/ru/docs/ai-agent-brief/)

Если вы работаете через template-repo, смотрите также [Template-репозитории](/ru/docs/template-repos/).
## Минимальный frontmatter

Перед наполнением контента прочитайте [Структура контента в recipe-репозиториях](/ru/docs/recipe-structure/) — это поможет сразу разложить заметки по правильной модели шаблона (`home`/`hub`/`article`/`page`/`search`). Поняв, как устроена структура, вы сможете моделировать собственные markdown-миры и собирать статические сайты любой структуры/сложности/вложенности.

Для типового recipe:

```yaml
---
type: article
slug: my-first-note #canonical url страницы
title: Заголовок страницы #он же SEO-заголовок
description: Описание заметки #оно же SEO метаописание
draft: false
---
```

## Продвинутые режимы источника контента

- Контент из отдельного репозитория: [Режим Content Repository](/ru/docs/content-repo/)
- Контент из S3-совместимого хранилища: [Режим S3](/ru/docs/s3-content/)
- Поток через Obsidian и настройки variables/secrets: [Workflow с Obsidian](/ru/docs/obsidian-workflow/)

Дальше: [Справочник config.yaml](/ru/docs/configuration/) и [Справочник rules.yaml](/ru/docs/rules-yaml/).
