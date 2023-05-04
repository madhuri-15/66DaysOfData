-- PostgreSQL
-- Find all wineries which produce wines by possessing aromas of plum, cherry, rose, or hazelnut
SELECT DISTINCT winery
FROM winemag_p1
WHERE description ~ '\y(plum|cherry|hazelnut|rose)\y';
