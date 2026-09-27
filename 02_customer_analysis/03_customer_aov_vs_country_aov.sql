-- Question:
-- Find customers whose Average Order Value (AOV)
-- is higher than the average AOV of their country.

-- Dataset:
-- bigquery-public-data.thelook_ecommerce.users
-- bigquery-public-data.thelook_ecommerce.order_items

-- Approach:
-- First calculate the revenue for each customer order.
-- Then calculate AOV at the customer and country levels.
-- Finally, compare each customer's AOV with the average AOV of their country.

WITH base AS (
    SELECT
        user_id,
        order_id,
        country,
        SUM(sale_price) AS sale_price
    FROM `bigquery-public-data.thelook_ecommerce.users` AS users
    INNER JOIN `bigquery-public-data.thelook_ecommerce.order_items` AS order_items
        ON users.id = order_items.user_id
    WHERE status = 'Complete'
    GROUP BY
        user_id,
        order_id,
        country
),

customer_avg AS (
    SELECT
        user_id,
        SUM(sale_price) / COUNT(DISTINCT order_id) AS customer_avg_order_value
    FROM base
    GROUP BY
        user_id
),

country_avg AS (
    SELECT
        country,
        SUM(sale_price) / COUNT(DISTINCT order_id) AS country_avg_order_value
    FROM base
    GROUP BY
        country
)

SELECT DISTINCT
    b.country,
    b.user_id,
    cust.customer_avg_order_value,
    country_avg.country_avg_order_value
FROM base AS b
LEFT JOIN customer_avg AS cust
    ON b.user_id = cust.user_id
LEFT JOIN country_avg
    ON b.country = country_avg.country
WHERE cust.customer_avg_order_value > country_avg.country_avg_order_value;
