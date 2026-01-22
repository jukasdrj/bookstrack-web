# Bolt's Journal

## 2024-05-22 - [Flutter Image Caching]
**Learning:** `CachedNetworkImage` in a scrollable list (like a GridView) can cause significant jank if `memCacheWidth` and `memCacheHeight` are not set. The decoded images can consume massive amounts of memory if they are large originals.
**Action:** Always set `memCacheWidth` (or height) to the approximate display size times pixel density. For book covers with variable aspect ratios, set only one dimension (usually width) to preserve aspect ratio without distortion.

## 2024-05-23 - [Riverpod TextField Performance]
**Learning:** Binding a `TextField`'s `onChanged` callback directly to a Riverpod provider that triggers a database query or expensive state update causes excessive re-computation on every keystroke.
**Action:** Implement local state management for the text input and use a `Debouncer` or `Timer` to update the global/provider state only after the user pauses typing.

## 2024-05-23 - [Drift Database Indexing]
**Learning:** Filtering or sorting by columns that are not indexed in Drift/SQLite results in full table scans. This is noticeable even with moderate dataset sizes (e.g., hundreds of books) on mobile devices.
**Action:** Explicitly verify `@TableIndex` annotations on columns used in `WHERE` and `ORDER BY` clauses.

## 2024-05-24 - [Main Thread Blocking by Shimmer]
**Learning:** Complex loading animations or `Shimmer` effects, if not carefully implemented or if overused in a list, can consume frame budget.
**Action:** Use simple static placeholders (like colored containers) in long scrolling lists for better performance, or ensure shimmer is lightweight.
