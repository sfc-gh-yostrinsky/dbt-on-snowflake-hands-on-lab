select
    order_id,
    truck_id,
    location_id::number(38,0)                         as location_id,
    customer_id,
    discount_id,
    order_channel,
    order_ts,
    order_currency,
    order_amount,
    try_to_number(order_tax_amount, 38, 4)            as order_tax_amount,
    try_to_number(order_discount_amount, 38, 4)       as order_discount_amount,
    order_total
from {{ source('tb_101', 'ORDER_HEADER') }}
qualify row_number() over (partition by order_id order by order_ts desc) = 1
