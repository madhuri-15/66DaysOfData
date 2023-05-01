# Largest Olympics

#### Question

Find the Olympics with the highest number of athletes. The Olympics game is a combination of the year and the season, and is found in the 'games' column. Output the Olympics along with the corresponding number of athletes.

`Company : ESPN`

`Table:  olympics_athletes_events`

**Data Structure**

```
id:            int
name:          varchar
sex:           varchar
age:           float
height:        float
weight:        datetime
team:          varchar
noc:           varchar
games:         varchar
year:          int
season:        varchar
city:          varchar
sport:         varchar
event:         varchar
medal:         varchar
```

**Approach**

First, Let's start by looking at the data from table. 

```sql
SELECT * 
FROM olympics_athletes_events;
```

- After looking at the data there might be a duplicates for an `id` of athletes. As we need to find the highest number of athletes, we would like to have unique id. Let's find out whether there are more records for one athletes.

```sql
SELECT id,
       count(id) as athletes_count
FROM olympics_athletes_events
GROUP BY id
ORDER BY count(id) DESC;
```

| id    | athletes_count |
| ----- | -------------- |
| 5     | 6              |
| 12198 | 3              |
| 68934 | 2              |

- Next, we will calcualate the unique count of number of athlethes using DISTINCT on id column and GROUP BY on column games.
  
  
  
  ```sql
  SELECT games,
         count(DISTINCT id) AS athletes_count
  FROM olympics_athletes_events
  GROUP BY games
  ORDER BY athletes_count DESC;
  ```
  
  | games       | athletes_count |
  | ----------- | -------------- |
  | 1924 Summer | 118            |
  | 1908 Summer | 70             |
  

- Finally, we will store the above query in temporary table and use it in WHERE clause to find the maximum athlethe count.

Final Solution

```sql
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
```

| games       | athletes_count |
| ----------- | -------------- |
| 1924 Summer | 118            |
