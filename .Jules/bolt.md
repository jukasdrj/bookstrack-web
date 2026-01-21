## 2026-01-21 - Flutter Image Caching & Placeholders
**Learning:** Specifying both `memCacheWidth` and `memCacheHeight` in `CachedNetworkImage` can distort images if the aspect ratio doesn't match the source, and using animated widgets like `CircularProgressIndicator` in list item placeholders causes main thread jank during scrolling.
**Action:** Only specify `memCacheWidth` to preserve aspect ratio while reducing memory usage, and use static `Container`s (solid color) for placeholders in scrollable lists.
