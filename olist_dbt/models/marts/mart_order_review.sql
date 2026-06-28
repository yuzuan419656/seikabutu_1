select
  o.order_id,
  r.review_score,
  o.order_status,
  o.order_delivered_customer_date,
  o.order_estimated_delivery_date,
  o.order_purchase_timestamp,
  cust.customer_state,
  i.item_count,
  i.total_price,
  i.total_freight,
  p.payment_type,
  p.total_payment,
  c.main_category,
  timestamp_diff(
    o.order_delivered_customer_date,
    o.order_purchase_timestamp,
    day
  ) as delivery_days,
  greatest(
    timestamp_diff(
      o.order_delivered_customer_date,
      o.order_estimated_delivery_date,
      day
    ),
    0
  ) as delay_days

from {{ ref('stg_orders') }} as o 
left join {{ ref('stg_customers') }} as cust 
  on o.customer_id = cust.customer_id
left join {{ ref('agg_reviews') }} as r 
  on o.order_id = r.order_id
left join {{ ref('agg_order_items') }} as i 
  on o.order_id = i.order_id
left join {{ ref('agg_order_payments') }} as p 
  on o.order_id = p.order_id
left join {{ ref('agg_main_category') }} as c 
  on o.order_id = c.order_id


