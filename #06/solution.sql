-- PostgreSQL
-- Find the average popularity of the Hack per office location.
-- Output the location along with the average popularity.
SELECT location, 
       AVG(popularity) as avg_popularity
FROM 
    facebook_employees e
INNER JOIN 
    facebook_hack_survey s
ON e.id = s.employee_id
GROUP BY location;
