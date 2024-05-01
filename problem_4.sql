--Deparment Top 3 Salaries

SELECT d.name as 'Department', e.name as 'Employee', e.salary as 'Salary'
FROM Employee e LEFT JOIN Department d ON e.departmentId = d.id
WHERE 3 > (
    SELECT COUNT(DISTINCT e2.salary) FROM Employee e2
    WHERE e.departmentId = e2.departmentId AND e2.salary > e.salary
);

--using CTE and Dense_rank()

WITH CTE AS(
    SELECT e.name, e.departmentId, e.salary, DENSE_RANK() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC)
    AS 'rnk' FROM Employee e
)
SELECT d.name as 'Department', c.name as 'Employee', c.Salary
FROM CTE c LEFT JOIN Department d ON c.departmentId = d.Id 
WHERE c.rnk <= 3;