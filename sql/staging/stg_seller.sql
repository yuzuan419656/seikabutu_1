CREATE OR REPLACE TABLE stg_olist.stg_sellers AS
SELECT 
  seller_id,
  seller_city,
  seller_state
FROM raw_olist.sellers;