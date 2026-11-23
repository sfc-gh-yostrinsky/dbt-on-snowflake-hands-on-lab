# Task 0: make the repo run on dbt v2

Goal: as shipped, the project fails with 5 errors on dbt 2.0.0. The deploy's own compile step rejects it, so the project object is never created. dbt v2 treats deprecated YAML as an error. Fix it.

What to do:
- In `models/staging/__sources.yml`, move `to` and `field` of every `relationships` test under `arguments:`. There are 4 places.
- Move `loaded_at_field` on ORDER_HEADER under `config:`.
- Deploy the project as the object TASTY_BYTES_DBT_DB.INTEGRATIONS.TASTY_BYTES_DBT. If you skipped README step 3, create the schema first (CREATE SCHEMA IF NOT EXISTS TASTY_BYTES_DBT_DB.INTEGRATIONS). Run this from the root of the guide repo:

      snow dbt deploy TASTY_BYTES_DBT --source tasty_bytes_dbt_demo --database TASTY_BYTES_DBT_DB --schema INTEGRATIONS --external-access-integration DBT_ACCESS_INTEGRATION --dbt-version '2.0.0'

  Before you fix anything, this fails. That's expected. Rerun it after each fix.
- Then, in a SQL worksheet or the CoCo chat:

      EXECUTE DBT PROJECT TASTY_BYTES_DBT_DB.INTEGRATIONS.TASTY_BYTES_DBT ARGS='deps';
      EXECUTE DBT PROJECT TASTY_BYTES_DBT_DB.INTEGRATIONS.TASTY_BYTES_DBT ARGS='build --target dev';

  Every later task uses this same object. "Deploy" always means the command above.

Discussion: why dbt v2 (speed, static SQL analysis), and what it costs (stricter YAML).

Done when: the deploy succeeds and the build passes 61 of 61 (11 models, 50 tests).

Answer: [answers/task-0](../answers/task-0)
