-- Sales Funnel Analysis
-- 4. Measure the average time taken by converted users to progress
--    through the funnel.

WITH user_journey AS (
    SELECT
        user_id,
        MIN(CASE WHEN event_type = 'page_view' THEN event_date END) AS view_time,
        MIN(CASE WHEN event_type = 'add_to_cart' THEN event_date END) AS cart_time,
        MIN(CASE WHEN event_type = 'purchase' THEN event_date END) AS purchase_time
    FROM `sales-funnel-analysis-491415.sales01.Sales`
    WHERE event_date >= TIMESTAMP(DATE_SUB('2025-12-01', INTERVAL 30 DAY))
    GROUP BY user_id
    HAVING MIN(CASE WHEN event_type = 'purchase' THEN event_date END) IS NOT NULL
)

SELECT
    COUNT(*) AS converted_users,
    ROUND(AVG(TIMESTAMP_DIFF(cart_time, view_time, MINUTE))) AS avg_view_to_cart_minute,
    ROUND(AVG(TIMESTAMP_DIFF(purchase_time, cart_time, MINUTE))) AS avg_cart_to_purchase_minute,
    ROUND(AVG(TIMESTAMP_DIFF(purchase_time, view_time, MINUTE))) AS avg_view_to_purchase_minute
FROM user_journey;
