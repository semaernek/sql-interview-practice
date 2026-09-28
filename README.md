# SQL & Analytics Problem-Solving Portfolio

A collection of SQL analyses, BigQuery optimization examples, customer analytics problems, and business case studies based on real-world analytical scenarios.

The goal of this repository is to demonstrate not only SQL proficiency, but also structured analytical thinking and the ability to translate business questions into data-driven analysis.

---

## Skills Demonstrated

- Advanced SQL
- Google BigQuery
- CTEs
- Window Functions
- Aggregations
- JOINs
- Customer Analytics
- Customer Segmentation
- Time Series Analysis
- Revenue Analysis
- Funnel Analysis
- Business Problem Solving
- Query Optimization
- Data Quality & Validation
- Analytical Problem Structuring

---

## Dataset

Most SQL exercises use the public **The Look Ecommerce** dataset available in Google BigQuery.

Dataset:

`bigquery-public-data.thelook_ecommerce`

Main tables used:

- `users`
- `orders`
- `order_items`
- `products`
- `events`
- `inventory_items`

The dataset represents a fictional e-commerce business and is useful for analyzing customers, orders, revenue, products, and user behavior.

---

## Repository Structure

### 01 — Basic SQL

Fundamental analytical queries involving aggregation, grouping, joins, and revenue analysis.

Examples:

- Customers by country
- Revenue by country

---

### 02 — Customer Analysis

Customer-level analysis and segmentation using aggregation, CTEs, and window functions.

Examples:

- Customers who have never ordered
- Customers with multiple orders and no returns
- Customer AOV vs. country AOV
- Top 3 customers by country

---

### 03 — Time Series Analysis

Analysis of revenue trends and period-over-period changes.

Examples:

- Monthly revenue by country
- Previous-month revenue
- Month-over-month revenue change

---

### 04 — Customer Behavior

Analysis of customer purchasing behavior over time.

Examples:

- First-time vs. returning customers
- Returning customer rate by month

---

### 05 — BigQuery Optimization

Examples focused on query performance and analytical efficiency in BigQuery.

Topics include:

- Partition pruning
- Filtering strategies
- Reducing data before joins
- Removing unnecessary joins
- Partitioning and clustering
- Query execution analysis
- Bytes processed and billed

---

### 06 — Business Cases

Business-oriented analytical problem solving.

Examples:

- Conversion rate decline investigation

These cases focus on how I structure an analytical problem rather than only writing SQL.

---

## Analytical Approach

For business problems, I generally follow a structured approach:

```text
Business Question
       ↓
Data Quality Validation
       ↓
Metric Definition
       ↓
Segmentation
       ↓
Trend / Funnel Analysis
       ↓
Root Cause Investigation
       ↓
Hypothesis Validation
       ↓
Actionable Recommendation
