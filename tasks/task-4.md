# Task 4: make the fact incremental

Goal: `fct_order_lines` has about 674M rows. Rebuilding it on every run is wasteful.

What to build:
- `materialized='incremental'`, `incremental_strategy='merge'`, `unique_key='order_detail_id'`.
- `on_schema_change='append_new_columns'`, so a new column doesn't fail the run.
- An `is_incremental()` filter that keeps only order_ts newer than the latest one already loaded.
- Run it twice and compare the timings. Then explain when you need `--full-refresh`.
- Bonus: try `delete+insert` or `append`, and explain the trade-off.

Deploy, then run: `build --target dev --select fct_order_lines` (twice)

Discussion: event-time vs load-time watermark. What happens to orders that arrive late?

Done when: the second run takes seconds, not minutes (measured: 3m38s, then 10.5s).

Answer: [answers/task-4](../answers/task-4)
