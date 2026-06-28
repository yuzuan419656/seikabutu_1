WITH items_and_products AS (

    SELECT
        i.order_id,
        p.product_category_name AS category_name

    FROM {{ ref('stg_items') }} AS i
    JOIN {{ ref('stg_products') }} AS p
      ON i.product_id = p.product_id

),

category_count AS (

    SELECT
        order_id,
        category_name,
        COUNT(*) AS category_cnt

    FROM items_and_products

    GROUP BY
        order_id,
        category_name

),

ranked_category AS (

    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY category_cnt DESC,
                     category_name ASC
        ) AS rn

    FROM category_count

)

SELECT
    order_id,
    category_name AS main_category

FROM ranked_category

WHERE rn = 1