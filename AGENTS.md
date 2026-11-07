# Portfolio Site Map

This repository is Shubham Gupta's Jekyll portfolio published with GitHub Pages.

## Structure

- `index.html` renders the compact profile introduction, section browser, and Work and Studies from `_data/timeline.yml`. Library content does not render as a homepage feed.
- `experience.html` renders employer responsibilities, public productions, recognition, and optional responsive galleries from `_data/experience.yml`.
- `education.html` renders degrees and academic work from `_data/education.yml`.
- `things-i-like.html` is the permanent Library. Articles, Videos, Books, and Films are always available categories; entries render from `_data/interests.yml`.
- The Résumé navigation link opens the latest PDF directly; `/resume/` redirects there for compatibility.
- `_posts/` contains detailed project case studies linked from Experience.

Each component under `_includes/sections/` has its own `AGENTS.md` with its rendering and content rules.

## Public-content boundaries

- Do not announce an upcoming employer until Shubham confirms the role has started.
- Use only public or user-approved claims, credits, links, photographs, and project details.
- Do not copy phone numbers, citizenship, addresses, or other sensitive résumé fields into site HTML.
- Do not invent dates, attribution, awards, metrics, personal opinions, or client outcomes.

## Local workflow

```text
bundle exec jekyll build
bundle exec jekyll doctor
bundle exec jekyll serve --host 127.0.0.1 --port 4000
```

Review locally before committing or pushing. Keep archived résumé files private from navigation unless Shubham explicitly asks to expose them again. Preserve `/src/cv.pdf` as a compatibility URL.
