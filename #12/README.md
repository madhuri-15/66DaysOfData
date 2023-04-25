# Customer Revenue In March

#### Question

Calculate the total revenue from each customer in March 2019. Include only customers who were active in March 2019.

Output the revenue along with the customer id and sort the results based on the revenue in descending order.

`Company : Amazon, Meta/Facebook`

`Table:  orders`

**Data Structure**

```
id:                    int
cust_id:               int
order_date:            datetime
order_details:         varchar
total_order_cost:      int
```

**Approach**

First, Let's start by looking at the data from table. 

```sql
SELECT * 
FROM orders;
```

| id  | cost_id | order_date | order_details | total_order_cost |
| --- | ------- | ---------- | ------------- | ---------------- |
| 1   | 3       | 2019-03-04 | Coat          | 100              |
| 2   | 7       | 2019-02-01 | Coat          | 25               |



- We need to calculate total revenue for customer in March 2019. So let's filter out data for year 2019 and month of March using `EXTRACT()` method to get the year and month from the `order_date` column.

```sql
SELECT *
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2019
  AND EXTRACT(MONTH FROM order_date) = 3;
```

| id  | cost_id | order_date | order_details | total_order_cost |
| --- | ------- | ---------- | ------------- | ---------------- |
| 1   | 3       | 2019-03-04 | Coat          | 100              |
| 2   | 3       | 2019-03-01 | Shoes         | 80               |

- Finally, we group records by customer id and calculate the total revenue by each customer. 

Final Solution

```sql
SELECT cust_id,
       SUM(total_order_cost) as tal_revenue
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2019
  AND EXTRACT(MONTH FROM order_date) = 3
GROUP BY 
    cust_id
ORDER BY 
    total_revenue DESC;
```

| cust_id | total_revenue |
| ------- | ------------- |
| 3       | 210           |
| 15      | 150           |
| 7       | 80            |
