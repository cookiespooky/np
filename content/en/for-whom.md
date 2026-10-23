---
type: article_en
slug: for-whom
title: Who Notepub Is For
description: Who gets the most from Notepub — a folder of Obsidian notes turned into a structured site — and where another tool fits better.
hub: concepts
order: 1
draft: false
lang: en
---
Notepub turns a folder of Markdown notes — an Obsidian vault as it is — into a site with structure: services, cases, articles, each kind of note its own kind of page. That combination is what it is for.

## Great fit

- **A service business or a freelancer whose site is a set of typed pages** — services, cases, team, articles. Each is a note type in `rules.yaml` (`notepub type add service`), so a new service is a new note, not a new page in a CMS.
- **People who already write in Obsidian.** Wikilinks, embeds, callouts and footnotes work without rewriting notes; `validate --markdown` lists what the vault uses and what the engine supports. Publishing is a commit from the vault (the Obsidian Git plugin does it in one command).
- **Sites that must pass an SEO review.** Canonical, sitemap with real dates, OpenGraph, schema.org markup and `llms.txt` are generated; `notepub audit` checks the built site against the checklist before it goes out and can stop a deploy on a broken link.
- **Sites whose text is written by the client and whose layout is kept by a developer**: content can come from another repository or S3.

## Possible fit with extra work

- Documentation and knowledge bases: they work, but Docusaurus or MkDocs give versioning and ready themes Notepub does not have.
- Catalogs with many grouped pages: collections and pagination exist, filters do not.

## Poor fit

- Teams that need an editor in the browser, approval steps and roles inside the tool.
- Products where server logic is the point: shops with carts, accounts, dashboards. Notepub writes files; forms and payments go through a bot, a payment link or a separate function.
- Projects that want a large theme and plugin ecosystem: there is none yet, and the engine is at 0.1.x.

## Compared with other generators

What every static generator shares — no database, plain files, hosting anywhere, nothing to patch on the server — is true of Notepub too, and is not a reason to choose it over Hugo or Astro. The reasons are narrower:

- vs Hugo, Jekyll, Astro: notes stay Obsidian notes, and structure comes from note types rather than folders;
- vs Quartz and other "digital garden" tools: typed pages, collections and the SEO checks of a commercial site;
- vs all of them: the SEO checklist is part of the build, not a manual review afterwards.
