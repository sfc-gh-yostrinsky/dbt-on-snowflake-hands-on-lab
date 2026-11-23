# Task 5: ship to prod

Goal: everything so far was built in DEV. Promote it to PROD with the same project object and a different target.

What to do:
1. Make sure Tasks 0 to 4 are saved, then deploy. Prod builds exactly what you deployed.
2. Build to prod, then capture the query ID of that run. You need it in Task 6:

       EXECUTE DBT PROJECT TASTY_BYTES_DBT_DB.INTEGRATIONS.TASTY_BYTES_DBT ARGS='build --target prod';
       SELECT LAST_QUERY_ID();

3. Compare the schemas: `SHOW TABLES IN SCHEMA TASTY_BYTES_DBT_DB.PROD;`

Discussion:
- Where do dev and prod differ? Look at `dbt_projects_profiles.yml` (the targets) and `macros/generate_schema_name.sql`.
- Why is the snapshot shared by both targets, and is that what you want?
- In a real team, who runs this command: you, or CI? See `.github/workflows` in the guide repo.

Done when: the build finishes successfully for target `prod` (measured: 73 of 73 in 46s on the event X-Large warehouse, 3m42s on SMALL) and you have its query ID.

Answer: [answers/task-5](../answers/task-5)
