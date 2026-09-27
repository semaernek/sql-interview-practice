-- Question:
-- For each country, find the top 3 customers by total revenue.

-- Dataset:
-- bigquery-public-data.thelook_ecommerce.users
-- bigquery-public-data.thelook_ecommerce.order_items

-- Approach:
-- First calculate total revenue for each customer by country.
-- Then rank customers within each country using ROW_NUMBER().
-- QUALIFY is used to keep only the top 3 customers per country.

WITH base AS (
    SELECT
        U.id,
        country,
        SUM(sale_price) AS revenue
    FROM `bigquery-public-data.thelook_ecommerce.users` AS U
    INNER JOIN `bigquery-public-data.thelook_ecommerce.order_items` AS OI
        ON U.id = OI.user_id
    WHERE status = "Complete"
    GROUP BY
        id,
        country
)

SELECT
    *,
    ROW_NUMBER() OVER (
        PARTITION BY country
        ORDER BY revenue DESC
    ) AS RN
FROM base
QUALIFY RN <= 3;
