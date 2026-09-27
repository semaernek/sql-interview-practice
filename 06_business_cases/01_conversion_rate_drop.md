# Business Case: Conversion Rate Drop

## Business Problem

The company's overall conversion rate dropped by 10% compared with the previous month.

The goal is to identify where the decline is coming from, understand the potential causes, and determine what additional analysis is needed before taking action.

---

## Investigation Approach

I would investigate the problem in the following order:

### 1. Data Quality

First, I would make sure the decline is real and not caused by a data issue.

I would check:

- Missing or delayed data
- Missing conversion events
- Tracking issues
- Changes in event definitions
- ETL or pipeline failures
- Unexpected changes in data volume

If the data quality is not reliable, I would resolve this before continuing with the business analysis.

---

### 2. Metric Definition

Next, I would validate how the conversion rate is calculated.

I would check:

- The definition of conversion
- Numerator and denominator
- Whether the calculation changed recently
- Whether the same definition is used across dashboards and reports
- Whether the decline is visible in the underlying data as well as the dashboard

This helps make sure that the reported 10% decline is a real business change.

---

### 3. Segmentation

If the data and metric definition are correct, I would break down the conversion rate into smaller segments.

For example:

- New vs. returning users
- Mobile vs. desktop
- App vs. web
- Country / region
- Traffic source
- Browser
- Operating system
- Customer segment

The goal is to identify which segment is contributing most to the overall decline.

---

### 4. Funnel Analysis

After identifying the affected segment, I would analyze the conversion funnel.

For an e-commerce business, I might look at:

```text
Homepage
    ↓
Product View
    ↓
Add to Cart
    ↓
Checkout
    ↓
Purchase
