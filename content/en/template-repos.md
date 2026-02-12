---
type: article_en
slug: template-repos
title: Template Repos
description: How recipe repositories are structured and when to customize them.
hub: docs
order: 3
draft: false
lang: en
---

Template repos are the default distribution model for most users.

## Official template repositories

- Blog template: https://github.com/cookiespooky/notepub-recipe-blog
- Documentation template: https://github.com/cookiespooky/notepub-recipe-docs
- Content repo template for `content_repo` mode: https://github.com/cookiespooky/np-content-template

## What a template repo gives you

- Working `config.yaml` and `rules.yaml`.
- Starter theme in `theme/`.
- Initial content in `content/`.
- CI workflow for validate + build + deploy.

## Minimal customization sequence

1. Update `site.base_url`.
2. Replace starter content files.
3. Update site brand values (`site.title`, `site.description`, theme assets).
4. Adjust rules only when your content model outgrows defaults.

## When to fork template logic

Fork the workflow or project structure if you need:

- custom build matrix or multi-environment deploys
- stricter validation gates
- custom binary source/version policy
- non-GitHub deployment target

## Upgrade strategy

- Keep your own content and rules as the source of truth.
- Upgrade notepub binary version in CI in small increments.
- Run `validate` before every upgrade rollout.
