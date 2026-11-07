# Library

Purpose: collect articles, videos, books, films, and other links Shubham is currently exploring or genuinely recommends.

- Source entries from `_data/interests.yml`. The Library and its Articles, Videos, Books, and Films categories always exist. Library content never renders as a homepage feed.
- Required fields: `id`, `status`, `type`, `title`, `creator`, and `date_added`. A short first-person `note` is strongly recommended but optional.
- Valid statuses are `now` and `recommended`; valid types are `article`, `book`, `video`, `film`, and `other`.
- Optional fields are `url`, `year`, and a local `image` path. Links must be verified and omitted images must leave no placeholder.
- YouTube links render as privacy-enhanced embeds in the Library.
- Use `scripts/add_interest.rb` to fetch article or YouTube metadata and create an entry from a URL. General article thumbnails are downloaded locally so production does not depend on a runtime preview service.
- `status: now` adds an in-progress label to an item; it does not create a separate visitor-facing section. The Library groups every entry by type and sorts by `date_added` newest first.
- This section should feel personal, not like a content-marketing feed. Avoid ratings, filler, scraped summaries, and invented opinions.
