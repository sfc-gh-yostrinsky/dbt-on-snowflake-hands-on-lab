# Task 6: defer to prod (Slim CI)

Goal: change one model and build only what changed in DEV. Everything upstream is read from PROD instead of being rebuilt.

How it works:
- `state:modified+` compares your project with the manifest of the prod run.
- `--defer` resolves every unbuilt `ref()` to the prod relation.
- `SYSTEM$LOCATE_DBT_ARTIFACTS('<query id>')` mounts that run's artifacts at `./imports/state/target`.

What to do:
1. Change a mart model. For example, add `franchisee_name` (first and last name) to `dim_truck`.
2. Deploy.
3. Run a deferred build, using your Task 5 query ID:

       EXECUTE DBT PROJECT TASTY_BYTES_DBT_DB.INTEGRATIONS.TASTY_BYTES_DBT
         ARGS='build --target dev --state ./imports/state/target --defer --select state:modified+'
         IMPORTS = (SYSTEM$LOCATE_DBT_ARTIFACTS('<your Task 5 query id>') AS 'state');

4. Check that the new column exists in DEV and not yet in PROD:

       select table_schema, count_if(column_name = 'FRANCHISEE_NAME') as has_new_col
       from tasty_bytes_dbt_db.information_schema.columns where table_name = 'DIM_TRUCK' group by 1;

Discussion:
- How many nodes ran, compared with a full build?
- What would CI do with this on every pull request?
- What breaks if prod is stale, or if the prod run is older than 14 days (artifact retention)?

Done when: only `dim_truck` and its downstream test run (measured: 2 nodes in about 5 seconds).

Gotcha: the prod run must come from the code you deployed for Task 5. If prod was built from older code, `state:modified` compares against that older version.

Answer: [answers/task-6](../answers/task-6)
