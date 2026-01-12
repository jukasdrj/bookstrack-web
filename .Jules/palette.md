## 2024-05-21 - Library FilterChip Refactor & Accessibility Note
**Learning:** Found inconsistent `FilterChip` usage where Icon was embedded in Label, causing double-icon visual clutter when selected. Standardizing on `avatar` property improves visual polish and consistency. Also noted `BookGridCard` relies solely on color for status, which is an accessibility barrier.
**Action:** Always check `FilterChip` implementation for `avatar` vs `label` usage. Future task: Add tooltips or icons to `BookGridCard` status dots.

## 2026-01-21 - BookGridCard Null Safety & Accessibility
**Learning:** `WorkWithLibraryStatus` properties like `status` and `libraryEntry` are nullable, but UI code assumed non-null, risking crashes. Also, status dots were inaccessible.
**Action:** Always handle nulls in `WorkWithLibraryStatus` explicitly. Wrap status indicators in `Tooltip` + `Semantics` with text labels.
