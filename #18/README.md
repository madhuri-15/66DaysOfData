# Find all wineries which produce wines by possessing aromas of plum, cherry, rose, or hazelnut

#### Question

Find all wineries which produce wines by possessing aromas of plum, cherry, rose, or hazelnut. To make it more simple, look only for singular form of the mentioned aromas. HINT: if one of the specified words is just a substring of another word, this should not be a hit, but a miss.

*Example Description:* Hot, tannic and simple, with **cherry** jam and currant flavors accompanied by high, tart acidity and chile-pepper alcohol heat.
Therefore the winery *Bella Piazza* is expected in the results.

`Company : Wine Magazine`

`Table:  winemag_p1`

**Data Structure**

```
id:               int
country:          varchar
description:      varchar
designation:      varchar
points:           int
price:            float
province:         varchar
region_1:         varchar
region_2:         varchar
variety:          varchar
winery:           varchar
```

**Approach**

First, Let's start by looking at the data from table. 

```sql
SELECT * 
FROM winemag_p1;
```

We looking for all wineries which includes these four aromas of plum, cherry, rose, or hazelnut in their description column. 
For that, we will use RegEx to match words in description. here `~` is use for case insensitive match and `\y` is used for matching only that particular words and not word as substring of other word.

Final Solution.

```sql
SELECT DISTINCT winery
FROM winemag_p1
WHERE description ~ '\y(plum|cherry|hazelnut|rose)\y'

```

| winery              | 
| ------------------- |
| Geyser Peak         |
| Les Belles Collines |
| Martin Ray          |
