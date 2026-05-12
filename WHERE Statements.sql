-- Show all databases available in MySQL
SHOW DATABASES;


-- Select the Parks_and_Recreation database to work in
USE Parks_and_Recreation;


-- Display all employees from employee_salary
-- where salary is greater than 60000
SELECT * 
FROM employee_salary
WHERE salary > 60000;


-- Display all rows from employee_demographics
-- where gender is NOT 'Male'
-- != means not equal to
SELECT * 
FROM employee_demographics
WHERE gender != 'Male';


-- Display all employees born after 1990-01-01
-- from employee_demographics
SELECT * 
FROM employee_demographics
WHERE birth_date > '1990-01-01';


-- Display employees whose first_name starts with 'J'
-- % means anything after J
SELECT first_name
FROM employee_demographics
WHERE first_name LIKE 'J%';


-- Display employees whose first_name:
-- starts with 'a'
-- and has exactly 3 characters total
-- each _ represents one character
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__';


-- Display all rows where first_name:
-- starts with 'A'
-- and has exactly 4 characters total
SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'A___';


-- Display all employees where first_name:
-- starts with 'A'
-- and has more than 5 characters
-- % means any number of characters after that
SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'A____%';


-- Display all female employees
-- born after 1988-01-01
-- AND is used to combine multiple conditions
SELECT * 
FROM employee_demographics
WHERE gender = 'Female' 
AND birth_date > '1988-01-01';