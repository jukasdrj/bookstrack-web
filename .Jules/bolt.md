## 2026-01-16 - List Performance with Animated Placeholders
**Learning:** Using `CircularProgressIndicator` in `CachedNetworkImage` placeholders causes significant main-thread contention in scrollable lists (like search results or grids) because every item tries to animate simultaneously.
**Action:** Use static colored containers (skeletons) for placeholders in lists/grids. Only use active spinners for single-item views or large hero images.

## 2026-01-16 - Aspect Ratio Distortion in Image Caching
**Learning:** Setting both `memCacheWidth` and `memCacheHeight` on `CachedNetworkImage` forces a specific aspect ratio, which distorts images that don't match it perfectly (even with `BoxFit.cover`, the memory cache resizes it first).
**Action:** Set only `memCacheWidth` (or Height) to allow the image library to preserve the aspect ratio while still optimizing memory usage.
