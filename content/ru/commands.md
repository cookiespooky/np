---
type: article_ru
slug: commands
title: Команды
description: Полный справочник команд notepub — index, serve, build, validate, template — с флагами и кодами выхода.
hub: operations
order: 1
draft: false
lang: ru
---

## Список команд

```bash
notepub index
notepub serve
notepub build
notepub validate
notepub audit
notepub type add <имя>
notepub template check
notepub template update --apply
notepub help
notepub version
```

## Приоритет путей

Разрешение пути config:

1. `--config`
2. `CONFIG_PATH`
3. `config.yaml`

Разрешение пути rules:

1. `--rules`
2. `RULES_PATH`
3. `rules_path` из config
4. `rules.yaml` рядом с config или в текущей директории

## `index`

```bash
notepub index --config ./config.yaml --rules ./rules.yaml
```

- валидирует rules
- сканирует контент-источник
- обновляет snapshot и artifacts
- завершает работу с ошибкой при нарушениях контракта

## `serve`

```bash
notepub serve --config ./config.yaml --rules ./rules.yaml --addr :8081
```

- загружает тему и resolve store
- отдает маршруты, assets, media, search endpoints
- поддерживает graceful shutdown по SIGINT/SIGTERM

## `build`

```bash
notepub build --config ./config.yaml --rules ./rules.yaml --dist ./dist
```

Флаги:

- `--dist` — директория output
- `--artifacts` — директория артефактов
- `--no-index` — не запускать auto-index при отсутствии resolve
- `--generate-search` — сгенерировать `search.json`, если он отсутствует

## `validate`

```bash
notepub validate --config ./config.yaml --rules ./rules.yaml --links
```

Флаги:

- `--resolve` — явный путь к resolve-файлу
- `--links` — валидация связей (нужен resolve.json)
- `--markdown` — markdown-диагностика
- `--markdown-strict` — падение команды при markdown-warning
- `--markdown-format text|json` — формат вывода диагностики
- `--output <path>` — запись markdown-диагностики в файл
- `--seo` — проверка заголовков, описаний, изолированных страниц, robots и lastmod ([[seo|Справочник по SEO]])
- `--seo-strict` — падение команды при SEO-warning
- `--seo-format text|json` — формат вывода находок SEO

Примеры:

```bash
notepub validate --config ./config.yaml --rules ./rules.yaml --resolve ./artifacts/resolve.json --markdown
notepub validate --config ./config.yaml --rules ./rules.yaml --resolve ./artifacts/resolve.json --markdown --markdown-strict
notepub validate --config ./config.yaml --rules ./rules.yaml --resolve ./artifacts/resolve.json --seo
```

## `audit`

```bash
notepub audit --config ./config.yaml --dist ./dist
notepub audit --dist ./dist --base-url https://example.com/docs/ --strict
```

Проверяет готовый сайт так, как его видит поисковик, без интернета: заголовки, описания, уровни заголовков, canonical, OpenGraph и размер `og:image`, значок, viewport, JSON-LD, `alt`, ссылки и картинки, которые никуда не ведут или ведут через перенаправление, страницы, на которые никто не ссылается (с учётом меню), `robots.txt`, карту сайта против сборки, `llms.txt`, `404.html`. Коды и уровни — [[seo|Справочник по SEO]].

Флаги:

- `--dist` — готовый сайт (по умолчанию `./dist`)
- `--config` — взять `site.base_url` из конфига
- `--base-url` — адрес, по которому сайт будет открываться (важнее конфига)
- `--strict` — падать и на предупреждениях
- `--format text|json` — формат вывода

Ошибки всегда валят команду, так что шаг деплоя останавливается на битой ссылке.

## `type add`

```bash
notepub type add service
notepub type add case --permalink "/cases/{{ slug }}/" --from article.html
```

Добавляет вид страниц: тип в `rules.yaml` (комментарии, порядок и отступы сохраняются) и его шаблон — копию `page.html`. Заметка с `type: service` при следующей сборке становится страницей `/service/<slug>/`.

Флаги:

- `--permalink` — шаблон адреса (по умолчанию `/<имя>/{{ slug }}/`)
- `--template` — имя файла шаблона (по умолчанию `<имя>.html`); существующий не перезаписывается
- `--from` — какой шаблон скопировать (по умолчанию `page.html`)
- `--no-sitemap`, `--no-search` — не включать тип в карту сайта или поиск
- `--config`, `--rules` — как у остальных команд

## `template check` / `template update`

```bash
notepub template check
notepub template update
notepub template update --apply
```

- `template check`: статус инфраструктуры шаблона + manual findings.
- `template update`: dry-run по умолчанию.
- `template update --apply`: обновляет распознанные инфраструктурные файлы (build/workflow/config wiring), не трогая контент.
- `template check` также сообщает, датируются ли страницы по коммитам и запускает ли сборка проверку SEO.

## Коды выхода

- `0` — успех
- `1` — runtime/config/content ошибки
- `2` — ошибки использования/флагов
