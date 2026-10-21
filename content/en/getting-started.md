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

1. Create your site repository via **Use this template** from a Notepub template. [[template-repos|Available templates]]
![](/media/use-this-template.webp)
2. In repository settings, enable GitHub Pages with **GitHub Actions** as the source. You can also configure a custom domain there.
![](/media/github-pages.webp)
3. Push changes to `main`. Build usually takes under a minute. Monitor progress in **Actions**.
![](/media/actions.webp)
After build, the site will be available at: `https://USER.github.io/REPOSITORY`, where `USER` is your GitHub username and `REPOSITORY` is your repository name. You can always check the current URL in repository Settings -> Pages.

To edit your site content, place your markdown files into `content/` and remove unnecessary starter files.

>**Important:** keep frontmatter structure in your markdown files consistent with your rules, so Notepub can build your site correctly.

![](/media/content.webp)
CI does:

- downloads pinned `notepub` binary
- runs index + validate + build
- deploys `dist/` to Pages

## What users usually do next

After first deploy, you usually need to:

- Update site metadata (`title`, `description`, `base_url`, etc.): [[configuration|Configuration Reference]]
- Customize templates and visual style: [[themes|Themes and Templates]]
- Run project locally before push: [[local-run|Local Run]]
- Delegate setup to an agent when needed: [[ai-agent-brief|AI/MCP Agent Brief]]

If you use template repos, also see [[template-repos|Template Repositories]].

## Minimal frontmatter

Before writing lots of content, read [[recipe-structure|Content Structure in Template Repositories]]. It shows the page types of the documentation, services and blog templates. Once you understand the structure, you can model your own markdown worlds and build static websites of any complexity and nesting.

For a typical template:

```yaml
---
type: article
slug: my-first-note # canonical page URL
title: Page title # page heading and <title>; seo_title overrides the latter
description: Note description # also SEO meta description
draft: false
---
```

## Advanced content source modes

- Content from a separate repository: [[content-repo|Content Repository Mode]]
- Content from S3-compatible storage: [[s3-content|S3 Content Mode]]
- Obsidian flow and required variables/secrets: [[obsidian-workflow|Obsidian Workflow]]

Next: [[configuration|Configuration Reference]] and [[rules-yaml|rules.yaml Reference]].
