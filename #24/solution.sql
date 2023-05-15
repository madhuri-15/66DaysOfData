--- PostgreSQL
--- Find the total number of downloads for paying and non-paying users by date. 
--- Include only records where non-paying customers have more downloads than paying customers.
WITH user_cte AS (
                   SELECT d.date,
                          SUM(CASE WHEN u.paying_customer = 'yes' THEN downloads END) AS paying,
                          SUM(CASE WHEN u.paying_customer = 'no' THEN downloads END) AS non_paying
                   FROM ms_user_dimension AS u
                   LEFT JOIN ms_acc_dimension AS a ON u.acc_id = a.acc_id
                   LEFT JOIN ms_download_facts AS d ON u.user_id = d.user_id
                   GROUP BY date
                   ORDER BY date
)

SELECT date,
       non_paying,
       paying
FROM user_cte
WHERE (non_paying - paying) > 0
ORDER BY date;
