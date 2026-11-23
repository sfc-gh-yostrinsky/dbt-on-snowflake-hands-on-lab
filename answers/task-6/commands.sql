-- Task 6: defer to prod. Change dim_truck.sql (see tasty_bytes_dbt_demo/), deploy, then:

EXECUTE DBT PROJECT TASTY_BYTES_DBT_DB.INTEGRATIONS.TASTY_BYTES_DBT
  ARGS='build --target dev --state ./imports/state/target --defer --select state:modified+'
  IMPORTS = (SYSTEM$LOCATE_DBT_ARTIFACTS('<your Task 5 query id>') AS 'state');

select table_schema, count_if(column_name = 'FRANCHISEE_NAME') as has_new_col
from tasty_bytes_dbt_db.information_schema.columns where table_name = 'DIM_TRUCK' group by 1;

-- Measured 2026-11-23: 2 nodes (dim_truck plus its relationships test) in 7.0s. DEV has_new_col = 1, PROD = 0.
-- Alternative: IMPORTS = (SYSTEM$DBT_GET_LAST_SUCCESSFUL_RUN_TARGET('TASTY_BYTES_DBT_DB.INTEGRATIONS.TASTY_BYTES_DBT') AS 'state')
--   mounts at ./imports/state (no /target). It returns the latest successful run of ANY target,
--   so after a dev run it no longer points at prod. That is why we pin the prod query ID.
