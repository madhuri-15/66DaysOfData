# Host Popularity Rental Prices

#### Question

You’re given a table of rental property searches by users. The table consists of search results and outputs host information for searchers. Find the minimum, average, maximum rental prices for each host’s popularity rating. The host’s popularity rating is defined as below:
0 reviews: New
1 to 5 reviews: Rising
6 to 15 reviews: Trending Up
16 to 40 reviews: Popular
more than 40 reviews: Hot

Tip: The `id` column in the table refers to the search ID. You'll need to create your own host_id by concating price, room_type, host_since, zipcode, and number_of_reviews.

Output host popularity rating and their minimum, average and maximum rental prices.

`Company : Airbnb`

`Table:  airbnb_host_searches`

**Data Structure**

```
id:                          int
price:                       float
property_type:               varchar
room_type:                   varchar
amenities:                   varchar
accommodates:                int
bathrooms:                   int
bed_type:                    varchar
cancellation_policy:         varchar
cleaning_fee:                bool
city:                        varchar
host_identity_verified:      varchar
host_response_rate:          varchar
host_since:                  datetime
neighbourhood:               varchar
number_of_reviews:           int
review_scores_rating:        float
zipcode:                     int
bedrooms:                    int
beds:                        int
```

**Approach**

First, Let's start by looking at the data from table. 

```sql
SELECT * 
FROM airbnb_host_searches;
```

- As stated in question that the id is search id and there is possibility that the host may searches for rental property more than once. So first we need to create a unique HOST ID using price, room_type, host_since, zipcode, and number_of_reviews using CONCAT() function. 
- We also create a new column for popularity using  `number_of_reviews` column and create a new temporary table using WITH clause.

```sql
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


SELECT *
FROM host_popularity;
```

| host_id                                | number_of_reviews | price  | host_pop_rating |
| -------------------------------------- | ----------------- |:------ | --------------- |
| 633.51Entire home/apt2015-08-129026543 | 43                | 633.51 | Hot             |
| 389.18Private room2016-02-281003012    | 12                | 389.18 | Trending Up     |
| 433.07Entire home/apt2013-05-30915041  | 1                 | 433.07 | Rising          |

- Finally, we compute the minimum, maximum and average price using GROUP BY caluse on column `host_pop_rating`

Final Solution

```sql
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
```

| host_pop_rating | min_price | avg_price | max_price |
| --------------- | --------- | --------- | --------- |
| New             | 250313.55 | 515.92    | 741.76    |
| Hot             | 340.12    | 464.233   | 633.51    |
