# Income By Title and Gender

#### Question

Find the average total compensation based on employee titles and gender. Total compensation is calculated by adding both the salary and bonus of each employee. However, not every employee receives a bonus so disregard employees without bonuses in your calculation. Employee can receive more than one bonus.
Output the employee title, gender (i.e., sex), along with the average total compensation.

`Company : City of San Francisco`

`Tables: sf_employee, sf_bonus`

**Data Structure**

***sf_employee***

```
id:                int
first_name:        varchar
last_name:         varchar
age:               int
sex:               varchar
employee_title:    varchar
department:        varchar
salary:            int
target:            int
email:             varchar
city:              varchar
address:           varchar
manager_id:        int
```

***sf_bonus***

```
worker_ref_id:     int
bonus:             int
```



**Approach**

First, Let's start by looking at the data from tables. 

```sql
SELECT * 
FROM sf_employee;
```

```sql
SELECT * 
FROM sf_bonus;
```

| worker_ref_id | bonus |
| ------------- | ----- |
| 1             | 5000  |
| 2             | 3000  |
| 1             | 4500  |

- When we look at the `sf_bonus`  table we can see that worker_ref_id is not a primary key. 
First,  we make the worker_ref_id unique by using `GROUP BY` clause on worker_ref_id column and calculate the total bonus.

```sql
SELECT worker_ref_id,
       sum(bonus) as total_bonus
FROM sf_bonus
GROUP BY worker_ref_id
```

| worker_ref_id | total_bonus |
| ------------- | ----------- |
| 30            | 500         |
| 3             | 4000        |

- Finally, using above query we join two tables and calculate the average of salary and bonus using GROUP BY on employee_title and sex column.

Final Solution

```sql
SELECT employee_title,
       sex,
       AVG(e.salary + b.total_bonus) as avg_compensation
FROM sf_employee e
INNER JOIN (SELECT worker_ref_id,
                  sum(bonus) as total_bonus
            FROM sf_bonus
            GROUP BY worker_ref_id) b ON e.id = b.worker_ref_id
GROUP BY e.employee_title, 
         e.sex;  
```

| employee_title | sex | avg_compensation |
| -------------- | --- | ---------------- |
| Senior Sales   | M   | 5350             |
| Sales          | M   | 4600             |
| Auditor        | M   | 2200             |
| Manager        | F   | 209500           |
