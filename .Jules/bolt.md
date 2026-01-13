## 2024-05-22 - [Flutter List Performance]
**Learning:** Using `CircularProgressIndicator` in `CachedNetworkImage` placeholders within lists causes significant main thread jank due to multiple active animation tickers.
**Action:** Replace animated placeholders with static containers (skeletons) in all list/grid items.
