CREATE OR REPLACE TABLE mart_olist.mart_order_review AS (
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
  TIMESTAMP_DIFF(
  o.order_delivered_customer_date,
  o.order_purchase_timestamp,
  DAY
) AS delivery_days,
  GREATEST(
  TIMESTAMP_DIFF(
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    DAY
  ),
  0
) AS delay_days

from `stg_olist.stg_orders`          as o 
left join stg_olist.stg_customers         cust on o.customer_id = cust.customer_id
left join `mart_olist.agg_reviews`        as r on o.order_id = r.order_id
left join `mart_olist.agg_order_items`    as i on o.order_id = i.order_id
left join `mart_olist.agg_order_payments` as p on o.order_id = p.order_id
left join `mart_olist.agg_main_category`  as c on o.order_id = c.order_id)



