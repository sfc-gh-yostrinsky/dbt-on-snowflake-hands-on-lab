# Task 2: star schema

Goal: the repo's `orders` mart is one wide join. Remodel it as facts and dimensions.

What to build:
- In `packages.yml`, uncomment dbt_utils and bump it to 1.4.1. Deploy, and run `deps`.
- `dim_truck` (truck plus franchise), `dim_menu_item` and `dim_customer`, each with a surrogate key from `dbt_utils.generate_surrogate_key`.
- `fct_order_lines` with one row per `order_detail_id`, foreign keys to the dimensions, plus quantity, unit_price, price and order_ts.
- In `models/marts/_marts.yml`: `unique` and `not_null` on the grain, and `relationships` tests from the fact to each dimension (under `arguments:`).

Run: `build --target dev --select +fct_order_lines`

Discussion: what is the grain? Why surrogate keys? What happens to an order that has no loyalty customer?

Hint: an inner join to `dim_customer` silently drops those orders. Add an "unknown" member instead.

Answer: [answers/task-2](../answers/task-2)

Troubleshooting: if `deps` fails with "Failed to get index from https://hub.getdbt.com", install the package locally and deploy it with the project. The second command is one line:

    git clone --depth 1 --branch 1.4.1 https://github.com/dbt-labs/dbt-utils.git tasty_bytes_dbt_demo/dbt_packages/dbt_utils
    rm -rf tasty_bytes_dbt_demo/dbt_packages/dbt_utils/.git tasty_bytes_dbt_demo/dbt_packages/dbt_utils/integration_tests
