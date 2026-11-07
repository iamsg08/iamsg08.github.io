# Résumé

Purpose: expose only the latest résumé through a direct navigation link.

- The primary Résumé tab opens `site.resume-url` directly in a new tab.
- Store the public current file under `assets/resumes/current/`.
- Archived files may remain under `assets/resumes/legacy/`, but do not list them publicly unless requested.
- Never overwrite or delete an archived résumé. Keep `/src/cv.pdf` unchanged as a compatibility URL.
- `/resume/` is only a compatibility redirect to the current file; do not build a version-selection page.
- Never repeat phone number, citizenship, or other sensitive PDF details in HTML.
- Confirm the current PDF checksum after any file replacement.
