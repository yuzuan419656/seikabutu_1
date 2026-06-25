SELECT
  COUNT(*),
  COUNT(DISTINCT order_id)
FROM stg_olist.stg_reviews;

SELECT
  order_id,
  COUNT(*) AS cnt
FROM stg_olist.stg_reviews
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY cnt DESC;

SELECT *
FROM stg_olist.stg_reviews
WHERE order_id = '03c939fd7fd3b38f8485a0f95798f1f6';

SELECT
  COUNT(*) AS duplicated_orders
FROM (
  SELECT
    order_id
  FROM stg_olist.stg_reviews
  GROUP BY order_id
  HAVING COUNT(DISTINCT review_score) > 1
)
