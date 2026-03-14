-- Problem : 185. Department Top Three Salaries
-- Difficulty: Hard
-- Tags      : window_function, dense_rank, partition_by
-- Date      :
-- URL       : https://leetcode.com/problems/department-top-three-salaries/
--
-- Task: Find employees who earn one of the top 3 unique salaries
--       in each department.
--
-- Approach: DENSE_RANK() partitioned by department, ordered by salary DESC.
--           Wrap in a subquery, filter WHERE rnk <= 3.
--           DENSE_RANK (not RANK) because ties should not skip ranks.

-- ── Setup ────────────────────────────────────────────────────────
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;

CREATE TABLE Department (id INT, name VARCHAR(50));
CREATE TABLE Employee   (id INT, name VARCHAR(50), salary INT, departmentId INT);

INSERT INTO Department VALUES (1,'IT'),(2,'Sales');
INSERT INTO Employee VALUES
    (1,'Joe',85000,1),(2,'Henry',80000,2),(3,'Sam',60000,2),
    (4,'Max',90000,1),(5,'Janet',69000,1),(6,'Randy',85000,1),(7,'Will',70000,2);

-- ── Solution ─────────────────────────────────────────────────────
SELECT
    d.name  AS Department,
    e.name  AS Employee,
    e.salary AS Salary
FROM (
    SELECT
        name,
        salary,
        departmentId,
        DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS rnk
    FROM Employee
) e
JOIN Department d ON e.departmentId = d.id
WHERE e.rnk <= 3
ORDER BY d.name, e.salary DESC;

-- Expected:
-- +----------+---------+--------+
-- |Department|Employee |Salary  |
-- +----------+---------+--------+
-- |IT        |Max      |90000   |
-- |IT        |Joe      |85000   |
-- |IT        |Randy    |85000   |
-- |IT        |Will     |70000   |  ← tied rank still only rank 2
-- |Sales     |Henry    |80000   |
-- |Sales     |Will     |70000   |
-- |Sales     |Sam      |60000   |
-- +----------+---------+--------+
