## 2024-05-21 - Library FilterChip Refactor & Accessibility Note
**Learning:** Found inconsistent `FilterChip` usage where Icon was embedded in Label, causing double-icon visual clutter when selected. Standardizing on `avatar` property improves visual polish and consistency. Also noted `BookGridCard` relies solely on color for status, which is an accessibility barrier.
**Action:** Always check `FilterChip` implementation for `avatar` vs `label` usage. Future task: Add tooltips or icons to `BookGridCard` status dots.

## 2025-01-28 - BookGridCard Accessibility Improvement
**Learning:** Adding `Tooltip` and `Semantics` to color-coded status indicators makes them accessible to screen readers and colorblind users without changing the visual design. This is a low-effort, high-impact a11y win.
**Action:** Look for other color-only indicators (e.g., connection status, sync status) and apply the same `Tooltip` + `Semantics` pattern.
