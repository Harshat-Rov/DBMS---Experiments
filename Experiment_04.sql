-- Experiment 4: Advanced SQL Joins, Subqueries, Set Operations, and EXPLAIN
-- Aim: Using the Employee schema, write queries with INNER JOIN, LEFT JOIN, self-join, 3-way join, correlated subqueries, EXISTS, and simulated INTERSECT and EXCEPT. Compare execution plans using EXPLAIN.

USE CompanyDB;

-- 1. INNER JOIN: Employees matched with department names
SELECT E.emp_id, E.emp_name, D.dept_name 
FROM Employee E
INNER JOIN Department D ON E.dept_id = D.dept_id;

-- 2. LEFT JOIN: All departments with mapped employees
SELECT D.dept_id, D.dept_name, E.emp_name 
FROM Department D
LEFT JOIN Employee E ON D.dept_id = E.dept_id;

-- 3. Self Join: Pairs of employees working in the same department
SELECT E1.emp_name AS Employee1, E2.emp_name AS Employee2, E1.dept_id 
FROM Employee E1
INNER JOIN Employee E2 ON E1.dept_id = E2.dept_id AND E1.emp_id < E2.emp_id;

-- 4. 3-Way Join: Employee, Project, and Department
SELECT E.emp_name, P.project_name, D.dept_name 
FROM Employee E
INNER JOIN Project P ON E.project_id = P.project_id 
INNER JOIN Department D ON E.dept_id = D.dept_id;

-- 5. Correlated Subquery: Employees earning above their department's average
SELECT E.emp_name, E.dept_id, E.salary 
FROM Employee E
WHERE E.salary > (
    SELECT AVG(E2.salary) 
    FROM Employee E2
    WHERE E2.dept_id = E.dept_id
);

-- 6. EXISTS Clause: Employees belonging to departments assigned to projects
SELECT E.emp_id, E.emp_name, E.dept_id 
FROM Employee E
WHERE EXISTS (
    SELECT 1 FROM Project P WHERE P.dept_id = E.dept_id
);

-- 7. Simulated INTERSECT: Employees who live in Delhi AND earn > 60000
SELECT emp_name 
FROM Employee 
WHERE emp_id IN (SELECT emp_id FROM Employee WHERE city = 'Delhi')
  AND emp_id IN (SELECT emp_id FROM Employee WHERE salary > 60000);

-- 8. Simulated EXCEPT: Employees not residing in Delhi
SELECT emp_name 
FROM Employee
WHERE emp_id NOT IN (SELECT emp_id FROM Employee WHERE city = 'Delhi');

-- 9. Execution Plan Analysis using EXPLAIN
EXPLAIN SELECT E.emp_name, D.dept_name 
FROM Employee E
INNER JOIN Department D ON E.dept_id = D.dept_id;

EXPLAIN SELECT D.dept_name, E.emp_name 
FROM Department D
LEFT JOIN Employee E ON D.dept_id = E.dept_id;

EXPLAIN SELECT E.emp_name, E.salary 
FROM Employee E
WHERE E.salary > (
    SELECT AVG(E2.salary) 
    FROM Employee E2
    WHERE E2.dept_id = E.dept_id
);

EXPLAIN SELECT E.emp_name 
FROM Employee E 
WHERE EXISTS (
    SELECT 1 FROM Project P WHERE P.dept_id = E.dept_id
);

-- Expected Output:
-- Joins successfully combine relational tuples; subqueries evaluate against correlated groupings.
-- EXPLAIN plans return rows detailing type, possible_keys, key_len, and rows examined.