-- PostgreSQL
-- Find the average total compensation based on employee titles and gender. 
-- Total compensation is calculated by adding both the salary and bonus of each employee. 
-- However, not every employee receives a bonus so disregard employees without bonuses in your calculation. 
-- Employee can receive more than one bonus.
-- Output the employee title, gender (i.e., sex), along with the average total compensation.
SELECT employee_title,
       sex,
       AVG(e.salary + b.total_bonus) as avg_compensation
FROM sf_employee e
INNER JOIN (SELECT worker_ref_id,
                  sum(bonus) as total_bonus
            FROM sf_bonus
            GROUP BY worker_ref_id) b ON e.id = b.worker_ref_id
GROUP BY e.employee_title, 
         e.sex;  
