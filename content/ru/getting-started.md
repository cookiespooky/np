---
type: article_ru
slug: getting-started
title: Быстрый старт
description: Краткий путь от нуля до опубликованного сайта с дефолтным local-режимом.
hub: "docs"
order: 2
draft: false
lang: ru
---
Это самый короткий дефолтный сценарий. Начните с него.
## Рекомендуемый дефолт: local-контент в этом же репозитории

1. Создайте репозиторий для вашего сайта через **Use this template** из шаблона Notepub. [[template-repos|Доступные шаблоны]]
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
- выполняет index + validate + build
- деплоит `dist/` в Pages

## Что обычно делают дальше

После первого деплоя обычно нужно:

- Изменить данные сайта (title, description, base_url и другие параметры): [[configuration|Справочник config.yaml]]
- Изменить шаблоны и внешний вид: [[themes|Темы и шаблоны]]
- Запускать проект локально перед push: [[local-run|Локальный запуск]]
- Если хотите делегировать setup агенту: [[ai-agent-brief|Бриф для AI/MCP-агента]]

Если вы работаете через template-repo, смотрите также [[template-repos|Template-репозитории]].
## Минимальный frontmatter

Перед наполнением контента прочитайте [[recipe-structure|Структура контента в template-репозиториях]] — там типы страниц шаблонов документации, сайта услуг и блога. Поняв, как устроена структура, вы сможете моделировать собственные markdown-миры и собирать статические сайты любой структуры/сложности/вложенности.

Для типового шаблона:

```yaml
---
type: article
slug: my-first-note #canonical url страницы
title: Заголовок страницы # заголовок и <title>; seo_title заменяет второе
description: Описание заметки #оно же SEO метаописание
draft: false
---
```

## Продвинутые режимы источника контента

- Контент из отдельного репозитория: [[content-repo|Режим Content Repository]]
- Контент из S3-совместимого хранилища: [[s3-content|Режим S3]]
- Поток через Obsidian и настройки variables/secrets: [[obsidian-workflow|Workflow с Obsidian]]

Дальше: [[configuration|Справочник config.yaml]] и [[rules-yaml|Справочник rules.yaml]].
