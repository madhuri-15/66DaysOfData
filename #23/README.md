# Top 5 States With 5 Star Businesses

#### Question

Find the top 5 states with the most 5 star businesses. Output the state name along with the number of 5-star businesses and order records by the number of 5-star businesses in descending order. In case there are ties in the number of businesses, return all the unique states. If two states have the same result, sort them in alphabetical order.

`Company : Yelp`

`Table:  yelp_business`

**Data Structure**

***yelp_business***

```
business_id:            varchar
name:                   varchar
neighborhood:           varchar
address:                varchar
city:                   varchar
state:                  varchar
postal_code:            varchar
latitude:               float
longitude:              float
stars:                  float
review_count:           int
is_open:                int
categories:             varchar
```

**Approach**

First, Let's start by looking at the data from table. 

```sql
SELECT * 
FROM yelp_business;
```

- First, we filter data where business has 5 stars rating for each states using GROUP BY and WHERE clause. 

```sql
SELECT state,
       count(stars) AS n_business
FROM yelp_business
WHERE stars=5
GROUP BY state
ORDER BY n_business DESC, state;
```

| state | n_business |
| ----- | ---------- |
| AZ    | 10         |
| ON    | 5          |

- Finally, let's create temporary table to store values from above table and then using SUBQUERY filter the data further by rank. We give a rank according to the  number of 5 star business each state have. 

Final Solution

```sql
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
```

| state | n_business |
| ----- | ---------- |
| AZ    | 10         |
| ON    | 5          |
