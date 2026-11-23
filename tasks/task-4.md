# Task 4: make the fact incremental

Goal: `fct_order_lines` has about 674M rows. Rebuilding it on every run is wasteful.

What to build:
- `materialized='incremental'`, `incremental_strategy='merge'`, `unique_key='order_detail_id'`.
- `on_schema_change='append_new_columns'`, so a new column doesn't fail the run.
- An `is_incremental()` filter that keeps only order_ts newer than the latest one already loaded.
- Run it once with `--full-refresh`, then again without it, and compare the timings. Then explain when you need `--full-refresh`.
- Bonus: try `delete+insert` or `append`, and explain the trade-off.

Deploy, then run:

    build --target dev --select fct_order_lines --full-refresh
    build --target dev --select fct_order_lines

Why `--full-refresh` first: the table already exists from Task 2, so without it the very first run is already incremental and there is nothing to compare.

Discussion: event-time vs load-time watermark. What happens to orders that arrive late?

Done when: the incremental run is clearly faster than the full refresh. On the event X-Large warehouse, measured 20s full refresh, then about 8s incremental. On SMALL: 3m38s, then 10.5s.

Answer: [answers/task-4](../answers/task-4)
