select
    od.order_detail_id,
    od.order_id,
    {{ dbt_utils.generate_surrogate_key(['oh.truck_id']) }}      as truck_sk,
    {{ dbt_utils.generate_surrogate_key(['od.menu_item_id']) }}  as menu_item_sk,
    coalesce(c.customer_sk, '-1')                                as customer_sk,
    oh.location_id,
    oh.order_ts,
    od.quantity,
    od.unit_price,
    od.price
from {{ ref('raw_pos_order_detail') }} od
join {{ ref('raw_pos_order_header') }} oh on od.order_id = oh.order_id
left join {{ ref('dim_customer') }} c on c.customer_id = oh.customer_id
