# Bolt's Journal ⚡

## 2024-05-22 - Image Loading Optimization
**Learning:** `CachedNetworkImage` with both `memCacheWidth` and `memCacheHeight` set forces an aspect ratio, which distorts images if they don't match. For book covers, only width should be constrained.
**Action:** When optimizing images, ensure only one dimension is constrained for caching to preserve aspect ratio. Also, usage of `CircularProgressIndicator` in lists causes significant main-thread overhead; prefer static placeholders.
