-- =========================================================
-- SQL PRACTICE - HAVING, GROUP BY, ORDER BY, WINDOW FUNCTIONS
-- =========================================================

-- Show all databases
SHOW DATABASES;

-- Select the database
USE `Parks_and_Recreation`;

-- View employee demographics table
SELECT * 
FROM employee_demographics;


-- =========================================================
-- QUESTION 1
-- Display first_name, gender, and average age
-- Grouped by first_name and gender
-- Only show groups where average age is greater than 40
-- =========================================================

SELECT first_name,
       gender,
       AVG(age) AS avg_age
FROM employee_demographics
GROUP BY first_name, gender
HAVING avg_age > 40;


-- =========================================================
-- QUESTION 2
-- Display gender, total people, and average age
-- Only include employees older than 25
-- Group by gender
-- Only show groups where total_people > 2
-- Sort by avg_age descending
-- =========================================================

SELECT gender,
       COUNT(employee_id) AS total_people,
       AVG(age) AS avg_age
FROM employee_demographics
WHERE age > 25
GROUP BY gender
HAVING total_people > 2
ORDER BY avg_age DESC;


-- =========================================================
-- QUESTION 3
-- Display occupation, average salary, minimum salary, and maximum salary
-- Only include occupations starting with 'M'
-- Only include salaries greater than 40000
-- Group by occupation
-- Only show groups where avg_salary > 60000
-- Sort by max_salary descending
-- =========================================================

SELECT occupation,
       AVG(salary) AS avg_salary,
       MIN(salary) AS min_salary,
       MAX(salary) AS max_salary
FROM employee_salary
WHERE occupation LIKE 'M%' 
AND salary > 40000
GROUP BY occupation
HAVING avg_salary > 60000
ORDER BY max_salary DESC;


-- =========================================================
-- SITUATIONAL QUESTION 1
-- Find gender and age groups with more than 3 employees above age 30
-- Show average age and employee count
-- Sort by avg_age descending
-- =========================================================

SELECT gender,
       age,
       AVG(age) AS avg_age,
       COUNT(employee_id) AS emp_count
FROM employee_demographics
WHERE age > 30
GROUP BY gender, age
HAVING emp_count > 3
ORDER BY avg_age DESC;


-- =========================================================
-- SITUATIONAL QUESTION 2
-- Find occupations where average salary is above 70000
-- Only consider employees making more than 50000
-- Show highest salary in each occupation
-- Sort by max_salary descending
-- =========================================================

SELECT * 
FROM employee_salary;

SELECT occupation,
       AVG(salary) AS avg_salary,
       MAX(salary) AS max_salary
FROM employee_salary
WHERE salary > 50000
GROUP BY occupation
HAVING avg_salary > 70000
ORDER BY max_salary DESC;


-- =========================================================
-- SITUATIONAL QUESTION 3
-- Look at employees whose first_name starts with 'A'
-- Show gender groups where avg_age > 35
-- Show total employees in each group
-- Sort by total_emp
-- =========================================================

SELECT * 
FROM employee_demographics;

SELECT gender,
       AVG(age) AS avg_age,
       COUNT(employee_id) AS total_emp
FROM employee_demographics
WHERE first_name LIKE 'A%' 
GROUP BY gender
HAVING avg_age > 35
ORDER BY total_emp;


-- =========================================================
-- WINDOW FUNCTION PRACTICE
-- Display each person's first_name and age
-- Also show the overall average age beside each row
-- AVG(age) OVER() does not collapse rows like GROUP BY
-- =========================================================

SELECT first_name, 
       age,
       AVG(age) OVER() AS avg_age
FROM employee_demographics
GROUP BY first_name, age;


-- =========================================================
-- SITUATIONAL QUESTION 4
-- Find gender groups with at least 2 employees older than 35
-- Show gender, average age, oldest employee age, and total employees
-- Sort by oldest_emp_age descending
-- =========================================================

SELECT * 
FROM employee_demographics;

SELECT gender,
       AVG(age) AS avg_age,
       MAX(age) AS oldest_emp_age,
       COUNT(employee_id) AS total_employees
FROM employee_demographics
WHERE age >= 35
GROUP BY gender
HAVING total_employees >= 2
ORDER BY oldest_emp_age DESC;


-- =========================================================
-- SITUATIONAL QUESTION 5
-- Identify occupations where employees earn more than 45000
-- Show average, lowest, highest salary, and total employees
-- Only include occupations with at least 2 employees
-- Sort by average_salary descending
-- =========================================================

SELECT * 
FROM employee_salary;

SELECT occupation,
       AVG(salary) AS average_salary,
       MIN(salary) AS lowest_salary,
       MAX(salary) AS highest_salary,
       COUNT(employee_id) AS total_employees
FROM employee_salary
WHERE salary > 45000
GROUP BY occupation
HAVING average_salary > 45000 
AND total_employees >= 2
ORDER BY average_salary DESC;