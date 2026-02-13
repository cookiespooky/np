---
type: article_en
slug: getting-started
title: Getting Started
description: Short path from zero to a published site with default local mode.
hub: docs
order: 2
draft: false
lang: en
---
This is the shortest default scenario. Start here.

## Recommended default: local content in the same repository

1. Create your site repository via **Use this template** from a Notepub template. [Available templates](/en/docs/template-repos/)
![[use-this-template.webp]]
2. In repository settings, enable GitHub Pages with **GitHub Actions** as the source. You can also configure a custom domain there.
![[github-pages.webp]]
3. Push changes to `main`. Build usually takes under a minute. Monitor progress in **Actions**.
![[actions.webp]]
After build, the site will be available at: `https://USER.github.io/REPOSITORY`, where `USER` is your GitHub username and `REPOSITORY` is your repository name. You can always check the current URL in repository Settings -> Pages.

To edit your site content, place your markdown files into `content/` and remove unnecessary starter files.

>**Important:** keep frontmatter structure in your markdown files consistent with your rules, so Notepub can build your site correctly.

![[content.webp]]
CI does:

- downloads pinned `notepub` binary
- runs index/build
- deploys `dist/` to Pages

## What users usually do next

After first deploy, you usually need to:

- Update site metadata (`title`, `description`, `base_url`, etc.): [Configuration Reference](/en/docs/configuration/)
- Customize templates and visual style: [Themes and Templates](/en/docs/themes/)
- Run project locally before push: [Local Run](/en/docs/local-run/)
- Delegate setup to an agent when needed: [AI/MCP Agent Brief](/en/docs/ai-agent-brief/)

If you use template repos, also see [Template Repositories](/en/docs/template-repos/).

## Minimal frontmatter

Before writing lots of content, read [Content Structure in Recipe Repositories](/en/docs/recipe-structure/). It helps you model notes correctly (`home`/`hub`/`article`/`page`/`search`). Once you understand the structure, you can model your own markdown worlds and build static websites of any complexity and nesting.

For a typical recipe:

```yaml
---
type: article
slug: my-first-note # canonical page URL
title: Page title # also SEO title
description: Note description # also SEO meta description
draft: false
---
```

## Advanced content source modes

- Content from a separate repository: [Content Repository Mode](/en/docs/content-repo/)
- Content from S3-compatible storage: [S3 Content Mode](/en/docs/s3-content/)
- Obsidian flow and required variables/secrets: [Obsidian Workflow](/en/docs/obsidian-workflow/)

Next: [Configuration Reference](/en/docs/configuration/) and [rules.yaml Reference](/en/docs/rules-yaml/).
