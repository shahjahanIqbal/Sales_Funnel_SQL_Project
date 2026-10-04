-- Sales Funnel Analysis
-- 3. Compare funnel performance across traffic sources.

WITH source_funnel AS (
    SELECT
        traffic_source,
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS views,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS carts,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS purchases
    FROM `sales-funnel-analysis-491415.sales01.Sales`
    WHERE event_date >= TIMESTAMP(DATE_SUB('2025-12-01', INTERVAL 30 DAY))
    GROUP BY traffic_source
)

SELECT
    traffic_source,
    views,
    purchases,
    ROUND(carts * 100 / views) AS carts_conv_rate,
    ROUND(purchases * 100 / views) AS purchase_conv_rate,
    ROUND(purchases * 100 / carts) AS purchase_to_carts_conv_rate
FROM source_funnel
ORDER BY purchases DESC;
