-- Show all databases available in MySQL
SHOW DATABASES;

-- Select the Parks_and_Recreation database to work in
USE Parks_and_Recreation;

-- Write a query to display all employees from employee_salary where salary is greater than 60000
SELECT * 
FROM employee_salary
WHERE salary > 60000;

-- Write a query to display all rows from employee_demographics where gender is NOT 'Male'
SELECT * 
FROM employee_demographics
WHERE gender != 'Male';

-- Write a query to display all employees born after 1990-01-01 from employee_demographics
SELECT * 
FROM employee_demographics
WHERE birth_date > '1990-01-01';

-- Write a query to display employees whose first_name starts with 'J' from employee_demographics
SELECT first_name
FROM  employee_demographics
WHERE first_name LIKE 'J%';

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__';

-- Write a query to display all rows from: employee_demographics where first_name starts with 'A' and has exactly 4 characters total, Use LIKE.
SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'A___';

-- Write a query to display all employees where: first_name starts with 'A' and has more than 5 characters From employee_demographics
SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'A____%';

-- Write a query to display all rows from: employee_demographics where gender is 'Female' AND birth_date is after '1988-01-01'
SELECT * 
FROM employee_demographics
WHERE gender = 'Female' AND birth_date > '1988-01-01';