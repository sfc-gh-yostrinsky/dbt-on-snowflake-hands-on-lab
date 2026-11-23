-- Task 5: ship to prod. Same project object, target prod.
-- Deploy first (from the guide repo root):
--   snow dbt deploy TASTY_BYTES_DBT --source tasty_bytes_dbt_demo --database TASTY_BYTES_DBT_DB --schema INTEGRATIONS --external-access-integration DBT_ACCESS_INTEGRATION --dbt-version '2.0.0'

EXECUTE DBT PROJECT TASTY_BYTES_DBT_DB.INTEGRATIONS.TASTY_BYTES_DBT ARGS='build --target prod';

-- Keep this ID for Task 6.
SELECT LAST_QUERY_ID();

SHOW TABLES IN SCHEMA TASTY_BYTES_DBT_DB.PROD;

-- Measured 2026-11-23: "Finished 'build' successfully for target 'prod'" in 3m42s on SMALL.
-- Discussion notes:
--   dbt_projects_profiles.yml has dev and prod targets that differ only in schema.
--   generate_schema_name returns a custom schema name as-is, so the snapshot (schema: snapshots) is shared by both targets.
--   In a team, CI runs the prod build on merge, not a person.
