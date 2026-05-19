-- =========================================================
-- SQL PRACTICE - WINDOW FUNCTIONS
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
-- WINDOW FUNCTION: AVG() OVER()
-- Show company average salary beside each employee
-- Does not collapse rows
-- =========================================================

SELECT * 
FROM employee_salary;

SELECT	first_name AS 'First Name',
		last_name AS 'Last Name',
        salary AS 'Salary',
        ROUND(AVG(salary) OVER(), 2) AS 'Average Salary' 
FROM employee_salary;


-- =========================================================
-- WINDOW FUNCTION: AVG() OVER(PARTITION BY)
-- Show department average salary beside each employee
-- PARTITION BY calculates average separately per department
-- =========================================================

SELECT * 
FROM employee_salary;

SELECT	first_name AS 'First Name',
		last_name AS 'Last Name',
        dept_id AS 'Department ID',
        salary AS 'Salary',
        ROUND(AVG(salary) OVER(PARTITION BY dept_id), 2) AS 'Average Department Salary'
FROM employee_salary;


-- =========================================================
-- WINDOW FUNCTION: ROW_NUMBER()
-- Assigns a unique row number within each department
-- Highest salary gets row number 1
-- =========================================================

SELECT	first_name AS 'First Name',
		last_name AS 'Last Name',
        dept_id AS 'Department ID',
        salary AS 'Salary',
        ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS 'Row Number'
FROM employee_salary; 


-- =========================================================
-- WINDOW FUNCTION: RANK()
-- Ranks salary within each department
-- Same salary gets the same rank
-- Rank numbers can skip after ties
-- =========================================================

SELECT	first_name AS 'First Name',
		last_name AS 'Last Name',
        dept_id AS 'Department ID',
        salary AS 'Salary',
        RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS 'Rank Number'
FROM employee_salary; 


-- =========================================================
-- WINDOW FUNCTION: DENSE_RANK()
-- Ranks salary within each department
-- Same salary gets the same rank
-- Rank numbers do NOT skip after ties
-- =========================================================

SELECT	first_name AS 'First Name',
		last_name AS 'Last Name',
        dept_id AS 'Department ID',
        salary AS 'Salary',
        DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS 'Dense Rank Numeber'
FROM employee_salary;


-- =========================================================
-- WINDOW FUNCTION: SUM() OVER()
-- Show total salary of all employees beside each row
-- Does not collapse rows
-- =========================================================

SELECT	employee_id AS 'Employee ID',
		first_name AS 'First Name',
        salary AS 'Salary',
        SUM(salary) OVER() AS 'Employees Total Salary '
FROM employee_salary;


-- =========================================================
-- WINDOW FUNCTION: RUNNING TOTAL
-- Running total follows employee_id order
-- Adds salary row by row
-- =========================================================

SELECT	employee_id AS 'Employee ID',
		first_name AS 'First Name',
        salary AS 'Salary',
        SUM(salary) OVER(ORDER BY employee_id) AS 'Running Total Salary'
FROM employee_salary;