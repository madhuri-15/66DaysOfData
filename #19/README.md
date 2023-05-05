# Workers With The Highest Salaries

#### Question

You have been asked to find the job titles of the highest-paid employees.

Your output should include the highest-paid title or multiple titles with the same salary.

`Company : Amazon, DoorDash`

`Tables: worker, title`

**Data Structure**

***worker***

```
worker_id:        int
first_name:       varchar
last_name:        varchar
salary:           int
joining_date:     datetime
department:       varchar
```

***title***

```
worker_ref_id:        int
worker_title:         varchar
affected_from:        datetime
```

**Approach**

- First, Let's start by looking at the data from tables. 

```sql
SELECT * 
FROM worker;

SELECT * 
FROM title;
```

- To find the highest-paid employees from table WORKER table, we can use a subquery on the WHERE clause, 
which filters the salaries equal to the maximum salary from the table.

```sql
SELECT * 
FROM worker
WHERE 
    salary IN (SELECT MAX(salary) FROM worker)
ORDER BY 
    salary DESC;
```

| worker_id | first_name | last_name | salary | joining_date | department |
| --------- | ---------- |:--------- | ------ | ------------ | ---------- |
| 4         | Amitah     | Singh     | 500000 | 2014-02-20   | Admin      |
| 5         | Vivek      | Bhati     | 500000 | 2014-06-11   | Admin      |

- Finally, we can join the worker and title table on `worker_id` to to find the job titles of the highest-paid employees with above filter on WHERE clause.

Final Solution

```sql
SELECT worker_title AS best_paid_title 
  FROM worker w
  JOIN title t
    ON w.worker_id = t.worker_ref_id
 WHERE 
      salary IN (SELECT MAX(salary) FROM worker)
ORDER BY 
    salary DESC; 
```

| best_paid_title |
| --------------- |
| Manager         |
| Asst. Manager   |
