# Highest Cost Orders

#### Question

Find the customer with the highest daily total order cost between 2019-02-01 to 2019-05-01. If customer had more than one order on a certain day, sum the order costs on daily basis. Output customer's first name, total cost of their items, and the date.

For simplicity, you can assume that every first name in the dataset is unique.

`Company : Amazon, Shopify`

`Tables:  customers, orders`

**Data Structure**

***customers***

```
id:                int
first_name:        varchar
last_name:         varchar
city:              varchar
address:           varchar
phone_number:      varchar
```

***orders***

```
id:                    int
cust_id:               int
order_date:            datetime
order_details:         varchar
total_order_cost:      int
```

**Approach**

First, Let's start by looking at the data from tables. 

```sql
SELECT * 
FROM customers;

```

| id  | first_name | last_name | city          | address | phone_number |
| --- | ---------- | --------- | ------------- | ------- | ------------ |
| 8   | John       | Joseph    | San Francisco |         | 928-386-8164 |
| 7   | Jill       | Michael   | Austin        |         | 813-297-0692 |
| 4   | William    | Daniel    | Denver        |         | 813-368-1200 |

```sql
SELECT * 
FROM orders;
```

| id  | cust_id | order_date | order_details | total_order_cost |
| --- | ------- | ---------- | ------------- | ---------------- |
| 1   | 3       | 2019-03-04 | Coat          | 100              |
| 2   | 3       | 2019-03-01 | Shoes         | 80               |

- In order to find the customer with the highest daily total order cost between 2019-02-01 to 2019-05-01, first filter data based on `order_date`.

```sql
SELECT * 
FROM orders
WHERE order_date ( BETWEEN '2019-02-01' 
                       AND '2019-05-01');
```

| id  | cust_id | order_date | order_details | total_order_cost |
| --- | ------- | ---------- | ------------- |:---------------- |
| 1   | 3       | 2019-03-04 | Coat          | 100              |
| 2   | 3       | 2019-03-01 | Shoes         | 80               |

- Now, join these customer and order table on customer id column using `LEFT JOIN`.
  
  
  
  ```sql
  SELECT *
  FROM customers c
  LEFT JOIN orders o
         ON c.id = o.cust_id
  WHERE o.order_date ( BETWEEN '2019-02-01' 
                           AND '2019-05-01');
  ```
  
  
- Finally, If customer had more than one order on a certain day, sum the order costs on daily basis. To calculate the sum of total order by customer, we use  `GROUP BY` on order_date on above filter data and customer's first name as we assume that there are unique first name present in dataset. To get the highest order customer we use `ORDER BY` clause on total to sort results in descending orders.

Final solution.

```sql
SELECT c.first_name, 
       o.order_date,
       sum(o.total_order_cost) as total_cost
FROM customers c
LEFT JOIN orders o
       ON c.id = o.cust_id
WHERE o.order_date ( BETWEEN '2019-02-01' 
                         AND '2019-05-01')
GROUP BY order_date,
         first_name
ORDER BY total_cost DESC
LIMIT 1;
```

| first_name | order_date | total_cost |
| ---------- | ---------- | ---------- |
| Jill       | 2019-04-19 | 275        |
