{{-
    config(
        materialized = "table",
        tags = ["analyse"]
    )
-}}

select sum(purchases) as total_purchase, shop_name
from {{ ref("customers") }} as c
join {{ ref("shops") }} as s
on c.shop_id = s.id
group by shop_name
order by shop_name
