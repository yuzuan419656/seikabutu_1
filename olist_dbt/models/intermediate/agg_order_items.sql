SELECT
  order_id,
  COUNT(*) AS item_count,
  SUM(price) AS total_price,
  SUM(freight_value) AS total_freight

FROM {{ref('stg_items')}}

GROUP BY order_id