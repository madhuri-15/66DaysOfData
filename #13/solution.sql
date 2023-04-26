-- PostgreSQL
-- Find matching hosts and guests pairs in a way that they are both of the same gender and nationality.
-- Output the host id and the guest id of matched pair.
SELECT DISTINCT h.host_id,
                g.guest_id
FROM airbnb_hosts h
JOIN airbnb_guests g
  ON h.nationality = g.nationality 
 AND h.gender = g.gender;
