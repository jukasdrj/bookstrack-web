## 2024-05-21 - Library FilterChip Refactor & Accessibility Note
**Learning:** Found inconsistent `FilterChip` usage where Icon was embedded in Label, causing double-icon visual clutter when selected. Standardizing on `avatar` property improves visual polish and consistency. Also noted `BookGridCard` relies solely on color for status, which is an accessibility barrier.
**Action:** Always check `FilterChip` implementation for `avatar` vs `label` usage. Future task: Add tooltips or icons to `BookGridCard` status dots.

## 2025-05-22 - Status Dot Accessibility
**Learning:** Status dots that rely solely on color are inaccessible to screen readers and confusing for users who can't distinguish the colors. Wrapping them in `Tooltip` + `Semantics` solves both issues without changing the visual design.
**Action:** When using color-coded status indicators, always wrap them in a Tooltip and Semantics widget with a descriptive label.
