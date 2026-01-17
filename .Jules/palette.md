## 2024-05-21 - Library FilterChip Refactor & Accessibility Note
**Learning:** Found inconsistent `FilterChip` usage where Icon was embedded in Label, causing double-icon visual clutter when selected. Standardizing on `avatar` property improves visual polish and consistency. Also noted `BookGridCard` relies solely on color for status, which is an accessibility barrier.
**Action:** Always check `FilterChip` implementation for `avatar` vs `label` usage. Future task: Add tooltips or icons to `BookGridCard` status dots.

## 2024-05-23 - BookGridCard Status Accessibility Fix
**Learning:** Implemented accessibility fix for `BookGridCard` status dots. Confirmed that relying on color alone is insufficient. Used `Tooltip` for mouse users and `Semantics(label: ...)` for screen readers. Also found that `status` field is nullable, requiring strict null checks to prevent runtime errors.
**Action:** Ensure all status indicators have text alternatives (Tooltip/Semantics) and handle potential null states gracefully.
