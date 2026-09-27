-- Question:
-- What is the total revenue by country?

-- Dataset:
-- bigquery-public-data.thelook_ecommerce

-- Approach:
-- Join users with order_items and calculate revenue
-- for completed orders by country.

WITH revenue AS (
    SELECT
        country,
        SUM(sale_price) AS revenue
    FROM `bigquery-public-data.thelook_ecommerce.users` AS users
    INNER JOIN `bigquery-public-data.thelook_ecommerce.order_items` AS order_items
        ON users.id = order_items.user_id
    WHERE order_items.status = "Complete"
    GROUP BY country
)

SELECT *
FROM revenue
ORDER BY revenue DESC;
