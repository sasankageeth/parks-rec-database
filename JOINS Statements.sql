-- =========================================================
-- SQL PRACTICE - JOINS
-- =========================================================

-- Show all databases
SHOW DATABASES;

-- Select the Parks_and_Recreation database
USE `Parks_and_Recreation`;


-- =========================================================
-- VIEW TABLES
-- =========================================================

-- View employee demographics data
SELECT * 
FROM employee_demographics;

-- View employee salary data
SELECT * 
FROM employee_salary;

-- View department data
SELECT * 
FROM parks_departments;


-- =========================================================
-- INNER JOIN
-- Join employee_salary and employee_demographics
-- Match employees using employee_id
-- =========================================================

SELECT sal.employee_id,
       sal.first_name,
       sal.last_name,
       sal.occupation,
       sal.salary
FROM employee_salary AS sal
INNER JOIN employee_demographics AS dem
    ON sal.employee_id = dem.employee_id;


-- =========================================================
-- INNER JOIN
-- Join employee_salary and parks_departments
-- Match dept_id with department_id
-- Show employee salary information with department name
-- =========================================================

SELECT sal.first_name,
       occupation,
       salary,
       department_name
FROM employee_salary AS sal
INNER JOIN parks_departments AS pd
    ON pd.department_id = sal.dept_id;


-- =========================================================
-- INNER JOIN + WHERE + ORDER BY
-- Show employees earning more than 60000
-- Include their department name
-- Sort by salary from highest to lowest
-- =========================================================

SELECT sal.first_name,
       last_name,
       occupation,
       salary,
       pd.department_name
FROM employee_salary AS sal
INNER JOIN parks_departments AS pd
    ON pd.department_id = sal.dept_id
WHERE salary > 60000 
ORDER BY salary DESC;


-- =========================================================
-- LEFT OUTER JOIN
-- Show all employees from employee_demographics
-- Include salary information if available
-- If salary data is missing, salary columns will show NULL
-- =========================================================

SELECT dem.first_name,
       dem.last_name,
       gender,
       occupation,
       salary
FROM employee_demographics AS dem
LEFT OUTER JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id
ORDER BY dem.employee_id;


-- =========================================================
-- LEFT OUTER JOIN
-- Show all departments from parks_departments
-- Include employee details if employees belong to that department
-- If no employees belong to a department, employee columns will show NULL
-- =========================================================

SELECT pd.department_name,
       sal.first_name,
       sal.occupation,
       sal.salary
FROM parks_departments AS pd
LEFT OUTER JOIN employee_salary AS sal
    ON pd.department_id = sal.dept_id
ORDER BY department_name;


-- =========================================================
-- SELF JOIN
-- Join employee_salary table with itself
-- Create employee pairings
-- Exclude matching employees with themselves
-- =========================================================

SELECT sal1.employee_id,
       sal1.first_name,
       sal1.last_name,
       sal2.employee_id,
       sal2.first_name,
       sal2.last_name
FROM employee_salary AS sal1
JOIN employee_salary AS sal2
    ON sal1.employee_id != sal2.employee_id;
    
    
    
    
-- =========================================================
-- QUESTION
-- Show each department name along with:
-- total employees in that department
-- average salary in that department
-- Only include departments where average salary is greater than 50000
-- Sort results by average salary in descending order
-- =========================================================

SELECT pd.department_name,
       COUNT(sal.employee_id) AS total_employees,
       AVG(sal.salary) AS avg_salary
FROM parks_departments AS pd
LEFT OUTER JOIN employee_salary AS sal
    ON pd.department_id = sal.dept_id
GROUP BY pd.department_name
HAVING avg_salary > 50000
ORDER BY avg_salary DESC;