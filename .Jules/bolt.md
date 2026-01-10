## 2024-05-23 - Search Debouncing Optimization
**Learning:** Functional providers like `searchWithQuery` can effectively manage side-effects (like debouncing) using `ref.listen` and `Future.delayed`, but care must be taken to check for state consistency (e.g., query equality) inside the delayed callback to prevent race conditions or double-fetches.
**Action:** When implementing "search-as-you-type", always verify if the target search is already in progress or completed before triggering a new API call.
