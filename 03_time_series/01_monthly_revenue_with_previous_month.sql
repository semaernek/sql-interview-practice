-- Question:
-- For each country, calculate monthly revenue
-- and the revenue growth compared with the previous month.

-- Dataset:
-- bigquery-public-data.thelook_ecommerce.users
-- bigquery-public-data.thelook_ecommerce.order_items

-- Approach:
-- First calculate monthly revenue by country.
-- Then use LAG() to retrieve the previous month's revenue
-- for each country.
-- Finally, calculate the percentage change from the previous month.

WITH base AS (
    SELECT
        country,
        DATE(DATE_TRUNC(OI.created_at, MONTH)) AS month,
        SUM(sale_price) AS revenue
    FROM `bigquery-public-data.thelook_ecommerce.users` AS U
    INNER JOIN `bigquery-public-data.thelook_ecommerce.order_items` AS OI
        ON U.id = OI.user_id
    WHERE status = "Complete"
    GROUP BY
        country,
        month
),

lag_ AS (
    SELECT
        *,
        LAG(revenue) OVER (
            PARTITION BY country
            ORDER BY month
        ) AS previous_month_revenue
    FROM base
)

SELECT
    *,
    ROUND(
        SAFE_DIVIDE(
            revenue - previous_month_revenue,
            previous_month_revenue
        ) * 100,
        2
    ) AS revenue_change_percentage
FROM lag_;
