-- =========================================================
-- SQL PRACTICE - TEMPORARY TABLES
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
-- TEMP TABLE CREATION
-- Store employees with salary greater than 50000
-- =========================================================

CREATE TEMPORARY TABLE temp_table_1 AS 
	SELECT	employee_id AS 'Employee ID',
			first_name AS 'First Name',
            dept_id AS 'Department ID',
            salary AS 'Salary'
	FROM employee_salary
    WHERE salary > 50000;

SELECT	*
FROM temp_table_1;


-- =========================================================
-- TEMP TABLE + CASE STATEMENT
-- Create salary category classification
-- =========================================================

DROP TEMPORARY TABLE IF EXISTS temp_table_2;

CREATE TEMPORARY TABLE temp_table_2 AS 
	SELECT	employee_id AS 'Employee ID',
			first_name AS 'First Name',
			dept_id AS 'Department ID',
			salary AS 'Salary',
			CASE
				WHEN salary >= 70000 THEN 'High Salary'
				WHEN salary >= 50000 AND salary <= 69999 THEN 'Medium Salary'
				WHEN salary < 50000 THEN 'Low Salary'
			END AS 'Salary Category'
	FROM employee_salary
    WHERE dept_id IS NOT NULL;

SELECT	*
FROM temp_table_2;


-- =========================================================
-- MANUAL TEMP TABLE CREATION
-- Create temp table structure manually
-- =========================================================

DROP TEMPORARY TABLE IF EXISTS temp_high_salary;

CREATE TEMPORARY TABLE temp_high_salary (
	employee_id INT,
    first_name VARCHAR(50),
    salary INT
);

SELECT	*
FROM temp_high_salary;


-- =========================================================
-- INSERT MANUAL DATA INTO TEMP TABLE
-- =========================================================

INSERT INTO temp_high_salary
VALUES 
	(101, 'Tom', 50000),
	(102, 'Jordan', 75000);

SELECT	*
FROM temp_high_salary;


-- =========================================================
-- TEMP TABLE FOR DEPARTMENT SUMMARY
-- Store aggregated department metrics
-- =========================================================

DROP TEMPORARY TABLE IF EXISTS temp_department_summary;

CREATE TEMPORARY TABLE temp_department_summary (
	department_id INT,
    total_employees INT,
    average_salary DECIMAL(10, 2)
);

SELECT	*
FROM temp_department_summary;


-- =========================================================
-- INSERT AGGREGATED DATA INTO TEMP TABLE
-- =========================================================

INSERT INTO temp_department_summary
	SELECT	dept_id,
			COUNT(employee_id),
            ROUND(AVG(salary), 2)
	FROM employee_salary
    GROUP BY dept_id;

SELECT	*
FROM temp_department_summary;


-- =========================================================
-- TEMP TABLE FOR SALARY CATEGORY SUMMARY
-- Store grouped salary category analytics
-- =========================================================

DROP TEMPORARY TABLE IF EXISTS temp_salary_category_summary;

CREATE TEMPORARY TABLE temp_salary_category_summary (
	`Salary Category` VARCHAR(50),
    `Total Employees` INT,
    `Average Salary` DECIMAL (10, 2),
    `Highest Salary` INT
);


-- =========================================================
-- INSERT GROUPED SALARY ANALYTICS
-- =========================================================

INSERT INTO temp_salary_category_summary 
	SELECT
		CASE
			WHEN salary >= 70000 THEN 'High Salary'
            WHEN salary >= 50000 AND salary <= 69999 THEN 'Medium Salary'
            WHEN salary < 50000 THEN 'Low Salary'
        END AS 'Salary Category',
        COUNT(employee_id) AS 'Total Employees',
        ROUND(AVG(salary), 2) AS 'Average Salary',
        MAX(salary) AS 'Highest Salary'
    FROM employee_salary
    GROUP BY `Salary Category`
    ORDER BY `Average Salary` DESC;

SELECT	*
FROM temp_salary_category_summary;