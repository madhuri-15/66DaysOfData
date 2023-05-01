# Employee and Manager Salaries

#### Question

Find employees who are earning more than their managers. Output the employee's first name along with the corresponding salary.

`Company : Walmart, Best Buy, Dropbox`

`Table:  employee`

**Data Structure**

```
id:                int
first_name:        varchar
last_name:         varchar
age:               int
sex:               varchar
employee_title:    varchar
department:        varchar
salary:            int
target:            int
bonus:             int
email:             varchar
city:              varchar
address:           varchar
manager_id:        int
```

**Approach**

First, Let's start by looking at the data from table. 

```sql
SELECT * 
FROM employee;
```

- First, let's look at the manager's information about their salary and id.

```sql
SELECT manager_id,
       salary,
       employee_title
FROM employee
WHERE employee_title = 'Manager';
```

| manager_id | salary | employee_title |
| ---------- | ------ |:-------------- |
| 1          | 150000 | Manager        |
| 1          | 250000 | Manager        |
| 1          | 100000 | Manager        |

- Finally, use a self join on employee id and manager id to join data and use `WHERE` 
clause to find the records of employees whos salary is more than their manager.

Final Solution

```sql
SELECT 
       a.first_name AS employee_name,
       a.salary AS employee_salary
FROM employee as a
JOIN employee as b ON a.manager_id = b.id
WHERE a.salary > b.salary;   
```

| employee_name | employee_salary |
| ------------- | --------------- |
| Richerd       | 250000          |
