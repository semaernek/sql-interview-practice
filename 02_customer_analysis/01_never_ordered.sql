-- Question:
-- What percentage of customers have never placed an order?

-- Dataset:
-- bigquery-public-data.thelook_ecommerce.users
-- bigquery-public-data.thelook_ecommerce.orders

-- Approach:
-- Identify customers with and without orders,
-- then calculate the percentage of customers who have never ordered.

WITH customers AS (
    SELECT DISTINCT
        id
    FROM `bigquery-public-data.thelook_ecommerce.users`
),

orders AS (
    SELECT DISTINCT
        user_id
    FROM `bigquery-public-data.thelook_ecommerce.orders`
),

non_order AS (
    SELECT
        C.id,
        CASE
            WHEN O.user_id IS NOT NULL THEN 1
            ELSE 0
        END AS ordered
    FROM customers C
    LEFT JOIN orders O
        ON C.id = O.user_id
),

result AS (
    SELECT
        COUNT(id) AS all_customers,
        SUM(ordered) AS ordered_customers
    FROM non_order
)

SELECT
    all_customers AS total_customers,
    all_customers - ordered_customers AS customers_with_no_orders,
    ROUND(
        SAFE_DIVIDE(
            all_customers - ordered_customers,
            result.all_customers
        ) * 100,
        2
    ) AS percentage_with_no_orders
FROM result;
