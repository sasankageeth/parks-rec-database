-- =========================================================
-- SQL PRACTICE - SUBQUERIES + JOINS + CASE
-- =========================================================

-- Show all databases
SHOW DATABASES;

-- Select database
USE `Parks_and_Recreation`;


-- =========================================================
-- VIEW TABLES
-- =========================================================

SELECT * 
FROM employee_demographics;

SELECT * 
FROM employee_salary;

SELECT * 
FROM parks_departments;


-- =========================================================
-- CASE + LEFT JOIN + GROUP BY + HAVING
-- Workforce compensation summary by department and salary category
-- =========================================================

SELECT	pd.department_name AS 'Department Name',
		CASE
			WHEN sal.salary >= 75000 THEN 'Premium Staff'
            WHEN sal.salary >= 50000 AND sal.salary <= 74999 THEN 'Standard Staff'
            WHEN sal.salary < 50000 THEN 'Support Staff'
            ELSE 'No Employee Information'
        END AS 'Salary Category',
        COUNT(dem.employee_id) AS 'Total Employees',
        ROUND(AVG(sal.salary), 2) AS 'Average Salary',
        ROUND(AVG(dem.age), 2) AS 'Average Employee Age',
        MIN(dem.age) AS 'Youngest Employee Age'
FROM parks_departments AS pd
LEFT OUTER JOIN employee_salary AS sal
	ON pd.department_id = sal.dept_id
LEFT OUTER JOIN employee_demographics AS dem
	ON sal.employee_id = dem.employee_id
GROUP BY `Department Name`, `Salary Category`
HAVING `Total Employees` >= 1 AND `Average Salary` > 45000
ORDER BY `Average Employee Age` DESC;


-- =========================================================
-- SUBQUERY IN SELECT + WHERE
-- Show employees earning more than company average salary
-- Also display company average salary
-- =========================================================

SELECT * 
FROM employee_salary;

SELECT	first_name AS 'First Name',
		last_name AS 'Lirst Name',
        occupation AS 'Occupation',
        salary AS 'Salary',
        (SELECT AVG(salary) FROM employee_salary) AS 'Company Average Salary' 
FROM employee_salary
WHERE salary > (
	SELECT	AVG(salary)
	FROM employee_salary
)
ORDER BY `Salary` DESC;


-- =========================================================
-- SUBQUERY IN SELECT + WHERE
-- Show employees older than company average age
-- Also display company average age
-- =========================================================

SELECT * 
FROM employee_demographics;

SELECT	first_name AS 'First Name',
		last_name AS 'Last Name',
        age AS 'Age',
        gender AS 'Gender',
        (SELECT AVG(age) FROM employee_demographics) AS 'Company Average Age'
FROM employee_demographics
WHERE age > (
	SELECT AVG(age) FROM employee_demographics
)
ORDER BY `Age` DESC;


-- =========================================================
-- CORRELATED SUBQUERY
-- Show employees earning more than their department average salary
-- Also display department average salary
-- =========================================================

SELECT *  
FROM employee_salary;

SELECT	first_name AS 'First Name',
		last_name AS 'Last Name',
		dept_id AS 'Department ID',
        salary AS 'Salary',
        (SELECT ROUND(AVG(inner_table.salary), 2) 
        FROM employee_salary AS inner_table 
        WHERE outer_table.dept_id = inner_table.dept_id) AS 'Department Average Salary'
FROM employee_salary AS outer_table
WHERE	outer_table.salary > (
		SELECT AVG(inner_table.salary)
		FROM employee_salary AS inner_table
        WHERE outer_table.dept_id = inner_table.dept_id
)
ORDER BY `Salary` DESC;


-- =========================================================
-- VIEW TABLES BEFORE MULTI-TABLE JOIN
-- =========================================================

SELECT * 
FROM employee_demographics;

SELECT * 
FROM employee_salary;

SELECT * 
FROM parks_departments;


-- =========================================================
-- LEFT JOIN ALL TABLES
-- View combined employee, salary, and department information
-- =========================================================

SELECT	*
FROM employee_demographics AS dem
LEFT OUTER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
LEFT OUTER JOIN parks_departments AS pd
	ON sal.dept_id = pd.department_id;


-- =========================================================
-- JOINS + CORRELATED SUBQUERIES
-- Show employees whose:
-- salary is greater than their department average salary
-- age is greater than their gender average age
-- =========================================================

SELECT	dem.first_name AS 'First Name',
		dem.last_name AS 'Last Name',
        dem.gender AS 'Gender',
        pd.department_name AS 'Department Name',
        sal.salary AS 'Salary',
        dem.age AS 'Age',
        (SELECT ROUND(AVG(inner_sal.salary), 2) 
        FROM employee_salary AS inner_sal
        WHERE inner_sal.dept_id = pd.department_id) AS 'Average Dept Salary',
        (SELECT AVG(inner_dem.age) 
        FROM employee_demographics AS inner_dem
        WHERE inner_dem.gender = dem.gender) AS 'Gender Average Age'
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments AS pd
	ON sal.dept_id = pd.department_id
WHERE sal.salary > (
		SELECT ROUND(AVG(inner_sal.salary), 2) 
        FROM employee_salary AS inner_sal
        WHERE inner_sal.dept_id = pd.department_id
) AND dem.age > (
		SELECT AVG(inner_dem.age) 
        FROM employee_demographics AS inner_dem
        WHERE inner_dem.gender = dem.gender
)
ORDER BY `Salary` DESC;


-- =========================================================
-- CORRELATED SUBQUERY
-- Average department salary comparison
-- =========================================================

-- Avgerage Dept SAL
SELECT *,
		(SELECT AVG(inner_sal.salary) 
        FROM employee_salary AS inner_sal
        WHERE outer_sal.dept_id = inner_sal.dept_id) AS 'Average Dept SAL'
FROM employee_salary AS outer_sal
WHERE outer_sal.salary > (
		SELECT AVG(inner_sal.salary) 
        FROM employee_salary AS inner_sal
        WHERE outer_sal.dept_id = inner_sal.dept_id
);


-- =========================================================
-- CORRELATED SUBQUERY
-- Average gender age comparison
-- =========================================================

-- Average Gender Age
SELECT	*,
		( SELECT ROUND(AVG(inner_dem.age), 2)
        FROM employee_demographics AS inner_dem
        WHERE outer_dem.gender = inner_dem.gender ) AS 'Average Gender Age'
FROM employee_demographics AS outer_dem
WHERE outer_dem.age > (
		SELECT AVG(inner_dem.age) 
        FROM employee_demographics AS inner_dem
        WHERE outer_dem.gender = inner_dem.gender
);