CREATE OR REPLACE TABLE stg_olist.stg_reviews AS

SELECT
  review_id,
  order_id,
  review_score,
  review_creation_date,
  review_answer_timestamp,
FROM `raw_olist.reviews`;