{{ config(materialized='view') }}

SELECT 
  seller_id,
  seller_city,
  seller_state
FROM {{source('raw_olist', 'sellers')}}