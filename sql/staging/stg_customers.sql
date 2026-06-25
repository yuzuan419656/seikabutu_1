CREATE OR REPLACE TABLE stg_olist.stg_customers AS

SELECT 
  customer_id,
  customer_unique_id,
  customer_city,
  customer_state
FROM `raw_olist.customers`;