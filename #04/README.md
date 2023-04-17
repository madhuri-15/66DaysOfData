# Salaries Differences

#### Question

Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. Output just the absolute difference in salaries.

`Company : LinkedIn Dropbox`

`Table: db_employee, db_dept`

**Data Structure**

***db_employee***

```
id:               int
first_name:       varchar
last_name:        varchar
salary:           int
department_id:    int
```

***db_dept***

```
id:            int
department:    varchar
```

**Approach**

First, Let's start by looking at the data from both tables. 

```
SELECT *
FROM db_employee;
```

| id    | first_name | last_name | salary | department_id |
| ----- | ---------- | --------- | ------ | ------------- |
| 10301 | Keith      | Morgan    | 27056  | 2             |
| 10302 | Tyler      | Booth     | 32199  | 3             |
| 10303 | Clifford   | Nguyen    | 32165  | 2             |

```
SELECT *
FROM db_dept;
```

| id  | department     |
| --- | -------------- |
| 1   | engineering    |
| 2   | human resource |

To find the maximum salary of each department

- First join two tables using `INNER JOIN` on common columns `id` and `department_id` from tables `db_dept` and `db_employee` respectively.

- Query the columns department and salary from join table.

```
SELECT 
    department,
    salary
FROM db_employee E
INNER JOIN db_dept D
ON E.department_id =  D.id;
```

| department     | salary |
| -------------- | ------ |
| human resource | 27056  |
| operation      | 32199  |
| human resource | 32165  |
| operation      | 49488  |

- Next, we compute the maximum salary of each departments by using `GROUP BY` clause on department column.

```
SELECT 
    department,
    MAX(salary) as salary
FROM db_employee E
JOIN db_dept D
ON E.department_id =  D.id
GROUP BY department;
```

| department     | salary |
| -------------- | ------ |
| customer care  | 49926  |
| operation      | 49488  |
| human resource | 46356  |
| marketing      | 48187  |

- To save the above results as a table, create a common table expression CTE for temperary table.

```
WITH max_salary AS
    (
    SELECT 
        department,
        MAX(salary) as salary
     FROM db_employee E
     JOIN db_dept D
     ON E.department_id =  D.id
     GROUP BY department
    )
SELECT * FROM max_salary;
```

| department     | salary |
| -------------- | ------ |
| customer care  | 49926  |
| operation      | 49488  |
| human resource | 46356  |
| marketing      | 48187  |

- Using `max_salary` table, write a query which calculate difference between maximum salary from marketing and engineering departments.

Final Solution
```
WITH max_salary AS
    (
    SELECT 
        department,
        MAX(salary) as salary
     FROM db_employee E
     JOIN db_dept D
     ON E.department_id =  D.id
     GROUP BY department
    )

SELECT (
    (SELECT salary FROM max_salary WHERE department='marketing') 
    -
    (SELECT salary FROM max_salary WHERE department='engineering')
) AS salary_differences;
```

| salary_differences |
| ------------------ |
| 2400               |
