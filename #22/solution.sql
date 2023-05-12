-- PostgreSQL
-- You’re given a table of rental property searches by users. 
-- The table consists of search results and outputs host information for searchers. 
-- Find the minimum, average, maximum rental prices for each host’s popularity rating. 
WITH host_popularity AS (
            SELECT DISTINCT concat(price, room_type, host_since, zipcode, number_of_reviews) AS host_id, 
                            number_of_reviews, 
                            price,
                   CASE 
                        WHEN number_of_reviews = 0 THEN 'New' 
                        WHEN number_of_reviews BETWEEN 1 AND 5 THEN 'Rising'
                        WHEN number_of_reviews BETWEEN 6 AND 15 THEN 'Trending Up'
                       WHEN number_of_reviews BETWEEN 16 AND 40 THEN 'Popular'
                        WHEN number_of_reviews > 40 THEN 'Hot'
                   END AS host_pop_rating
        FROM airbnb_host_searches)

SELECT host_pop_rating,
       MIN(price) AS min_price,
       AVG(price) AS avg_price,
       MAX(price) AS max_price
FROM airbnb_new_tb
GROUP BY 
    host_pop_rating;
