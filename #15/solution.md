# Highest Target Under Manager

#### Question

Find the highest target achieved by the employee or employees who works under the manager id 13. Output the first name of the employee and target achieved. The solution should show the highest target achieved under manager_id=13 and which employee(s) achieved it.

`Company : Salesforce`

`Table:  salesforce_employees`

**Data Structure**

```
id:                    int
first_name:            varchar
last_name:             varchar
age:                   int
sex:                   varchar
employee_title:        varchar
department:            varchar
salary:                int
target:                int
bonus:                 int
email:                 varchar
city:                  varchar
address:               varchar
manager_id:            int
```

**Approach**

First, Let's start by looking at the data from table. 

```sql
SELECT * 
FROM salesforce_employees;
```

- Now, filter data for manager with id equal to 13 using `WHERE` clause on `manager_id` column.

```sql
SELECT first_name, 
       target
FROM salesforce_employees
WHERE manager_id = 13
```

- Finally, use the inner query in WHERE  clause to find the highest target achieved by the employee or employees who works under the manager id 13.

Final Solution

```sql
SELECT first_name, 
       target AS max_target
FROM salesforce_employees
WHERE manager_id = 13
  AND target IN (SELECT MAX(target)
                 FROM salesforce_employees
                 WHERE manager_id = 13);   
```

| first_name | max_target |
| ---------- | ---------- |
| Nicky      | 400        |
| Steve      | 400        |
| David      | 400        |
