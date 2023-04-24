-- PostgreSQL
-- Classify each business as either a restaurant, cafe, school, or other.
-- Output the business name and their classification.
-- Solution 1: Using Substring
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
-- Solution 2: Using RegEx
SELECT DISTINCT(business_name),
       CASE 
            WHEN business_name ~* 'restaurant' THEN 'restaurant'
            WHEN business_name ~* 'cafe|café|coffee' THEN 'cafe'
            WHEN business_name ~* 'school' THEN 'school'
            ELSE 'other'
        END AS category
FROM sf_restaurant_health_violations;
