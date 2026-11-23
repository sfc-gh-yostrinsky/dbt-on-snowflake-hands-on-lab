select
    {{ dbt_utils.generate_surrogate_key(['t.truck_id']) }} as truck_sk,
    t.truck_id, t.primary_city, t.region, t.country, t.make, t.model, t.ev_flag, t.franchise_flag,
    f.first_name as franchisee_first_name, f.last_name as franchisee_last_name,
    f.first_name || ' ' || f.last_name as franchisee_name
from {{ ref('raw_pos_truck') }} t
left join {{ ref('raw_pos_franchise') }} f on t.franchise_id = f.franchise_id
