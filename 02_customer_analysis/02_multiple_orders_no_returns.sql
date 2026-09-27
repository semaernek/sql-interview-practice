-- Question:
-- How many customers in each country have made multiple orders-- but have never had a returned item?

-- Dataset:
-- bigquery-public-data.thelook_ecommerce.users
-- bigquery-public-data.thelook_ecommerce.order_items

-- Approach:
-- First identify customers who have returned items.
-- Exclude those customers, then identify customers with multiple orders
-- and count them by country.

WITH customer_orders AS (
    SELECT
        user_id,
        order_id,
        country,
        status
    FROM `bigquery-public-data.thelook_ecommerce.users` AS users
    INNER JOIN `bigquery-public-data.thelook_ecommerce.order_items` AS order_items
        ON users.id = order_items.user_id
),

returned_customers AS (
    SELECT DISTINCT
        user_id
    FROM customer_orders
    WHERE status = "Returned"
),

customers_without_returns AS (
    SELECT *
    FROM customer_orders
    WHERE user_id NOT IN (
        SELECT user_id
        FROM returned_customers
    )
    
    -- Alternative:
    -- NOT EXISTS can be used instead of NOT IN.
    -- It is generally safer when the subquery may contain NULL values.
    --
    -- WHERE NOT EXISTS (
    --     SELECT 1
    --     FROM returned_customers AS returned
    --     WHERE returned.user_id = customer_orders.user_id
    -- )
),

multiple_order_customers AS (
    SELECT
        user_id,
        country,
        COUNT(DISTINCT order_id) AS order_count
    FROM customers_without_returns
    GROUP BY
        user_id,
        country
    HAVING COUNT(DISTINCT order_id) > 1
)

SELECT
    country,
    COUNT(DISTINCT user_id) AS customer_count
FROM multiple_order_customers
GROUP BY country
ORDER BY customer_count DESC
