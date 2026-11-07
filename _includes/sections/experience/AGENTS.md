# Experience

Purpose: present each employer as an editorial account of responsibilities, selected public work, and appropriately attributed recognition.

## Data contract

Source all content from `_data/experience.yml`. Preserve reverse chronology and stable employer IDs because Home links directly to these anchors.

- `responsibilities`: concise `title` and `summary` rows describing day-to-day work.
- `projects`: `title`, optional public `url`, `summary`, optional `case_study_url`, optional public `credit`, and optional `resources`.
- `resources`: `label`, `url`, `type`, and optional `internal: true`. YouTube watch, short, and youtu.be links automatically receive thumbnails.
- `recognition`: `title`, `year`, `level: team|production|company`, exact `description`, `source_url`, optional `related_project`, and optional `featured: true`.
- `gallery`: responsive `src`, `srcset`, `sizes`, intrinsic dimensions, `alt`, `caption`, and `role: primary|secondary`.

Featured projects receive the full editorial treatment. Projects without `featured: true` appear in the restrained additional-productions list. The same renderer must work for every employer; omit empty collections rather than adding placeholder sections.

## Public-content boundaries

- Use only user-approved facts or verifiable public sources. Never infer confidential productions, clients, metrics, techniques, or individual contribution details.
- Keep awards and nominations at their documented level. Do not convert production, team, or company recognition into an individual award.
- Public crew credits may be stated exactly and linked to their source.
- Videos may be offered as resources, but do not infer Shubham's contribution to their production or marketing.
- Photographs supplied by Shubham may be optimized into responsive derivatives; keep originals outside the repository.
