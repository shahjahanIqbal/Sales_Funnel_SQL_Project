# E-Commerce Sales Funnel Analysis

SQL-based analysis of an e-commerce event dataset using **Google BigQuery**. The project examines user progression through the sales funnel, conversion rates, traffic-source performance, time to conversion, and revenue metrics.

## Project Overview

The analysis uses event-level user activity to evaluate five stages of an e-commerce funnel:

1. Page view
2. Add to cart
3. Checkout start
4. Payment information
5. Purchase

The SQL queries calculate funnel volume, stage-to-stage conversion rates, traffic-source performance, conversion timing, and core revenue KPIs.

## Dataset

The uploaded dataset contains:

- **Rows:** 9,381
- **Unique users:** 5,000
- **Date range:** 2025-12-30 04:58:24.517006 to 2026-02-03 04:10:18.555901
- **Columns:** event_id, user_id, event_type, event_date, product_id, amount, traffic_source

### Event types

- `page_view`: 5,000 events
- `add_to_cart`: 1,553 events
- `checkout_start`: 1,103 events
- `payment_info`: 899 events
- `purchase`: 826 events

The primary fields used by the analysis are:

| Column | Purpose |
|---|---|
| `event_id` | Unique event identifier |
| `user_id` | User identifier |
| `event_type` | Type of funnel event |
| `event_date` | Event timestamp |
| `product_id` | Product associated with the event |
| `amount` | Transaction amount for purchase events |
| `traffic_source` | Source through which the user arrived |
| `week_day` | Day of week associated with the event |

## Tools

- Google BigQuery
- GoogleSQL
- Git / GitHub

## SQL Techniques Used

The project demonstrates:

- Common Table Expressions (CTEs)
- Conditional aggregation
- `COUNT(DISTINCT ...)`
- `CASE WHEN`
- `GROUP BY`
- `ORDER BY`
- Timestamp/date filtering
- `TIMESTAMP_DIFF`
- Aggregate functions such as `COUNT`, `SUM`, `AVG`, `MIN`
- Funnel conversion calculations

## Analysis

### 1. Funnel Stages

`01_funnel_stages.sql` counts unique users reaching each stage of the sales funnel.

### 2. Funnel Conversion Rates

`02_funnel_conversion_rates.sql` calculates conversion rates between consecutive stages as well as the overall page-view-to-purchase conversion rate.

### 3. Funnel by Traffic Source

`03_funnel_by_traffic_source.sql` compares page views, carts, purchases, and conversion rates across traffic sources.

### 4. Time to Conversion

`04_time_to_conversion.sql` builds a user-level journey for users who completed a purchase and measures the average time between:

- Page view → Add to cart
- Add to cart → Purchase
- Page view → Purchase

### 5. Revenue Metrics

`05_revenue_metrics.sql` calculates:

- Total visitors
- Total buyers
- Total orders
- Total revenue
- Average order value
- Revenue per buyer
- Revenue per visitor

## Repository Structure

```text
sales-funnel-analysis/
│
├── README.md
│
└── sql/
    ├── 00_preview_data.sql
    ├── 01_funnel_stages.sql
    ├── 02_funnel_conversion_rates.sql
    ├── 03_funnel_by_traffic_source.sql
    ├── 04_time_to_conversion.sql
    └── 05_revenue_metrics.sql
```

## BigQuery Setup

The original queries reference:

```text
sales-funnel-analysis-491415.sales01.Sales
```

If recreating the project in a new BigQuery project, upload the event dataset as a table named `Sales` inside a dataset such as `sales01`, then update the fully qualified table reference in the SQL files.

For example:

```sql
FROM `YOUR_PROJECT.sales01.Sales`
```

## Analysis Window

The original queries use the following filter:

```sql
WHERE event_date >= TIMESTAMP(
    DATE_SUB('2025-12-01', INTERVAL 30 DAY)
)
```

This corresponds to an analysis start date of **2025-11-01**.

The uploaded dataset begins on **2025-12-30 04:58:24.517006**, so this filter includes the available records in the uploaded dataset.

## Notes

This repository preserves the structure and analytical logic of the original BigQuery analysis. The SQL is organized into separate files to make the workflow easier to understand, reproduce, and extend.

## Potential Extensions

Future iterations could extend the analysis with:

- User-level funnel sequencing
- Window functions for first/last-touch attribution
- Cohort analysis
- Repeat-purchase analysis
- Conversion analysis by product
- Conversion analysis by weekday
- More robust division using `SAFE_DIVIDE`
- Visualization of funnel drop-off and traffic-source performance

