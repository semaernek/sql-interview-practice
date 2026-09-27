-- Question:
-- For each month, calculate the number and percentage of
-- returning customers.

-- Dataset:
-- bigquery-public-data.thelook_ecommerce.users
-- bigquery-public-data.thelook_ecommerce.order_items

-- Approach:
-- First calculate the number of completed orders for each customer
-- in each month.
-- Then use ROW_NUMBER() to identify the first month in which
-- each customer made a purchase.
-- Customers in their first purchase month are classified as
-- "first_order"; customers who purchased in later months are
-- classified as "returning_order".
-- Finally, calculate the total ordered customers,
-- returning customers, and the percentage of returning customers
-- for each month.

WITH base AS (
    SELECT
        U.id,
        COUNT(DISTINCT order_id) AS order_cnt,
        DATE_TRUNC(DATE(OI.created_at), MONTH) AS month
    FROM `bigquery-public-data.thelook_ecommerce.users` AS U
    INNER JOIN `bigquery-public-data.thelook_ecommerce.order_items` AS OI
        ON U.id = OI.user_id
    WHERE status = "Complete"
    GROUP BY ALL
),

summary AS (
    SELECT
        *,
        CASE
            WHEN ROW_NUMBER() OVER (
                PARTITION BY id
                ORDER BY month
            ) = 1
            THEN "first_order"
            ELSE "returning_order"
        END AS segment
    FROM base
)

SELECT
    month,
    COUNT(DISTINCT id) AS total_ordered_customer,
    COUNT(
        DISTINCT CASE
            WHEN segment = "returning_order" THEN id
        END
    ) AS returning_customers,
    ROUND(
        (
            COUNT(
                DISTINCT CASE
                    WHEN segment = "returning_order" THEN id
                END
            )
            / COUNT(DISTINCT id)
        ) * 100,
        2
    ) AS pct
FROM summary
GROUP BY month
ORDER BY month;
