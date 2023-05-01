# Find matching hosts and guests in a way that they are both of the same gender and nationality

#### Question

Find matching hosts and guests pairs in a way that they are both of the same gender and nationality.
Output the host id and the guest id of matched pair.

`Company : airbnb`

`Table:  airbnb_hosts, airbnb_guests`

**Data Structure**

***airbnb_hosts***

```
host_id:         int
nationality:     varchar
gender:          varchar
age:             int
```

***airbnb_guests***

```
guest_id:         int
nationality:     varchar
gender:          varchar
age:             int
```

**Approach**

First, Let's start by looking at the data from table.

```sql
SELECT * 
FROM airbnb_hosts;

SELECT * 
FROM airbnb_guests;
```

We can find a matching hosts and guests records simply join two tables on gender and nationality using `INNER JOIN`. Since there are multiple entries of ids we use `DISTINCT` to get the unique records.

Final Solution.

```sql
SELECT DISTINCT h.host_id,
                g.guest_id
FROM airbnb_hosts h
JOIN airbnb_guests g
  ON h.nationality = g.nationality 
 AND h.gender = g.gender;
```

| host_id  | guest_id | 
| -------- | -------- |
|        1 |        5 |
|       11 |       11 |
|        8 |        3 |
