# Premium vs Freemium

#### Question

Find the total number of downloads for paying and non-paying users by date. Include only records where non-paying customers have more downloads than paying customers. The output should be sorted by earliest date first and contain 3 columns date, non-paying downloads, paying downloads.

`Company : Microsoft`

`Table: ms_user_dimension, ms_acc_dimension, ms_download_facts `

**Data Structure**

***ms_user_dimension***

```
user_id:         int
acc_id:          int
```

***ms_user_dimension***

```
acc_id:             int
paying_customer:    varchar
```

***ms_download_facts***

```
date:            datetime
user_id:         int
downloads:       int
```

**Approach**

- In order to find number of paying and non paying customers by date. we join all tables using LEFT join and compute total number of user using CASE and GROUP BY clause. And then store result as temporary table using WITH Clause.

```sql
WITH user_cte AS (
                   SELECT d.date,
                          SUM(CASE WHEN u.paying_customer = 'yes' THEN downloads END) AS paying,
                          SUM(CASE WHEN u.paying_customer = 'no' THEN downloads END) AS non_paying
                   FROM ms_user_dimension AS u
                   LEFT JOIN ms_acc_dimension AS a ON u.acc_id = a.acc_id
                   LEFT JOIN ms_download_facts AS d ON u.user_id = d.user_id
                   GROUP BY date
                   ORDER BY date
)


SELECT *
FROM user_cte;
```

| date       | paying | non_paying |
| ---------- | ------ | ---------- |
| 2020-08-15 | 19     | 11         |
| 2020-08-16 | 14     | 15         |
| 2020-08-17 | 9      | 45         |

- Finally, to get only records where non-paying customers have more downloads than paying customers. We filter data using WHERE Clause and sort data by  date.

Final Solution.

```sql
WITH user_cte AS (
                   SELECT d.date,
                          SUM(CASE WHEN u.paying_customer = 'yes' THEN downloads END) AS paying,
                          SUM(CASE WHEN u.paying_customer = 'no' THEN downloads END) AS non_paying
                   FROM ms_user_dimension AS u
                   LEFT JOIN ms_acc_dimension AS a ON u.acc_id = a.acc_id
                   LEFT JOIN ms_download_facts AS d ON u.user_id = d.user_id
                   GROUP BY date
                   ORDER BY date
)

SELECT date,
       non_paying,
       paying
FROM user_cte
WHERE (non_paying - paying) > 0
ORDER BY date;
```

| date       | non_paying | paying |
| ---------- | ---------- | ------ |
| 2020-08-16 | 15         | 14     |
| 2020-08-17 | 45         | 9      |
| 2020-08-18 | 10         | 7      |
```
