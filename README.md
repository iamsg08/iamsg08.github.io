# Shubham Gupta — Portfolio

This is a Jekyll portfolio hosted with GitHub Pages. Most of the site can be updated by editing a small YAML file rather than changing HTML.

## Start the site locally

Open Terminal in this repository and run:

```bash
bundle install
bundle exec jekyll serve --host 127.0.0.1 --port 4000
```

Then open [http://127.0.0.1:4000](http://127.0.0.1:4000).

Before publishing any change, run:

```bash
bundle exec jekyll build
bundle exec jekyll doctor
git status
git diff
```

Use a feature branch rather than committing directly to `main`:

```bash
git switch -c update/short-description
```

## Where content lives

| What you want to change | File |
| --- | --- |
| Homepage Work and Studies summaries | `_data/timeline.yml` |
| Employer responsibilities, productions, links, recognition, and gallery | `_data/experience.yml` |
| Degrees, teaching, research, and awards | `_data/education.yml` |
| Library articles, books, videos, films, and current interests | `_data/interests.yml` |
| Profile introduction and external links | `_includes/sections/home/profile.html` |
| Current résumé PDF | `assets/resumes/current/` and `resume-url` in `_config.yml` |
| Detailed project case studies | `_posts/` |

Keep dates and entries newest first unless a section documents a different sorting rule.

## Add something to the Library

The easiest method is the included helper. It fetches the title, source, publication year, and preview image when the linked page supplies them. Article images are downloaded into the repository so the site does not depend on a remote preview service.

### Recommended article

```bash
bundle exec ruby scripts/add_interest.rb \
  "https://example.com/article" \
  --type article \
  --note "Why I recommend this article."
```

### Book

Use a publisher, author, Open Library, Goodreads, or another stable public book page:

```bash
bundle exec ruby scripts/add_interest.rb \
  "https://example.com/book" \
  --type book \
  --note "What I found useful or memorable about this book."
```

### YouTube video

```bash
bundle exec ruby scripts/add_interest.rb \
  "https://www.youtube.com/watch?v=VIDEO_ID" \
  --type video \
  --note "Why I think this is worth watching."
```

YouTube titles, channel names, thumbnails, and privacy-enhanced embeds are handled automatically.

### Something you are reading or watching now

Add `--status now`:

```bash
bundle exec ruby scripts/add_interest.rb \
  "https://example.com/item" \
  --type article \
  --status now \
  --note "What I am currently exploring."
```

Without `--status now`, the helper creates a recommendation.

### Preview an entry without changing files

Add `--dry-run` to any helper command:

```bash
bundle exec ruby scripts/add_interest.rb \
  "https://example.com/article" \
  --type article \
  --dry-run
```

### Add or edit an entry manually

Edit `_data/interests.yml` and follow this structure:

```yaml
- id: a-short-unique-name
  status: recommended # recommended or now
  type: article # article, book, video, film, or other
  title: The title shown on the site
  creator: Author, publication, channel, or director
  url: https://example.com/item
  year: 2026 # optional
  date_added: 2026-11-07
  note: A short personal reason for sharing it.
  image: /assets/images/interests/example.jpg # optional
```

The Library automatically:

- groups entries into Articles, Books, Videos, Films, and Other;
- marks `now` items as currently in progress;
- keeps the complete collection at `/things-i-like/`;
- keeps Library entries off the homepage so Work and Studies remain focused.

Only add opinions that genuinely reflect what you think. Keep notes to one concise sentence.

## Add or update work

Edit `_data/experience.yml`. Each employer can contain:

- `responsibilities` for day-to-day work;
- `projects` for public productions or case studies;
- `resources` for official pages, interviews, videos, and recognition;
- `recognition` with an explicit `team`, `production`, or `company` level;
- `gallery` for responsive images and captions.

Use public or approved information only. Do not turn team, production, or company recognition into an individual award.

If the role should also appear on the homepage, update `_data/timeline.yml` and link its `href` to the matching employer anchor.

## Add images

Place website images under `assets/images/` in the most relevant subfolder. Use descriptive lowercase filenames with hyphens, for example:

```text
assets/images/interests/book-title.jpg
assets/images/experience/company/team-photo.jpg
```

Large photographs should be resized before committing. Keep private, full-resolution originals outside the repository.

## Update the résumé

1. Put the new PDF in `assets/resumes/current/`.
2. Give it a clear lowercase filename.
3. Update `resume-url` in `_config.yml`.
4. Copy the same PDF to `src/cv.pdf` so old links continue to work.
5. Build locally and test the Résumé link.

Do not expose phone numbers, citizenship, home addresses, or other private résumé fields in the site HTML.

## Publish through GitHub

After reviewing the local site:

```bash
git add -p
git commit -m "Update portfolio content"
git push -u origin HEAD
```

`git add -p` lets you review and approve each change before staging it. Open a pull request, review the generated diff, and merge it into `main` when ready. GitHub Pages will rebuild from `main`.

Always check `git status` and include only the changes you intend to publish.
