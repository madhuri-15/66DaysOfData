# Classify Business Type

#### Question

Classify each business as either a restaurant, cafe, school, or other.

- A restaurant should have the word 'restaurant' in the business name.
- A cafe should have either 'cafe', 'café', or 'coffee' in the business name.
- A school should have the word 'school' in the business name.
- All other businesses should be classified as 'other'.

Output the business name and their classification.

`Company : City of San Francisco`

`Table:  sf_restaurant_health_violations`

**Data Structure**

```
business_id:            int
business_name:          varchar
business_address:       varchar
business_city:          varchar
business_state:         varchar
business_postal_code:   float
business_latitude:      float
business_longitude:     float
business_location:      varchar
business_phone_number:  float
inspection_id:          varchar
inspection_date:        datetime
inspection_score:       float
inspection_type:        varchar
violation_id:           varchar
violation_description:  varchar
risk_category:          varchar
```

**Approach**

First, Let's start by looking at the data from table. As we need to categorized the type of businesses using business names.

```sql
SELECT business_name
FROM sf_restaurant_health_violations;
```

| business_name               |
| --------------------------- |
| John Chin Elementary School |
| Sutter Pub and Restaurant   |
| SRI THAI CUISINE            |

- Let's first query the `business_name` column with the required category from name using a string function called `SUBSTRING()`.

```sql
SELECT business_name,
       SUBSTRING(LOWER(business_name), 'restaurant') as restaurant,
       SUBSTRING(LOWER(business_name), 'cafe') as cafe
FROM sf_restaurant_health_violations;
```

| business_name               | restaurant | cafe |
| --------------------------- | ---------- |:---- |
| John Chin Elementary School |            |      |
| Sutter Pub and Restaurant   | restaurant |      |
| Cafe Bakery                 |            | cafe |

- Finally, use a single CASE statement to categorize businesses into each category using SUBSTRING or RegEX operator ~* which returns the boolean value upon matching patterns, to find a business category in the name.
Final Solution

```sql
-- Solution 1
SELECT DISTINCT(business_name),
       CASE 
            WHEN SUBSTRING(LOWER(business_name), 'restaurant') = 'restaurant' THEN 'restaurant'
            WHEN SUBSTRING(LOWER(business_name), 'cafe') = 'cafe' THEN 'cafe'
            WHEN SUBSTRING(LOWER(business_name), 'café') = 'café' THEN 'cafe'
            WHEN SUBSTRING(LOWER(business_name), 'coffee') = 'coffee' THEN 'cafe'
            WHEN SUBSTRING(LOWER(business_name), 'school') = 'school' THEN 'school'
            ELSE 'other'
        END AS category
FROM sf_restaurant_health_violations;


-- Solution 2
SELECT DISTINCT(business_name),
       CASE 
            WHEN business_name ~* 'restaurant' THEN 'restaurant'
            WHEN business_name ~* 'cafe|café|coffee' THEN 'cafe'
            WHEN business_name ~* 'school' THEN 'school'
            ELSE 'other'
        END AS category
FROM sf_restaurant_health_violations;
```

| business_name     | category |
| ----------------- | -------- |
| Starbucks         | other    |
| TAWAN'S THAI FOOD | other    |
| Burger King 4525  | other    |
