# Task 1: staging done properly (rename, cast, deduplicate)

Goal: replace `SELECT *` in `raw_pos_order_header` with explicit, typed columns, and make it safe against duplicate delivery.

What to build:
- Explicit columns with corrected types. LOCATION_ID arrives as FLOAT; ORDER_TAX_AMOUNT and ORDER_DISCOUNT_AMOUNT arrive as TEXT. Check with `DESCRIBE TABLE TASTY_BYTES_DBT_DB.RAW.ORDER_HEADER`.
- Deduplicate on ORDER_ID, keeping the latest row by ORDER_TS.
- `unique` and `not_null` tests on `order_id` (new file `models/staging/_staging.yml`).
- Bonus: insert duplicates into RAW and prove that the test still passes:

      insert into tasty_bytes_dbt_db.raw.order_header select * from tasty_bytes_dbt_db.raw.order_header limit 5;

  The copies are identical to the originals, so a DELETE would remove both. Undo with Time Travel instead, using the query ID of the insert:

      create or replace table tasty_bytes_dbt_db.raw.order_header
        clone tasty_bytes_dbt_db.raw.order_header before (statement => '<insert query id>');

Deploy, then run: `build --target dev --select raw_pos_order_header`

Discussion: why deduplicate in staging and not in the mart? Why must the tiebreak be deterministic?

Done when: RAW has duplicate order_ids, the staging view has none, and both tests pass.

Answer: [answers/task-1](../answers/task-1)
