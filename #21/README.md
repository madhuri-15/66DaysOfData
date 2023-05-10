# Number Of Units Per Nationality

#### Question

Find the number of apartments per nationality that are owned by people under 30 years old.
Output the nationality along with the number of apartments.
Sort records by the apartments count in descending order.

`Company : Airbnb`

`Table: airbnb_hosts, airbnb_units`

**Data Structure**

***airbnb_hosts***

```
host_id:            int
nationality:        varchar
gender:             varchar
age:                int 
```

***airbnb_units***

```
host_id:            int
unit_id:            varchar
unit_type:          varchar
n_beds:             int
n_bedrooms:         int
country:            varchar
city:               varchar
```

**Approach**

First, Let's start by looking at the data from table. 

```sql
SELECT * 
FROM airbnb_hosts;

SELECT * 
FROM airbnb_units;
```

- In order to find the number of apartment per nationality we join two tables using INNER JOIN clause and then apply filter on AGE and UNIT_TYPE as we would want the number of apartments for host whose age less than 30.

```sql
SELECT h.host_id,
       nationality,
       gender,
       age,
       unit_id,
       unit_type
FROM airbnb_hosts as h
JOIN airbnb_units as u
  ON h.host_id = u.host_id
WHERE age < 30 
  AND unit_type='Apartment';
```

| host_id | nationality | gender | age | unit_id | unit_type |
| ------- | ----------- |:------ | --- | ------- | --------- |
| 1       | USA         | F      | 29  | A5      | Apartment |
| 1       | USA         | F      | 29  | A4      | Apartment |
| 1       | USA         | F      | 29  | A5      | Apartment |

- Finally, we use a GROUP BY on nationality and count unit_id using DISTINCT contrain to get the unique count value and sort the data in descending order of apartment count.

Final Solution

```sql
SELECT nationality,
       COUNT(DISTINCT u.unit_id) as apartment_count
FROM airbnb_hosts as h
JOIN airbnb_units as u
  ON h.host_id = u.host_id
WHERE age < 30 
  AND unit_type='Apartment'
GROUP BY 
      h.nationality
ORDER BY 
      apartment_count DESC;  
```

| nationality | apartment_count |
| ----------- | --------------- |
| USA         | 2               |
