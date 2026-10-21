---
type: article_en
slug: recipe-structure
title: Content Structure in Template Repositories
description: How the documentation, services and blog templates model page types, the homepage, sections, lists and links between notes.
hub: docs
order: 6
draft: false
lang: en
---

Every note has `type`, `slug` and `title` in its frontmatter; `type` picks the template and the address (`rules.yaml` → `types`). The three official templates use different type sets on the same mechanics.

## Documentation template

- `home` — `/`, the only one of its type.
- `hub` — a section; a page joins it with `hub: ["dev"]`, and the `belongs_to` link plus the `hub_items` collection list it there. Hubs can nest.
- `article`, `page` — content pages, `/{{ slug }}/`; `related: [...]` adds manual links.
- `search` — `/search/`, `footer` — the footer note, loaded on every page.

## Services template

- `home` — template-rendered hero (`title`, `description`, `kicker`, `facts`), the services grid, the note body, recent works and a contact block.
- `services` (`/uslugi/`) and `works` (`/raboty/`) — one page each, listing every `service` and `work`.
- `service` — `/uslugi/{{ slug }}/`, with `price` and `duration` shown in a side card.
- `work` — `/raboty/{{ slug }}/`; `service: "[[restavraciya]]"` ties it to a service, and the `service_works` collection shows it on the service page.
- `page` — with `show_contacts: true` it gets the contacts from `Site.md`.

The menu is a collection: notes with `menu: true`, sorted by `order`.

## Blog template

- `home` — the feed of `post` notes sorted by `date`, paginated (`paginate: { collection: posts_all, per_page: 6, path: "/page/{{ n }}/" }`).
- `post` — `/{{ slug }}/` with `date` and `tags`; posts are marked up as Article and go to the RSS feed (`feed.types: ["post"]`).
- `tags` — one page grouping posts by `tags` (`group_by: { by: fm.tags, multi: true }`).
- `page` — static pages such as "About".

## Lists are collections

Every list on a page is a collection in `rules.yaml`, read in a template as `.Collections.<name>.Items` (or `.Groups` when grouped):

- `filter` — by type and frontmatter (`type_in`, `fm_eq`), sorted by `title`, `slug`, `updated_at` or `fm.<key>`;
- `backrefs` — notes that link to the current page through a link rule (works of a service, pages of a hub);
- `forward` — notes the current page links to (`related`, the service of a work).

See [Collections Reference](/en/docs/collections-reference/).

## Relations

- field links: `hub`, `related`, `service` — a property holding a slug or a `[[wikilink]]`;
- body wikilinks — `[[slug|text]]` in the text, resolved by path, file name or slug ([Links and Wikilinks](/en/docs/links-and-wikilinks/));
- embeds — `![[photo.jpg]]` finds the file by name in `content/` and `media/`, as Obsidian does.

## Modeling your own notes

1. Choose the template whose types are closest and rename types in `rules.yaml` rather than inventing new mechanics.
2. Give every note a `description`: it is the search snippet, the feed item and what `validate --seo` checks.
3. Keep `slug` stable; when you change it, leave a note with `redirect_to`.
4. Mark unfinished notes `draft: true` — collections, search, the feed and the sitemap skip them.
