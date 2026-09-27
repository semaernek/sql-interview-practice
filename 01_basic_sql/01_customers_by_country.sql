-- Question:
-- How many customers are there in each country?

-- Dataset:
-- bigquery-public-data.thelook_ecommerce.users

-- Approach:
-- Group customers by country and count distinct customers.

WITH customers AS (
    SELECT
        country,
        COUNT(DISTINCT id) AS customer_count
    FROM `bigquery-public-data.thelook_ecommerce.users`
    GROUP BY country
)

SELECT *
FROM customers
ORDER BY customer_count DESC;
