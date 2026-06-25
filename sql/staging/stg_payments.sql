CREATE OR REPLACE TABLE stg_olist.stg_payments AS
SELECT 
  order_id,
  payment_sequential,
  payment_type,
  payment_installments,
  payment_value,
FROM raw_olist.order_payments;