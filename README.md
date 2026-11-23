# dbt Projects on Snowflake: hands-on lab

Solo tasks that build on the [Getting Started with dbt on Snowflake](https://github.com/Snowflake-Labs/getting-started-with-dbt-on-snowflake) quickstart (the `tasty_bytes_dbt_demo` project). You work locally in Cortex Code (CoCo) Desktop and run everything on Snowflake as a dbt project object.

| Task | Topic | Time |
| --- | --- | --- |
| [0](tasks/task-0.md) | Make the repo run on dbt v2 | 10 min |
| [1](tasks/task-1.md) | Staging done properly: rename, cast, deduplicate | 15 min |
| [2](tasks/task-2.md) | Star schema | 25 min |
| [3](tasks/task-3.md) | Slowly changing dimension (Type 2) with a snapshot | 15 min |
| [4](tasks/task-4.md) | Make the fact incremental | 15 min |
| [5](tasks/task-5.md) | Ship to prod | 10 min |
| [6](tasks/task-6.md) | Defer to prod (Slim CI) | 15 min |

Answers are in [answers/](answers/), one folder per task, holding only the files that task changes. Try the task first.

## Prerequisites

- A Snowflake account where the quickstart setup has already run: database `TASTY_BYTES_DBT_DB` (schemas RAW, DEV, PROD, INTEGRATIONS), warehouse `TASTY_BYTES_DBT_WH`, and the external access integration `DBT_EXT_ACCESS` (needed by `dbt deps`).
- CoCo Desktop with a working connection to that account.
- The Snowflake CLI (`snow`) on your path.

## Setup

1. Clone both repos side by side:

       git clone https://github.com/Snowflake-Labs/getting-started-with-dbt-on-snowflake.git
       git clone https://github.com/sfc-gh-yostrinsky/dbt-on-snowflake-hands-on-lab.git

2. Open `getting-started-with-dbt-on-snowflake` in CoCo Desktop. That is where you edit. This repo is your task sheet.
3. Deploy the project as an object. Run this from the root of the guide repo, and run it again after every change:

       snow dbt deploy TASTY_BYTES_DBT --source tasty_bytes_dbt_demo --database TASTY_BYTES_DBT_DB --schema INTEGRATIONS --external-access-integration DBT_EXT_ACCESS --dbt-version '2.0.0'

   The first deploy fails. That is Task 0.
4. Run dbt commands in a SQL worksheet or the CoCo chat:

       EXECUTE DBT PROJECT TASTY_BYTES_DBT_DB.INTEGRATIONS.TASTY_BYTES_DBT ARGS='build --target dev';

Cost: the order tables are large (about 248M headers and 674M lines). Use `--select` to build only what you changed. A full build takes about 4 minutes on a SMALL warehouse.

Deploy uploads your local folder. Snowflake runs what you deployed last, not what is in your editor.
