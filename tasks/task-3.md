# Task 3: slowly changing dimension (Type 2) with a snapshot

Goal: loyalty customers are overwritten in place. Keep their history.

What to build:
- `snapshots/snap_customer_loyalty.yml` with these settings:
  - `unique_key: customer_id`
  - strategy `check` (there is no `updated_at` column)
  - `check_cols`: city, country, marital_status, children_count
  - `hard_deletes: new_record`
  - `dbt_valid_to_current` set to a far-future date
- Deploy, run `snapshot --target dev`, change some customers, run it again, then query the history:

      update tasty_bytes_dbt_db.raw.customer_loyalty set city = 'London', country = 'United Kingdom'
      where customer_id in (select customer_id from tasty_bytes_dbt_db.raw.customer_loyalty order by customer_id limit 10);

Discussion: timestamp vs check strategy. What does a snapshot miss if a customer changes twice between runs?

Done when: the 10 changed customers each have 2 versions, one of them open until 9999-12-31.

The UPDATE is meant to stay: Tasks 5 and 6 run on the changed data. To undo it later, clone the table `before (statement => '<update query id>')`, as in Task 1.

Note: the snapshot lands in schema SNAPSHOTS for every target, because of the repo's `generate_schema_name` macro.

Answer: [answers/task-3](../answers/task-3)
