-- PostgreSQL
-- Find the Olympics with the highest number of athletes. 
-- The Olympics game is a combination of the year and the season, and is found in the 'games' column. 
-- Output the Olympics along with the corresponding number of athletes.
WITH athletes_cte AS
  (SELECT games,
          count(DISTINCT id) AS athletes_count
   FROM olympics_athletes_events
   GROUP BY games
   ORDER BY athletes_count DESC)
   
SELECT *
FROM athletes_cte 
WHERE athletes_count =
    (SELECT max(athletes_count)
     FROM athletes_cte )
