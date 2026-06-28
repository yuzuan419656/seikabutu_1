WITH ranked_reviews AS (
  SELECT
    order_id,
    review_score,
    review_answer_timestamp,

    ROW_NUMBER() OVER(
      PARTITION BY order_id
      ORDER BY review_answer_timestamp DESC
    ) AS rn

  FROM {{ref('stg_reviews')}}
)

SELECT
  order_id,
  review_score
FROM ranked_reviews
WHERE rn = 1