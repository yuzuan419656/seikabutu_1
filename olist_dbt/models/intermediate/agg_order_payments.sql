WITH payment_rank AS (

  SELECT
    order_id,
    payment_type,
    payment_value,

    ROW_NUMBER() OVER (
      PARTITION BY order_id
      ORDER BY payment_value DESC
    ) AS rn

  FROM {{ ref('stg_payments') }}

)

SELECT
  order_id,

  SUM(payment_value) AS total_payment,

  MAX(
    CASE
      WHEN rn = 1 THEN payment_type
    END
  ) AS payment_type

FROM payment_rank

GROUP BY order_id