CREATE OR REPLACE TABLE mart_olist.mart_model_features AS

SELECT
    order_id,

    CASE
        WHEN review_score <= 2 THEN 1
        ELSE 0
    END AS is_low_score,

    item_count,
    total_price,
    total_freight,
    total_payment,

    delivery_days,
    delay_days,

    customer_state,
    payment_type,
    main_category,

    EXTRACT(DAYOFWEEK FROM order_purchase_timestamp)
        AS purchase_weekday,

    EXTRACT(HOUR FROM order_purchase_timestamp)
        AS purchase_hour,
        
    SAFE_DIVIDE(
    total_freight,
    total_price
) AS freight_ratio

FROM mart_olist.mart_order_review

WHERE
    order_status = 'delivered'
    AND review_score IS NOT NULL;