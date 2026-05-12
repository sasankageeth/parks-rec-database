-- =========================================================
-- SQL PRACTICE - GROUP BY & ORDER BY
-- =========================================================


-- =========================================================
-- QUESTION 1
-- Show all databases available in MySQL
-- =========================================================

SHOW DATABASES;


-- =========================================================
-- QUESTION 2
-- Select the Parks_and_Recreation database
-- =========================================================

USE `Parks_and_Recreation`;


-- =========================================================
-- QUESTION 3
-- Display all rows and columns from employee_demographics
-- =========================================================

SELECT *
FROM employee_demographics;


-- =========================================================
-- QUESTION 4
-- Write a query to display:
-- gender
-- average age of each gender
-- from employee_demographics
-- =========================================================

SELECT gender,
AVG(age)
FROM employee_demographics
GROUP BY gender;


-- =========================================================
-- QUESTION 5
-- Write a query to display all rows from:
-- employee_demographics
-- ordered by age in descending order
-- =========================================================

SELECT *
FROM employee_demographics
ORDER BY age DESC;


-- =========================================================
-- QUESTION 6
-- Write a query to display:
-- gender
-- minimum age
-- maximum age
-- count of age
-- from employee_demographics
-- Group the results by gender
-- =========================================================

SELECT gender, 
MIN(age), 
MAX(age),
COUNT(age)
FROM employee_demographics
GROUP BY gender;


-- =========================================================
-- QUESTION 7
-- Write a query to display all rows from:
-- employee_demographics
--
-- Order by:
-- gender in ascending order
-- age in descending order
-- =========================================================

SELECT * 
FROM employee_demographics
ORDER BY gender, age DESC;


-- =========================================================
-- QUESTION 8
-- Write a query to display:
-- occupation
-- salary
--
-- From:
-- employee_salary
--
-- Group by:
-- occupation
-- salary
-- =========================================================

SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary;


-- =========================================================
-- QUESTION 9
-- Write a query to display:
-- gender
-- average age as avg_age
--
-- From:
-- employee_demographics
--
-- Only include employees:
-- whose first_name starts with 'A'
--
-- Group by:
-- gender
--
-- Sort by:
-- avg_age descending
-- =========================================================

SELECT gender, 
AVG(age) AS avg_age
FROM employee_demographics
WHERE first_name LIKE 'A%'
GROUP BY gender
ORDER BY avg_age DESC;


-- =========================================================
-- QUESTION 10
-- Write a query to display:
-- gender
-- minimum age as youngest
-- maximum age as oldest
-- average age as avg_age
-- count of employees as total_people
--
-- From:
-- employee_demographics
--
-- Only include employees:
-- born after '1985-01-01'
--
-- Group by:
-- gender
--
-- Sort by:
-- avg_age descending
-- =========================================================

SELECT gender,
MIN(age) AS youngest,
MAX(age) AS oldest,
AVG(age) AS avg_age,
COUNT(employee_id) AS total_people
FROM employee_demographics
WHERE birth_date > '1985-01-01'
GROUP BY gender
ORDER BY avg_age DESC;


-- =========================================================
-- QUESTION 11
-- Display all rows from employee_salary
-- =========================================================

SELECT *
FROM employee_salary;


-- =========================================================
-- QUESTION 12
-- Write a query to display:
-- occupation
-- average salary as avg_salary
-- highest salary as highest_salary
--
-- From:
-- employee_salary
--
-- Only include employees:
-- whose occupation starts with 'S'
-- and salary is greater than 50000
--
-- Group by:
-- occupation
--
-- Sort by:
-- highest_salary descending
-- =========================================================

SELECT occupation,
AVG(salary) AS avg_salary,
MAX(salary) AS highest_salary
FROM employee_salary
WHERE occupation LIKE 'S%' 
AND salary > 50000
GROUP BY occupation
ORDER BY highest_salary DESC;


-- =========================================================
-- QUESTION 13
-- Write a query to display:
-- gender
-- count of employees as total_people
-- average age as avg_age
--
-- From:
-- employee_demographics
--
-- Only include employees:
-- whose first_name starts with 'J'
-- and age is greater than 30
--
-- Group by:
-- gender
--
-- Sort by:
-- total_people descending
-- =========================================================

SELECT gender,
COUNT(employee_id) AS total_people,
AVG(age) AS avg_age
FROM employee_demographics
WHERE first_name LIKE 'J%' 
AND age > 30
GROUP BY gender
ORDER BY total_people DESC;