select
    {{ dbt_utils.generate_surrogate_key(['menu_item_id']) }} as menu_item_sk,
    menu_item_id, menu_item_name, item_category, item_subcategory, menu_type, truck_brand_name,
    cost_of_goods_usd, sale_price_usd
from {{ ref('raw_pos_menu') }}
