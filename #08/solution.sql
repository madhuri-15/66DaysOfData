-- PostgreSQL
-- Count the number of violation in an inspection in 'Roxanne Cafe' for each year. If an inspection resulted in a violation, there will be a value in the 'violation_id' column. 
-- Output the number of violations by year in ascending order.
SELECT EXTRACT(YEAR FROM inspection_date) AS year,
       COUNT(violation_id) as n_inspections
FROM sf_restaurant_health_violations
WHERE business_name = 'Roxanne Cafe'
  AND violation_id IS NOT NULL
GROUP BY 
    year
ORDER BY 
    year;
