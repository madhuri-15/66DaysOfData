# Number of violations

#### Question

You're given a dataset of health inspections. Count the number of violation in an inspection in 'Roxanne Cafe' for each year. If an inspection resulted in a violation, there will be a value in the 'violation_id' column. Output the number of violations by year in ascending order.

`Company : City of San Francisco`

`Table:  sf_restaurant_health_violations`

**Data Structure**

***sf_restaurant_health_violations`***

```
business_id:                 int
business_name:               varchar
business_address:            varchar
business_city:               varchar
business_state:              varchar
business_postal_code:        float
business_latitude:           float
business_longitude:          float
business_location:           varchar
business_phone_number:       float
inspection_id:               varchar
inspection_date:             datetime
inspection_score:            float
inspection_type:             varchar
violation_id:                varchar
violation_description:       varchar
risk_category:               varchar
```

**Approach**

First,  start by looking at the data from the table.

```sql
SELECT * 
FROM sf_restaurant_health_violations;
```

- To calculate inspection in 'Roxanne Cafe', we filter the data for `Roxanne Cafe` using the `WHERE` clause.

```sql
SELECT business_id,
       business_name,
       inspection_date,
       violation_id
FROM sf_restaurant_health_violations
WHERE 
    business_name = 'Roxanne Cafe';
```

| business_id | business_name | inspection_date | violation_id        |
| ----------- |:------------- | --------------- | ------------------- |
| 500         | Roxanne Cafe  | 2015-09-30      | 500_20150930_103145 |
| 500         | Roxanne Cafe  | 2018-04-03      | 500_20180403_103149 |
| 500         | Roxanne Cafe  | 2016-11-28      | 500_20161128_103133 |

- Next, To calculate the inspection, we need to extract the year from the inspection_date column. For that, we can use the `EXTRACT()` date function of PostgreSQL.

```sql
SELECT inspection_date,
       EXTRACT(YEAR FROM inspection_date) AS year
FROM sf_restaurant_health_violations
WHERE 
    business_name = 'Roxanne Cafe';
```

| inspection_date | year |
| --------------- | ---- |
| 2015-09-30      | 2015 |
| 2018-04-03      | 2018 |

 - Finally, we group data by year and calculate the number of inspections where there is a violation using the `GROUP BY` clause and order results in ascending order by year column.

Final Solution
```sql
SELECT EXTRACT(YEAR FROM inspection_date) AS year,
       COUNT(violation_id) as n_inspections
FROM sf_restaurant_health_violations
WHERE business_name = 'Roxanne Cafe'
  AND violation_id IS NOT NULL
GROUP BY 
    year
ORDER BY 
    year;
```

| year | n_inspections |
| ---- | ------------- |
| 2015 | 5             |
| 2016 | 2             |
