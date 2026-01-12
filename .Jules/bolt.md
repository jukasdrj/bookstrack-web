# Bolt's Journal

## 2024-05-22 - [Optimized Image Caching]
**Learning:** When using CachedNetworkImage with variable aspect ratios (like book covers), specifying both memCacheHeight and memCacheWidth forces a specific aspect ratio, distorting the image.
**Action:** Only specify memCacheWidth (or whichever dimension is fixed in the layout) to allow the other dimension to scale naturally while still saving memory.

## 2024-05-22 - [Avoid CircularProgressIndicator in Lists]
**Learning:** Using CircularProgressIndicator as a placeholder in long lists or grids causes significant jank because it triggers constant repaints on the main thread.
**Action:** Use a static Container with a theme color as a placeholder for list/grid items.
