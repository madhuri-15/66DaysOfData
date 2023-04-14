# Finding Updated Records 

#### Question
We have a table with employees and their salaries, however, some of the records are old and contain outdated salary information. Find the current salary of each employee assuming that salaries increase each year. Output their id, first name, last name, department ID, and current salary. Order your list by employee ID in ascending order.

[solution](https://github.com/madhuri-15/66DaysOfData/blob/main/%2301/solution.sql)

`Table: ms_employee_salary`

**Data Structure**

```
id:               int
first_name:       varchar
last_name:        varchar
salary:           int
department_id:    int
```

**Approach**

We need to find the current salary of each employee, So we start by looking at the entire data from a table.

```
SELECT *
FROM ms_employee_salary
```

| id  | first_name | last_name | salary | department_id |
| --- | ---------- | --------- | ------ | ------------- |
| 1   | Todd       | Wilson    | 110000 | 1006          |
| 1   | Todd       | Wilson    | 106119 | 1006          |
| 2   | Justin     | Simon     | 128922 | 1005          |
| 2   | Justin     | Simon     | 130000 | 1005          |

The above table has multiple records for each employee with outdated salary information. Assuming the salary of the employees increases each year, the current salary would be the highest salary of the employee. 
We can get the highest salary by using `GROUP BY` on the `id` column using the `MAX(salary)` aggregate function.

```
SELECT id, 
     MAX(salary) as salary
FROM ms_employee_salary
GROUP BY id
ORDER BY id;
```

This queries the `id` and `MAX(salary)` columns only.

| id  | salary |
| --- | ------ |
| 1   | 110000 |
| 2   | 130000 |

But the output should be all the details of all employees with the correct salary. For that, we can use the `PARTITION BY` clause; 
With GROUP BY clause, we can only use column in select statement that is used in the group by clause. 

PARTITION BY with OVER clause allows us to query column information that is not part of the partitions. 
To get unique records of employees for only the current year, we will use the `DISTINCT` function on `id`.

```
SELECT 
    DISTINCT(id),
    first_name,
    last_name,
    department_id, 
    MAX(salary) OVER(PARTITION BY id) AS salary
FROM 
    ms_employee_salary
ORDER BY 
    id;
```

| id  | first_name | last_name | department_id | salary |
| --- | ---------- | --------- | ------------- | ------ |
| 1   | Todd       | Wilson    | 1006          | 110000 |
| 2   | Justin     | Simon     | 1005          | 130000 |
