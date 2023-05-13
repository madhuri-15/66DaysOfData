-- PostgreSQL
-- Find the top 5 states with the most 5 star businesses. 
-- Output the state name along with the number of 5-star businesses and order records by the number of 5-star businesses in descending order.
WITH n_business_cte AS (
    SELECT state,
       count(stars) AS n_business
    FROM yelp_business
    WHERE stars=5
    GROUP BY state
    ORDER BY n_business DESC, state
)

SELECT state,
       n_business
FROM
  (SELECT *,
          rank() OVER (
                       ORDER BY n_business DESC) AS rnk
   FROM cte) AS a
WHERE rnk <= 5
ORDER BY n_business DESC,
         state ASC       
