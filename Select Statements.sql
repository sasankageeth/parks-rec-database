-- Show all databases available in MySQL
SHOW DATABASES;

-- Select the Parks_and_Recreation database to work in
USE Parks_and_Recreation;

-- Display all columns and rows from the employee_salary table
SELECT * 
FROM employee_salary;


-- Display only first_name and age from employee_demographics
SELECT first_name, 
age 
FROM employee_demographics;


-- Display last_name, salary, and salary multiplied by 2
-- AS is used to create an alias called new_sal
SELECT last_name, 
salary, 
salary * 2 AS new_sal
FROM employee_salary;


-- Display only unique department IDs from employee_salary
-- DISTINCT removes duplicate values
SELECT DISTINCT department_id
FROM employee_salary;


-- Display first_name, salary, and a calculated column
-- Parentheses run first because of PEMDAS/BODMAS
SELECT first_name,
salary,
(salary + 100) * 10
FROM employee_salary;


-- Display all columns from employee_demographics
-- * means select everything
SELECT * 
FROM employee_demographics;
 

-- Display first_name, last_name, salary,
-- and salary after adding 500
SELECT first_name,
last_name,
salary,
salary + 500 AS new_sal
FROM employee_salary;


-- Multiplication happens before addition here
-- because there are no parentheses
SELECT first_name,
salary,
salary + 100 * 10 AS new_sal
FROM employee_salary;


-- Display first_name, last_name, salary,
-- and salary multiplied by 5
SELECT first_name,
last_name,
salary,
salary * 5 AS bonus_salary
FROM employee_salary;


-- Display first_name, last_name, salary,
-- and calculate annual_bonus
-- Formula: (salary + 200) * 12
SELECT first_name,
last_name,
salary,
(salary + 200) * 12 AS annual_bonus
FROM employee_salary;
