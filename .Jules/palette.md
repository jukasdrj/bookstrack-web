## 2024-05-21 - Library FilterChip Refactor & Accessibility Note
**Learning:** Found inconsistent `FilterChip` usage where Icon was embedded in Label, causing double-icon visual clutter when selected. Standardizing on `avatar` property improves visual polish and consistency. Also noted `BookGridCard` relies solely on color for status, which is an accessibility barrier.
**Action:** Always check `FilterChip` implementation for `avatar` vs `label` usage. Future task: Add tooltips or icons to `BookGridCard` status dots.

## 2026-01-20 - Status Dot Accessibility
**Learning:** Status dots relying solely on color are inaccessible to screen reader users and those with color blindness. Tooltips and Semantics widgets are essential fixes.
**Action:** Always wrap color-coded indicators in Tooltip and Semantics widgets with descriptive labels.
