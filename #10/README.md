# Find the top 10 ranked songs in 2010

#### Question

What were the top 10 ranked songs in 2010?
Output the rank, group name, and song name but do not show the same song twice.
Sort the result based on the year_rank in ascending order.

`Company : Spotify`

`Table:  billboard_top_100_year_end`

**Data Structure**

```
year:                  int
year_rank:             int
group_name:            varchar
artist:                varchar
song_name:             varchar
id:                    int
```

**Approach**

First, Let's start by looking at the data from table. 

```sql
SELECT * 
FROM billboard_top_100_year_end;
```

| year | year_rank | group_name    | artist        | song_name        | id |
| ---- | --------- | ------------- | ------------- | ---------------- | -- |
| 1956 | 1         | ELVIS PRESLEY | ELVIS PRESLEY | Heartbreak Hotel | 1  |
| 1956 | 2         | ELVIS PRESLEY | ELVIS PRESLEY | Don't Be Cruel   | 2  |

- We need to query top 10 songs in year 2010. Let's filter data where year is equal to 2010 and sort data by year_rank.

```sql
SELECT *
FROM billboard_top_100_year_end
WHERE 
    year =  2010
ORDER BY 
    year_rank;
```

| year | year_rank | group_name      | artist          | song_name    | id   |
| ---- | --------- | --------------- | --------------- | ------------ | ---- |
| 2010 | 1         | KE$HA           | KE$HA           | Tik Tok      | 5909 |
| 2010 | 2         | LADY ANTEBELLUM | LADY ANTEBELLUM | Need You Now | 5910 |

- Finally, we query distinct songs with the rank, group name, and song name and 
  Sort the result based on the year_rank in ascending order.

Final Solution

```sql
SELECT DISTINCT(year_rank) as rank,
       group_name,
       song_name
FROM billboard_top_100_year_end
WHERE 
    year =  2010
ORDER BY 
    year_rank
LIMIT 10;
```

| year_rank | group_name      | song_name        |
| --------- | --------------- | ---------------- |
| 1         | KE$HA           | Tik Tok          |
| 2         | LADY ANTEBELLUM | Need You Now     |
| 3         | TRAIN           | Hey, Soul Sister |
