-- =========================================================
-- SQL PRACTICE - CTEs (COMMON TABLE EXPRESSIONS)
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
-- BASIC CTE
-- Show departments where average salary is greater than 60000
-- =========================================================

WITH CTE_Average_Department_Salary AS (
	SELECT	dept_id AS 'Department ID',
			AVG(salary) AS 'Average Salary'
	FROM employee_salary
	GROUP BY dept_id
)

SELECT *
FROM CTE_Average_Department_Salary
WHERE `Average Salary` > 60000;


-- =========================================================
-- CTE WITH AGGREGATION
-- Department employee summary with filtering
-- =========================================================

WITH CTE_department_summary AS (
	SELECT	dept_id AS 'Department ID',
			COUNT(employee_id) AS 'Total Employees',
			ROUND(AVG(salary), 2) AS 'Average Department Salary'
	FROM employee_salary
	GROUP BY `Department ID`
)

SELECT	`Department ID`,
		`Total Employees`,
		`Average Department Salary`
FROM CTE_department_summary
WHERE `Total Employees` > 2
	AND `Average Department Salary` > 50000
ORDER BY `Average Department Salary` DESC;


-- =========================================================
-- CTE + JOIN + AGGREGATION
-- Department summary using departments and salary tables
-- =========================================================

WITH CTE_department_summary AS (
	SELECT	pd.department_id AS 'Department ID',
			pd.department_name AS 'Department Name',
			COUNT(sal.employee_id) AS 'Total Employees',
			ROUND(AVG(sal.salary), 2) AS 'Average Department Salary'
	FROM parks_departments AS pd
	RIGHT OUTER JOIN employee_salary AS sal
		ON sal.dept_id = pd.department_id
	GROUP BY `Department ID`, `Department Name`
)

SELECT	`Department ID`,
		`Department Name`,
		`Total Employees`,
		`Average Department Salary`
FROM CTE_department_summary
WHERE `Total Employees` > 2
	AND `Average Department Salary` > 50000
ORDER BY `Average Department Salary` DESC;


-- =========================================================
-- CTE + WINDOW FUNCTION
-- Rank employees by salary within each department
-- =========================================================

WITH CTE_employee_dataset AS (
	SELECT	employee_id AS 'Employee ID',
			first_name AS 'First Name',
			last_name AS 'Last Name',
			dept_id AS 'Department ID',
			salary AS 'Salary',
			RANK() OVER(
				PARTITION BY dept_id
				ORDER BY salary DESC
			) AS 'Salary Rank'
	FROM employee_salary
)

SELECT	*
FROM CTE_employee_dataset
ORDER BY `Department ID`, `Salary` DESC;


-- =========================================================
-- TOP N PER GROUP
-- Show top 2 highest paid employees per department
-- =========================================================

WITH CTE_employee_rankings AS (
	SELECT	employee_id AS 'Employee ID',
			first_name AS 'First Name',
			last_name AS 'Last Name',
			dept_id AS 'Department ID',
			salary AS 'Salary',
			RANK() OVER(
				PARTITION BY dept_id
				ORDER BY salary DESC
			) AS 'Salary Rank'
	FROM employee_salary
)

SELECT	*
FROM CTE_employee_rankings
WHERE `Salary Rank` <= 2
ORDER BY `Department ID`, `Salary` DESC;