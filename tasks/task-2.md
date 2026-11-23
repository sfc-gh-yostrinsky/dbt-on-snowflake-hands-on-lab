# Task 2: star schema

Goal: the repo's `orders` mart is one wide join. Remodel it as facts and dimensions.

What to build:
- In `packages.yml`, uncomment dbt_utils and bump it to 1.4.1. Deploy, and run `deps`.
- `dim_truck` (truck plus franchise), `dim_menu_item` and `dim_customer`, each with a surrogate key from `dbt_utils.generate_surrogate_key`.
- `fct_order_lines` with one row per `order_detail_id`, foreign keys to the dimensions, plus quantity, unit_price, price and order_ts.
- In `models/marts/_marts.yml`: `unique` and `not_null` on the grain, and `relationships` tests from the fact to each dimension (under `arguments:`).

Run: `build --target dev --select +path:models/marts`

Select the whole marts folder, not just `+fct_order_lines`. The fact table doesn't `ref()` the dimensions, so that selector skips them, and the relationships tests then fail against tables that don't exist.

Discussion: what is the grain? Why surrogate keys? What happens to an order that has no loyalty customer?

Hint: an inner join to `dim_customer` silently drops those orders. Add an "unknown" member instead.

Answer: [answers/task-2](../answers/task-2)

Expect from `deps`: "Installed 1 package", along with "Failed dbt-labs/dbt_utils: latest" and "Finished 'deps' with 1 error". The install worked. The error comes from dbt's follow-up check for a newer version on hub.getdbt.com, and you can ignore it. The build afterwards uses the package.

Done when: the build passes (measured: 67 of 67).

Troubleshooting: if `deps` reports "Installed 0 packages", or the build can't find `dbt_utils`, install the package locally and deploy it with the project. The second command is one line:

    git clone --depth 1 --branch 1.4.1 https://github.com/dbt-labs/dbt-utils.git tasty_bytes_dbt_demo/dbt_packages/dbt_utils
    rm -rf tasty_bytes_dbt_demo/dbt_packages/dbt_utils/.git tasty_bytes_dbt_demo/dbt_packages/dbt_utils/integration_tests
