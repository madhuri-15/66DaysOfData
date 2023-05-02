-- PostgreSQL
-- Find the customer with the highest daily total order cost between 2019-02-01 to 2019-05-01. 
-- If customer had more than one order on a certain day, sum the order costs on daily basis. 
-- Output customer's first name, total cost of their items, and the date.
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
