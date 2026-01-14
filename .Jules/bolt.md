## 2024-05-23 - [Scroll Performance Optimization]
**Learning:** Removing `CircularProgressIndicator` from `CachedNetworkImage` placeholders in lists/grids significantly reduces main thread load during scrolling. Documenting this optimization in code is crucial to prevent future regressions where developers might re-add "loading spinners" thinking they are a UX improvement.
**Action:** Always replace animated placeholders with static colors in reusable list items and add a comment explaining why.
