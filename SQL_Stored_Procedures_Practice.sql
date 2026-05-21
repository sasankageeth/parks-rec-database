-- =========================================================
-- SQL PRACTICE - STORED PROCEDURES
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
-- BASIC STORED PROCEDURE
-- Single-query procedure to show employees earning above 50000
-- =========================================================

CREATE PROCEDURE sal_above_5000() 
SELECT	employee_id AS 'Employee ID',
		first_name AS 'First Name',
        dept_id AS 'Department ID',
        salary AS 'Salary'
FROM employee_salary
WHERE salary > 50000;

CALL sal_above_5000();


-- =========================================================
-- STORED PROCEDURE WITH CASE STATEMENT
-- Categorize employee salaries and show employees with dept_id
-- =========================================================

DROP PROCEDURE IF EXISTS salary_catergory;

DELIMITER $$

CREATE PROCEDURE salary_catergory()
BEGIN
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
    WHERE dept_id IS NOT NULL
    ORDER BY `Salary` DESC;
END $$

DELIMITER ;

CALL salary_catergory();


-- =========================================================
-- STORED PROCEDURE WITH ONE INPUT PARAMETER
-- Show employees from a specific department
-- Input: department ID
-- =========================================================

DROP PROCEDURE IF EXISTS get_department_employees;

DELIMITER $$

CREATE PROCEDURE get_department_employees(IN id INT)
BEGIN
	SELECT	employee_id AS 'Employee ID',
			first_name AS 'First Name',
            last_name AS 'Last Name',
            dept_id AS 'Department ID',
            salary AS 'Salary'
	FROM employee_salary
    WHERE dept_id = id;
END $$

DELIMITER ;

CALL get_department_employees(1);


-- =========================================================
-- STORED PROCEDURE WITH ONE INPUT PARAMETER
-- Show employees earning at least the input salary
-- Input: minimum salary
-- =========================================================

DROP PROCEDURE IF EXISTS get_employees_by_min_salary;

DELIMITER $$

CREATE PROCEDURE get_employees_by_min_salary(IN sal INT)
BEGIN
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
    WHERE salary >= sal
    ORDER BY salary DESC;
END $$

DELIMITER ;

CALL get_employees_by_min_salary(60000);


-- =========================================================
-- STORED PROCEDURE WITH MULTIPLE INPUT PARAMETERS
-- Show employees by minimum salary and department ID
-- Inputs:
-- 1. minimum salary
-- 2. department ID
-- =========================================================

DROP PROCEDURE IF EXISTS get_department_salary_filter;

DELIMITER $$

CREATE PROCEDURE get_department_salary_filter(IN input_sal INT, IN input_id INT)
BEGIN
	SELECT	employee_id AS 'Employee ID',
			first_name AS 'First Name',
            last_name AS 'Last Name',
            dept_id AS 'Department ID',
            salary AS 'Salary'
	FROM employee_salary
    WHERE salary >= input_sal AND dept_id = input_id
    ORDER BY salary DESC;
END $$

DELIMITER ;

CALL get_department_salary_filter(60000, 1);
CALL get_department_salary_filter(40000, 2);


-- =========================================================
-- STORED PROCEDURE WITH MULTIPLE SELECT QUERIES
-- Returns multiple result sets:
-- 1. all employee salary records
-- 2. average company salary
-- 3. highest company salary
-- =========================================================

DROP PROCEDURE IF EXISTS company_salary_analysis;

DELIMITER $$

CREATE PROCEDURE company_salary_analysis()
BEGIN
	SELECT	*
	FROM employee_salary;
    
    SELECT ROUND(AVG(salary), 2) AS 'Average Company Salary'
    FROM employee_salary;
    
    SELECT MAX(salary) AS 'Highest Company Salary' 
    FROM employee_salary;
END $$

DELIMITER ;

CALL company_salary_analysis();