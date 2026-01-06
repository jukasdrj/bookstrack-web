## 2024-05-23 - FilterChip Widget Tree Optimization
**Learning:** Embedding `Icon` widgets within the `label` of a `FilterChip` (using a `Row`) creates unnecessary widget depth and circumvents the native layout logic.
**Action:** Use the `avatar` property of `FilterChip` for icons. This flattens the widget tree and ensures adherence to Material Design behaviors (e.g., handling selection checkmarks correctly).
