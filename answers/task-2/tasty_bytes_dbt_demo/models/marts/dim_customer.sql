select
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_sk,
    customer_id, first_name, last_name, city, country, gender, marital_status, children_count, sign_up_date
from {{ ref('raw_customer_customer_loyalty') }}
union all
select '-1', -1, 'Unknown', 'Unknown', null, null, null, null, null, null   -- unknown member for non-loyalty orders
