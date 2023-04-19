# Popularity of Hack

#### Question

Meta/Facebook has developed a new programing language called Hack.To measure the popularity of Hack they ran a survey with their employees. The survey included data on previous programing familiarity as well as the number of years of experience, age, gender and most importantly satisfaction with Hack. Due to an error location data was not collected, but your supervisor demands a report showing average popularity of Hack by office location. Luckily the user IDs of employees completing the surveys were stored.
Based on the above, find the average popularity of the Hack per office location.
Output the location along with the average popularity.

`Company : Meta/Facebook`

`Table:  facebook_employees, facebook_hack_survey`

**Data Structure**

***facebook_employees***

```
id:               int
location:         varchar
age:              int
gender:           varchar
is_senior:        bool
```

***facebook_hack_survey***

```
employee_id:      int
age:              int
gender:           varchar
popularity:       int
```

**Approach**

First, Let's start by looking at the data from tables. 

```
SELECT * 
FROM facebook_employees;
```

| id  | location | age | gender | is_senior |
| --- | -------- | --- | ------ | --------- |
| 0   | USA      | 24  | M      | FALSE     |
| 1   | USA      | 31  | F      | TRUE      |

```
SELECT * 
FROM facebook_hack_survey;
```

| employee_id | age | gender | popularity |
| ----------- | --- | ------ | ---------- |
| 0           | 24  | M      | 6          |
| 1           | 31  | F      | 4          |
| 2           | 29  | F      | 0          |

We need to find the popularity of hack programming language among employees. In order to find that join the employee table with survey table which contains ratings for hack language using `INNER JOIN`.

```
SELECT e.id,
       e.location,
       e.age,
       e.gender,
       s.popularity
FROM 
    facebook_employees e
INNER JOIN 
    facebook_hack_survey s
ON e.id = s.employee_id;
```

| id  | location | age | gender | popularity |
| --- | -------- | --- | ------ | ---------- |
| 0   | USA      | 24  | M      | 6          |
| 1   | USA      | 31  | F      | 4          |
| 2   | USA      | 29  | F      | 0          |

- Now, we just need to group our data by `location` and find the average rate of popularity using aggregate function `AVG`.

Final Solution

```
SELECT location, 
       AVG(popularity) as avg_popularity
FROM 
    facebook_employees e
INNER JOIN 
    facebook_hack_survey s
ON e.id = s.employee_id
GROUP BY location;
```

| location    | avg_popularity |
| ----------- | -------------- |
| India       | 7.5            |
| Switzerland | 1              |
| UK          | 4.333          |
| USA         | 4.6            |
