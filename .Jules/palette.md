## 2024-05-21 - Library FilterChip Refactor & Accessibility Note
**Learning:** Found inconsistent `FilterChip` usage where Icon was embedded in Label, causing double-icon visual clutter when selected. Standardizing on `avatar` property improves visual polish and consistency. Also noted `BookGridCard` relies solely on color for status, which is an accessibility barrier.
**Action:** Always check `FilterChip` implementation for `avatar` vs `label` usage. Future task: Add tooltips or icons to `BookGridCard` status dots.

## 2024-05-22 - Status Indicators Accessibility
**Learning:** Colored status dots (like in `BookGridCard`) are inaccessible to screen readers and colorblind users. `Tooltip` is great for mouse/hover, but explicitly wrapping in `Semantics(label: ...)` ensures screen readers get a clear "Status: [Value]" announcement.
**Action:** When implementing status indicators, always pair `Color` with `Tooltip` and `Semantics`.
