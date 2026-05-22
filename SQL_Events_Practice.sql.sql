-- =========================================================
-- SQL PRACTICE - EVENTS
-- =========================================================

SHOW DATABASES;

USE `Parks_and_Recreation`;


-- =========================================================
-- VIEW TABLE
-- =========================================================

SELECT * 
FROM employee_demographics;


-- =========================================================
-- EVENT 1: BASIC EVENT LOG
-- Inserts current timestamp into event_log every 30 seconds
-- =========================================================

DROP TABLE IF EXISTS event_log;

CREATE TABLE event_log (
	time_stamp DATETIME
);

SET GLOBAL event_scheduler = ON;

DROP EVENT IF EXISTS delete_old_people;

CREATE EVENT delete_old_people
ON SCHEDULE EVERY 30 SECOND
DO
	INSERT INTO event_log 
	VALUES (
		NOW()
	);

SELECT * 
FROM event_log;


-- =========================================================
-- EVENT 2: COPY LOW SALARY EMPLOYEES
-- Copies employees with salary <= 30000 into sal_below_30000
-- INSERT IGNORE prevents duplicate employee_id records
-- =========================================================

DROP TABLE IF EXISTS sal_below_30000;

CREATE TABLE sal_below_30000 (
	employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    occupation VARCHAR(1000),
    salary INT,
    dept_id INT
);

DROP EVENT IF EXISTS drop_emp_below_30000;

CREATE EVENT drop_emp_below_30000
ON SCHEDULE EVERY 10 SECOND
DO
	INSERT IGNORE INTO sal_below_30000
    SELECT *
    FROM employee_salary
    WHERE salary <= 30000;
        
SELECT * 
FROM sal_below_30000;


-- =========================================================
-- EVENT 3: ARCHIVE AND DELETE LOW SALARY EMPLOYEES
-- Copies low salary employees into archive table first
-- Then deletes them from employee_salary
-- =========================================================

DROP TABLE IF EXISTS low_salary_archive;

CREATE TABLE low_salary_archive (
	employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    occupation VARCHAR(1000),
    salary INT,
    dept_id INT
);

DROP EVENT IF EXISTS archive_low_salary_employees;

DELIMITER $$

CREATE EVENT archive_low_salary_employees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	INSERT IGNORE INTO low_salary_archive
	SELECT *
	FROM employee_salary
	WHERE salary <= 30000;
			
    DELETE 
	FROM employee_salary
	WHERE salary <= 30000;
END $$

DELIMITER ;	

SELECT * 
FROM low_salary_archive;

SELECT * 
FROM employee_salary;


-- =========================================================
-- EVENT 4: ARCHIVE, DELETE, AND LOG CLEANUP
-- Archives low salary employees
-- Deletes them from employee_salary
-- Logs cleanup timestamp into cleanup_log
-- =========================================================

DROP TABLE IF EXISTS cleanup_log;

CREATE TABLE cleanup_log (
	cleanup_time DATETIME
);

DROP TABLE IF EXISTS archive_log;

CREATE TABLE archive_log (
	employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    occupation VARCHAR(1000),
    salary INT,
    dept_id INT
);

DROP EVENT IF EXISTS archive_and_log_cleanup;

DELIMITER $$

CREATE EVENT archive_and_log_cleanup
ON SCHEDULE EVERY 1 MINUTE
DO
BEGIN
	INSERT IGNORE INTO archive_log
    SELECT *
    FROM EMPLOYEE_SALARY
    WHERE SALARY <= 30000;
        
    DELETE
    FROM EMPLOYEE_SALARY
    WHERE salary <= 30000;
        
    INSERT INTO cleanup_log
    VALUES (
		NOW()
    );
END $$

DELIMITER ;

SELECT * 
FROM archive_log;

SELECT * 
FROM EMPLOYEE_SALARY;

SELECT * 
FROM cleanup_log;