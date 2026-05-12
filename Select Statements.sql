-- =========================================================
-- SQL PRACTICE - SELECT STATEMENTS
-- =========================================================


-- =========================================================
-- QUESTION 1
-- Show all databases available in MySQL
-- =========================================================

SHOW DATABASES;


-- =========================================================
-- QUESTION 2
-- Select the Parks_and_Recreation database to work in
-- =========================================================

USE Parks_and_Recreation;


-- =========================================================
-- QUESTION 3
-- Display all columns and rows from the employee_salary table
-- =========================================================

SELECT * 
FROM employee_salary;


-- =========================================================
-- QUESTION 4
-- Display only:
-- first_name
-- age
--
-- From:
-- employee_demographics
-- =========================================================

SELECT first_name, 
age 
FROM employee_demographics;


-- =========================================================
-- QUESTION 5
-- Display:
-- last_name
-- salary
-- salary multiplied by 2
--
-- Use an alias called new_sal
-- =========================================================

SELECT last_name, 
salary, 
salary * 2 AS new_sal
FROM employee_salary;


-- =========================================================
-- QUESTION 6
-- Display only unique department IDs
-- from employee_salary
--
-- DISTINCT removes duplicate values
-- =========================================================

SELECT DISTINCT department_id
FROM employee_salary;


-- =========================================================
-- QUESTION 7
-- Display:
-- first_name
-- salary
-- a calculated column:
-- (salary + 100) * 10
--
-- Parentheses run first because of PEMDAS/BODMAS
-- =========================================================

SELECT first_name,
salary,
(salary + 100) * 10
FROM employee_salary;


-- =========================================================
-- QUESTION 8
-- Display all columns from employee_demographics
--
-- * means select everything
-- =========================================================

SELECT * 
FROM employee_demographics;
 

-- =========================================================
-- QUESTION 9
-- Display:
-- first_name
-- last_name
-- salary
-- salary after adding 500
--
-- Use an alias called new_sal
-- =========================================================

SELECT first_name,
last_name,
salary,
salary + 500 AS new_sal
FROM employee_salary;


-- =========================================================
-- QUESTION 10
-- Display:
-- first_name
-- salary
-- a calculated column:
-- salary + 100 * 10
--
-- Multiplication happens before addition
-- because there are no parentheses
-- =========================================================

SELECT first_name,
salary,
salary + 100 * 10 AS new_sal
FROM employee_salary;


-- =========================================================
-- QUESTION 11
-- Display:
-- first_name
-- last_name
-- salary
-- salary multiplied by 5
--
-- Use an alias called bonus_salary
-- =========================================================

SELECT first_name,
last_name,
salary,
salary * 5 AS bonus_salary
FROM employee_salary;


-- =========================================================
-- QUESTION 12
-- Display:
-- first_name
-- last_name
-- salary
-- annual_bonus
--
-- Formula:
-- (salary + 200) * 12
-- =========================================================

SELECT first_name,
last_name,
salary,
(salary + 200) * 12 AS annual_bonus
FROM employee_salary;