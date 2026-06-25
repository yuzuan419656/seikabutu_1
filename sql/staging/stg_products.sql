CREATE OR REPLACE TABLE stg_olist.stg_products AS
SELECT 
  product_id,
  product_category_name,

  product_weight_g,
  product_length_cm,
  product_height_cm,
  product_width_cm
FROM raw_olist.products;