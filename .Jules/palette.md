## 2024-05-21 - Library FilterChip Refactor & Accessibility Note
**Learning:** Found inconsistent `FilterChip` usage where Icon was embedded in Label, causing double-icon visual clutter when selected. Standardizing on `avatar` property improves visual polish and consistency. Also noted `BookGridCard` relies solely on color for status, which is an accessibility barrier.
**Action:** Always check `FilterChip` implementation for `avatar` vs `label` usage. Future task: Add tooltips or icons to `BookGridCard` status dots.

## 2024-05-22 - BookGridCard Status Accessibility
**Learning:** `BookGridCard` used color-only indicators for book status (Wishlist, Reading, etc.). This is inaccessible to screen readers and confusing for users who don't memorize the color code.
**Action:** Wrapped status indicators in `Tooltip` and `Semantics` widgets to provide text labels. Handled nullable status gracefully by hiding the indicator if status is missing.
