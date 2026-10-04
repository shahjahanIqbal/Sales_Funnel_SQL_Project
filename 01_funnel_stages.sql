-- Sales Funnel Analysis
-- 1. Define the sales funnel and count unique users at each stage.
-- Analysis window: data available from 2025-11-01 onward based on the original query.

WITH funnel_stages AS (
    SELECT
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS stage_1_views,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS stage_2_cart,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS stage_3_checkout,
        COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS stage_4_payment,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS stage_5_purchase
    FROM `sales-funnel-analysis-491415.sales01.Sales`
    WHERE event_date >= TIMESTAMP(DATE_SUB('2025-12-01', INTERVAL 30 DAY))
)

SELECT *
FROM funnel_stages;
