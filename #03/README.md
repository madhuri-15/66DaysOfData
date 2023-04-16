# Find the most profitable company in the financial sector of the entire world along with its continent

#### Question

Find the most profitable company from the financial sector. Output the result along with the continent.

`Table: forbes_global_2010_2014`

**Data Structure**

```
company:        varchar
sector:         varchar
industry:       varchar
continent:      varchar
country:        varchar
marketvalue:    float
sales:          float
profits:        float
assets:         float
rank:           int
forbeswebpage:  varchar
```

**Approach**

Let's start by looking at the data from a table. 

```
SELECT *
FROM forbes_global_2010_2014;
```

We need to find a company from the `Financials` sector. Let's first see the company  from the financial sector with their profits. 

```
SELECT 
    company, 
    profits
FROM 
    forbes_global_2010_2014
WHERE 
    sector = 'Financials';
```

| company                 | profits |
| ----------------------- | ------- |
| ICBC                    | 42.7    |
| China Construction Bank | 34.2    |

We can find the most profitable company by ordering the results from above table in descending order using `ORDER BY` clause.

```
SELECT 
    company, 
    profits
FROM 
    forbes_global_2010_2014
WHERE 
    sector = 'Financials'
ORDER BY profits DESC
```

| company                    | profits |
| -------------------------- | ------- |
| ICBC                       | 42.7    |
| China Construction Bank    | 34.2    |
| Agricultural Bank of China | 27      |

Finally, we can query the most profitable company with contient by limiting above result using `LIMIT 1`

```
SELECT 
    company, 
    continent
FROM forbes_global_2010_2014
WHERE 
    sector = 'Financials'
ORDER BY 
    profits DESC
LIMIT 1;
```

| company | continent |
| ------- | --------- |
| ICBC    | Asia      |


