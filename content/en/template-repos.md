---
type: article_en
slug: template-repos
title: Template Repositories
description: How recipe repositories are structured and when to customize them.
hub: docs
order: 3
draft: false
lang: en
---
Template repositories are the default way to start Notepub for most users.

## Official template repositories

- Blog template: https://github.com/cookiespooky/notepub-recipe-blog
- Documentation template: https://github.com/cookiespooky/notepub-recipe-docs
- Content repository template for `content_repo` mode: https://github.com/cookiespooky/np-content-template

## What a template repo provides

- Working `config.yaml` and `rules.yaml`.
- Starter theme in `theme/`.
- Initial content in `content/`.
- CI workflow for validate + build + deploy.

## Minimal customization sequence

1. Update `site.base_url`.
2. Replace starter content files.
3. Update brand values (`site.title`, `site.description`, theme assets).
4. Change rules when the default model no longer covers your use case.

## When to fork workflow

If you need:

- multiple environments/stages
- stricter CI validations
- custom binary version policy
- deploy target outside GitHub

## Upgrade strategy

- Keep content and rules as your primary source of truth.
- Upgrade `notepub` version in CI gradually.
- Always run `validate` before rollout.
