# Task 0: make the repo run on dbt v2

Goal: as shipped, the project fails with 5 errors on dbt 2.0.0. The deploy's own compile step rejects it, so the project object is never created. dbt v2 treats deprecated YAML as an error. Fix it.

What to do:
- In `models/staging/__sources.yml`, move `to` and `field` of every `relationships` test under `arguments:`. There are 4 places.
- Move `loaded_at_field` on ORDER_HEADER under `config:`.
- Deploy, then run `deps` and `build --target dev`.

Discussion: why dbt v2 (speed, static SQL analysis), and what it costs (stricter YAML).

Done when: the deploy succeeds and the build passes 61 of 61 (11 models, 50 tests).

Answer: [answers/task-0](../answers/task-0)
