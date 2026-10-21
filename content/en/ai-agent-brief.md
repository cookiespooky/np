---
type: article_en
slug: ai-agent-brief
title: AI/MCP Agent Brief
description: Minimal task contract so an agent can build and deploy a Notepub site without long clarification loops.
hub: docs
order: 7
draft: false
lang: en
---

Use this page if you want to delegate site setup/deploy to an AI agent.

If you are new to Notepub, go through:
[[getting-started|Getting Started]], [[template-repos|Template Repositories]], and [[recipe-structure|Content Structure in Template Repositories]].

Short links to full docs:

- RU: https://antonlozhkin.ru/np/ru/docs/
- EN: https://antonlozhkin.ru/np/en/docs/

## What to tell the agent first

1. Project goal: `blog` or `docs`.
2. Scenario: `one-repo` (template site repo) or `content_repo`.
`one-repo` = one site repo with both content and theme - the simple default option.  
`content_repo` = separate content repository. Details: [[content-repo|Content Repository Mode]].
3. Repository URL and name: `owner/repo` (and content repo too, if `content_repo` mode is selected).
4. Working directory on your local machine (absolute path).
5. Language(s) and content structure (for example EN only or EN+RU).
6. Allowed change scope: only `content/`, or also `theme/`, `rules.yaml`, workflow.
For S3 source mode, see: [[s3-content|S3 Content Mode]].

## Access the agent needs

1. Git repository access (clone/push).
2. Permissions for GitHub Actions and GitHub Pages in target repository.
3. Permission to read/create repository Variables and Secrets (if `content_repo` or `s3` is used).
4. If custom domain is used: access to DNS/domain settings.

## Minimal inputs that often block agents when missing

1. `site.base_url` (final canonical URL).
2. Site name and description (`site.title`, `site.description`).
3. Initial page set (at least `home`, `search`, and 2-3 working pages/articles).
4. Slug policy: whether existing slugs can be changed or only changed via redirects.

References for these inputs:

- [[configuration|Configuration Reference]]
- [[rules-yaml|rules.yaml Reference]]
- [[content-authoring|Authoring Guide]]

## Definition of Done

1. Build/deploy workflow completed successfully on `main`.
2. Site opens on Pages URL with no key-route 404.
3. Search works and returns results by `title/description`.
4. `sitemap.xml` and `robots.txt` are accessible.
5. Repository contains a short README "how to update content".

Local run and deploy references:

- [[local-run|Local Run]]
- [[build-and-deploy|Build and Deploy]]

## Ready-to-use prompt template

```text
Build a Notepub site end-to-end.

Context:
- Scenario: one-repo
- Template: np-template-blog (or np-template-docs, np-template-services)
- Repository: <owner/repo>
- Local folder: <abs-path>
- Language: EN
- Branding: <site title>, <description>
- Base URL: <https://.../>

Constraints:
- Allowed edits: content/, media/, Site.md, Interface.md, .np/rules.yaml, .np/theme/
- Restricted edits: <if any constraints>

Done criteria:
1) deploy workflow is green
2) site is available on Pages URL
3) search works
4) sitemap/robots are available
5) add README with content update steps
```

## What to verify manually after agent work

1. Correct `base_url` and canonical links.
2. No duplicate slugs or route conflicts.
3. Correct menu/hub structure and internal links.
4. Visual result matches expected structure and style.
