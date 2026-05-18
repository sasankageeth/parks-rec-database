-- =========================================================
-- SQL ANALYTICAL QUERIES PRACTICE
-- CASE STATEMENTS, GROUP BY, HAVING, JOINS
-- =========================================================


-- =========================================================
-- SHOW DATABASES
-- =========================================================

SHOW DATABASES;


-- =========================================================
-- USE DATABASE
-- =========================================================

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
-- CASE STATEMENT
-- Categorize employees based on salary
-- =========================================================

SELECT	first_name AS 'First Name',
		last_name AS 'Last Name',
		salary AS 'Salary',
        CASE
			WHEN salary >= 70000 THEN 'High Salary'
            WHEN salary <= 69999 AND salary >= 50000 THEN 'Medium Salary'
            ELSE 'Low Salary'
		END AS 'Salary Level'
FROM employee_salary;


-- =========================================================
-- CASE STATEMENT WITH CALCULATIONS
-- Calculate employee bonus based on salary
-- =========================================================

SELECT	first_name AS 'First Name',
		salary AS 'Salary',
        CASE
			WHEN salary >= 70000 THEN salary * 0.15
            WHEN salary <= 69999 AND salary >= 50000 THEN salary * 0.10
            ELSE salary * 0.05
		END AS 'Bonus'
FROM employee_salary;


-- =========================================================
-- CASE + GROUP BY
-- Group employees into salary categories
-- Show total employees and average salary
-- =========================================================

SELECT	
	CASE
		WHEN salary >= 70000 THEN 'High Salary'
        WHEN salary <= 69999 AND salary >= 50000 THEN 'Medium Salary'
        ELSE 'Low Salary'
	END AS salary_category,
    COUNT(employee_id) AS 'Total Employees',
    AVG(salary) AS avg_salary
FROM employee_salary
GROUP BY salary_category
ORDER BY avg_salary DESC;
    
    
-- =========================================================
-- CASE + GROUP BY
-- Group employees into age categories
-- Show total employees and average age
-- =========================================================

SELECT
	CASE
		WHEN age > 50 THEN 'Senior'
        WHEN age >= 35 AND age <= 50 THEN 'Mid Age'
        WHEN age < 35 THEN 'Young'
    END AS age_category,
    COUNT(employee_id) AS 'Total Employees',
    AVG(age) AS avg_age
FROM employee_demographics
GROUP BY age_category
ORDER BY avg_age DESC;
    
    
-- =========================================================
-- CASE + GROUP BY + WHERE
-- Group employees into salary categories
-- Exclude employees with NULL department IDs
-- =========================================================

SELECT
	CASE
		WHEN salary > 80000 THEN 'Executive'
        WHEN salary >= 50000 AND salary <= 79999 THEN 'Professional'
        ELSE 'Entry Level' 
    END AS 'Salary Category',
    
    COUNT(employee_id) AS 'Total Employees',
    MAX(salary) AS 'Highest salary',
    AVG(salary) AS 'Avgerage salary'
    
FROM employee_salary
WHERE dept_id IS NOT NULL
GROUP BY `Salary Category`
ORDER BY `Avgerage salary` DESC;
    
    
-- =========================================================
-- CASE + GROUP BY + HAVING
-- Group employees into age categories
-- Only include groups where average age > 35
-- =========================================================

SELECT
	CASE
		WHEN age < 30 THEN 'Young Adult'
        WHEN age >= 30 AND age <= 50 THEN 'Adult' 
        WHEN age > 50 THEN 'Senior'
    END AS 'Age Category',

    COUNT(employee_id) AS 'Total Employees',
    AVG(age) AS 'Average Age',
    MAX(age) AS 'Oldest Age'
FROM employee_demographics
GROUP BY `Age Category`
HAVING `Average Age` > 35
ORDER BY `Oldest Age` DESC;
    
 
 
-- =========================================================
-- CASE + GROUP BY + HAVING + WHERE
-- Group employees into career stages
-- =========================================================
 
SELECT
	CASE
		WHEN age < 35 THEN 'Early Career'
        WHEN age >= 35 AND age <= 50 THEN 'Mid Career'
        WHEN age > 50 THEN 'Senior Career'
    END AS 'Age Band',
    
    COUNT(employee_id) AS 'Total Employees',
    AVG(age) AS 'Average Age',
    MIN(age) AS 'Youngest Employee Age',
    MAX(age) AS 'Oldest Employee Age'
FROM employee_demographics
WHERE gender IS NOT NULL
GROUP BY `Age Band`
HAVING `Total Employees` >= 2 AND `Average Age` > 30
ORDER BY `Oldest Employee Age` DESC;


-- =========================================================
-- VIEW TABLES
-- =========================================================

SELECT * 
FROM employee_salary;

SELECT * 
FROM parks_departments;
    
    
-- =========================================================
-- INNER JOIN + CASE + GROUP BY
-- Department salary analysis
-- =========================================================
    
SELECT pd.department_name AS 'Department Name',
	CASE
		WHEN sal.salary >= 70000 THEN 'High Paid'
        WHEN sal.salary >= 50000 AND sal.salary <= 69999 THEN 'Medium Paid'
        WHEN sal.salary < 50000 THEN 'Low Paid'
    END AS 'Salary Levels',
    COUNT(sal.employee_id) AS 'Total Employees',
    AVG(sal.salary) AS 'Average Salary'
FROM employee_salary AS sal
INNER JOIN parks_departments AS pd
	ON pd.department_id = sal.dept_id
GROUP BY `Salary Levels`, `Department Name`
HAVING `Average Salary` > 40000
ORDER BY `Average Salary` DESC;

    
-- =========================================================
-- VIEW TABLES
-- =========================================================

SELECT * 
FROM employee_salary;

SELECT * 
FROM employee_demographics;   

SELECT * 
FROM parks_departments;   
    
    
-- =========================================================
-- MULTIPLE INNER JOINS + CASE + GROUP BY
-- Demographic and salary analysis
-- =========================================================
    
SELECT	pd.department_name AS 'Department Name',
		dem.gender AS 'Gender',
		CASE
			WHEN dem.age < 35 THEN 'Young'
            WHEN dem.age >= 35 AND dem.age <= 50 THEN 'Experienced'
            WHEN dem.age > 50 THEN 'Senior'
        END AS 'Age Groups',
        COUNT(dem.employee_id) AS 'Total Employees',
        AVG(dem.age) AS 'Average Age',
        AVG(sal.salary) AS 'Average Salary',
        MAX(sal.salary) AS 'Highest Salary'
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments AS pd
	ON pd.department_id = sal.dept_id
GROUP BY `Age Groups`, `Department Name`, `Gender`
HAVING `Total Employees` >= 2
ORDER BY `Average Salary` DESC;
    
    
-- =========================================================
-- VIEW TABLES
-- =========================================================
    
SELECT * 
FROM employee_salary;

SELECT * 
FROM employee_demographics;   

SELECT * 
FROM parks_departments;    

    
-- =========================================================
-- LEFT OUTER JOIN + CASE + GROUP BY
-- Department staffing overview
-- =========================================================
    
SELECT	pd.department_name AS 'Department Name',
		CASE
			WHEN sal.salary >= 80000 THEN 'Executive'
            WHEN sal.salary >= 60000 AND sal.salary <= 79999 THEN 'Management'
            WHEN sal.salary < 60000 THEN 'Staff'
            ELSE 'No Information'
        END AS 'Salary Category',
        COUNT(dem.employee_id) AS 'Total Employees',
        AVG(sal.salary) AS 'Average Salary',
        MIN(dem.age) AS 'Youngest Employee Age'
FROM parks_departments AS pd
LEFT OUTER JOIN employee_salary AS sal
	ON pd.department_id = sal.dept_id
LEFT OUTER JOIN employee_demographics AS dem
	ON sal.employee_id = dem.employee_id
GROUP BY `Department Name`, `Salary Category`
HAVING `Average Salary` > 40000
ORDER BY `Average Salary` DESC;