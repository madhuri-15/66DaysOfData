-- PostgreSQL
-- Write a query to calculate the click-through rate (CTR) for the app in 2022 and round the results to 2 decimal places.
-- Percentage of click-through rate (CTR) = 100.0 * Number of clicks / Number of impressions
SELECT 
  app_id,
  ROUND(100.0 *
    SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) /
    SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END), 2) as ctr_rate
FROM events
WHERE timestamp >= '2022-01-01'
  AND timestamp < '2023-01-01'
GROUP BY 
  app_id;
