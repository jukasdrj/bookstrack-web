# Bolt's Journal - Critical Learnings

## 2024-05-22 - [Flutter Image Caching]
**Learning:** `CachedNetworkImage` with variable aspect ratios (like book covers) should only specify `memCacheWidth` (not height) to avoid distortion while still reducing memory usage.
**Action:** When optimizing book cover images, set `memCacheWidth` based on expected display width, but leave `memCacheHeight` null.

## 2024-05-22 - [List Performance]
**Learning:** Using `CircularProgressIndicator` as a placeholder in scrolling lists (like `CachedNetworkImage` placeholders) causes significant main thread jank due to continuous animation frames.
**Action:** Replace animated placeholders with static `Container`s using theme colors for list/grid items.
