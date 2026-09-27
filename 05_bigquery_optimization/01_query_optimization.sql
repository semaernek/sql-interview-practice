-- Question:
-- A BigQuery query that calculates monthly revenue by country
-- is running slowly and processing a large amount of data.
-- How would you optimize the query?

-- Dataset:
-- bigquery-public-data.thelook_ecommerce.users
-- bigquery-public-data.thelook_ecommerce.orders
-- bigquery-public-data.thelook_ecommerce.order_items

-- Original query:
-- The query joins users, orders, and order_items and calculates
-- monthly revenue for completed orders.

SELECT
    U.country,
    DATE_TRUNC(DATE(OI.created_at), MONTH) AS month,
    SUM(OI.sale_price) AS revenue
FROM `bigquery-public-data.thelook_ecommerce.users` AS U
INNER JOIN `bigquery-public-data.thelook_ecommerce.orders` AS O
    ON U.id = O.user_id
INNER JOIN `bigquery-public-data.thelook_ecommerce.order_items` AS OI
    ON O.order_id = OI.order_id
WHERE O.status = "Complete"
GROUP BY
    U.country,
    month
ORDER BY
    month,
    revenue DESC;


-- Optimization considerations:
--
-- 1. Filter the data as early as possible.
--    Apply status and date filters before large joins
--    to reduce the amount of data processed.
--
-- 2. Use partition pruning.
--    If the relevant tables are partitioned by a date column,
--    filter directly on that column.
--    Avoid applying functions to the partition column in the filter
--    because this can prevent efficient partition pruning.
--
-- 3. Narrow the date range.
--    Instead of scanning the entire table, filter only the
--    period required for the analysis.
--
-- 4. Remove unnecessary joins.
--    Check whether every joined table is required for the final result.
--    If a table does not contribute to the output or filtering,
--    the join can be removed.
--
-- 5. Reduce data before joining.
--    When possible, filter or aggregate large tables before joining
--    them with other tables.
--
-- 6. Check table partitioning and clustering.
--    Partitioning can reduce the amount of data scanned,
--    while clustering can improve filtering and aggregation
--    performance on frequently used columns.
--
-- 7. Check query execution details.
--    Review bytes processed, bytes billed, partition pruning,
--    slot usage, and the execution plan to identify expensive stages.
--
-- 8. Avoid SELECT * when it is not necessary.
--    Select only the columns required for the analysis
--    to reduce data processed.
--
-- Important:
-- The actual optimization should be validated using BigQuery's
-- query execution details rather than assuming that one optimization
-- will always improve performance.
