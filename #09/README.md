# Highest Salary In Department

#### Question

Find the employee with the highest salary per department.
Output the department name, employee's first name along with the corresponding salary.

`Company : Twitter, Asana`

`Table:  employee`

**Data Structure**

***evnets***

```
id:                 int
first_name:         varchar
last_name:          varchar
age:                int
sex:                varchar
employee_title:     varchar
department:         varchar
salary:             int
target:             int
bonus:              int
email:              varchar
city:               varchar
address:            varchar
manager_id:         int
```

**Approach**

First, Let's start by looking at the data from the employee table. We need to query the employee's name, with its department, and salary.

```sql
SELECT department,
       first_name as employee_name,
       salary 
FROM employee;
```

| department | employee_name | salary |
| ---------- | ------------- | ------ |
| Sales      | Max           | 1300   |
| Management | Katty         | 150000 |
| Management | Richerd       | 250000 |

- To find the highest salary per department, we need to group data by department using `GROUP BY` clause.

```sql
SELECT department,
       MAX(salary) as max_salary
FROM employee
GROUP BY 
    department;
```

| department | max_salary |
| ---------- |:---------- |
| Management | 250000     |
| Sales      | 2200       |
| Audit      | 1100       |

- Finally, to find an employee with the highest salary per department. We store the above results as a temporary table using `WITH` clause and join that table with the employee table on the corresponding department and salary.

Final Solution

```sql
-- Create temporary table 'max_sal'
WITH max_sal AS
    (SELECT department,
            MAX(salary) as salary
    FROM employee
    GROUP BY 
        department)


-- Join employee table with max_sal table
SELECT e.department,
       e.first_name as employee_name,
       e.salary
FROM employee e
INNER JOIN max_sal m
        ON e.department = m.department
       AND e.salary = m.salary;
```

| department | employee_name | salary |
| ---------- | ------------- | ------ |
| Management | Richerd       | 250000 |
| Sales      | Mick          | 2200   |
| Audit      | Shandler      | 1100   |
