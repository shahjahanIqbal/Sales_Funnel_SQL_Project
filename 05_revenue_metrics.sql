-- Sales Funnel Analysis
-- 5. Calculate visitor, buyer, order, and revenue metrics.

WITH revenue AS (
    SELECT
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS total_visitors,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS total_buyers,
        SUM(CASE WHEN event_type = 'purchase' THEN amount END) AS total_revenue,
        COUNT(CASE WHEN event_type = 'purchase' THEN 1 END) AS total_orders
    FROM `sales-funnel-analysis-491415.sales01.Sales`
    WHERE event_date >= TIMESTAMP(DATE_SUB('2025-12-01', INTERVAL 30 DAY))
)

SELECT
    ROUND(total_visitors) AS total_visitors,
    ROUND(total_buyers) AS total_buyers,
    ROUND(total_revenue) AS total_revenue,
    ROUND(total_orders) AS total_orders,
    ROUND(total_revenue / total_orders) AS average_order_value,
    ROUND(total_revenue / total_buyers) AS revenue_per_buyer,
    ROUND(total_revenue / total_visitors) AS revenue_per_visitor
FROM revenue;
