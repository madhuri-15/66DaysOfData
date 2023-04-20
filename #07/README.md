# App Click-through Rate (CTR)

#### Question

Assume you have an events table on Facebook app analytics. Write a query to calculate the click-through rate (CTR) for the app in 2022 and round the results to 2 decimal places.
Definition and note:

- Percentage of click-through rate (CTR) = 100.0 * Number of clicks / Number of impressions
- To avoid integer division, multiply the CTR by 100.0, not 100.

`Company : Meta/Facebook`

`Table:  events`

**Data Structure**

***evnets***

```
app_id:          int
event_type:      varchar
timestamp:       int
```

**Approach**

First, Let's start by looking at the data from the event table.

```sql
SELECT * 
FROM events;
```

| app_id | event_type | timestamp           |
| ------ | ---------- | ------------------- |
| 123    | impression | 07/18/2022 11:36:12 |
| 123    | impression | 07/18/2022 11:37:12 |
| 123    | click      | 07/18/2022 11:37:42 |

- We need to calculate the click-through rate (CTR) for each app for the year 2022. For that, let's first filter data for the year 2022 using the `WHERE` clause.

```sql
SELECT *
FROM events
WHERE timestamp >= '2022-01-01'
  AND timestamp < '2023-01-01';
```

| app_id | event_type | timestamp           |
| ------ |:---------- | ------------------- |
| 123    | impression | 07/18/2022 11:36:12 |
| 123    | impression | 07/18/2022 11:37:12 |
| 123    | click      | 07/18/2022 11:37:42 |

- To calculate CTR for each app, we need to calculate the number of clicks and the number of impressions. 
  Using the `CASE` statement, we can calculate the click counts by assigning 1 for each click and 0 for other events.
  
  We repeat the same for the impression counts.

```sql
SELECT app_id,
       (CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) as clicks,
       (CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END) as impressions
FROM events
WHERE timestamp >= '2022-01-01'
  AND timestamp < '2023-01-01';
```

| app_id | clicks | impressions |
| ------ | ------ | ----------- |
| 123    | 0      | 1           |
| 123    | 0      | 1           |
| 123    | 1      | 0           |
| 234    | 0      | 1           |
| 234    | 1      | 0           |

Then, we calculate total clicks and impressions using `SUM()` aggregate function on the `CASE` statement and group the results by `app_id`.

```sql
SELECT app_id,
       SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) as clicks,
       SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END) as impressions
FROM events
WHERE timestamp >= '2022-01-01'
  AND timestamp < '2023-01-01'
GROUP BY app_id;
```

| app_id | clicks | impressions |
| ------ | ------ | ----------- |
| 123    | 2      | 3           |
| 234    | 1      | 3           |

Finally, calculate the percentage of CTR using the above formula by dividing the number of clicks by the number of impressions and multiplying by 100.0. We round the results to 2 decimal points using the `ROUND()` function.

Final Solution.

```sql
SELECT 
  app_id,
  ROUND(100.0 *
    SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) /
    SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END), 2) as ctr_rate
FROM events
WHERE timestamp >= '2022-01-01'
  AND timestamp < '2023-01-01'
GROUP BY app_id;
```
