SELECT
  column_name,
  data_type
FROM raw_olist.INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'orders';

CREATE OR REPLACE table stg_olist.stg_orders AS

SELECT 
  order_id,
  customer_id,
  order_status,
  order_purchase_timestamp,
  order_delivered_customer_date,
  order_estimated_delivery_date

FROM raw_olist.orders;
