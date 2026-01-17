# Bolt's Journal

## 2024-05-22 - [CachedNetworkImage Aspect Ratio]
**Learning:** Setting both `memCacheWidth` and `memCacheHeight` forces the image to that exact size, potentially distorting aspect ratio if the source image differs.
**Action:** Only set `memCacheWidth` (or height) to scale down images for memory savings while preserving aspect ratio.
