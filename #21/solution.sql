-- PostgreSQL
-- Find the number of apartments per nationality that are owned by people under 30 years old.
-- Output the nationality along with the number of apartments.
-- Sort records by the apartments count in descending order.
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
