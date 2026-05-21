-- =========================================================
-- SQL PRACTICE - TRIGGERS
-- =========================================================

SHOW DATABASES;

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
-- TRIGGER 1: BASIC AFTER INSERT AUDIT
-- Logs employee_id and timestamp after new salary record insert
-- =========================================================

DROP TABLE IF EXISTS employee_salary_audit;

CREATE TABLE employee_salary_audit (
	`Employee ID` INT,
    `Action Time` DATETIME
);

DROP TRIGGER IF EXISTS employee_sal_trigger;

DELIMITER $$

CREATE TRIGGER employee_sal_trigger
AFTER INSERT 
ON employee_salary
FOR EACH ROW
BEGIN 
	INSERT INTO employee_salary_audit
    VALUES (
		NEW.employee_id,
        NOW()
    );
END $$

DELIMITER ;

INSERT INTO employee_salary
VALUES (99, 'Aex', 'gan', 'Analystics', 700000, 2);

INSERT INTO employee_salary
VALUES (999, 'Alex', 'Morgan', 'Analyst', 70000, 1);

SELECT *
FROM employee_salary_audit;


-- =========================================================
-- TRIGGER 2: DETAILED AFTER INSERT AUDIT
-- Logs employee_id, first_name, salary, and timestamp
-- =========================================================

DROP TABLE IF EXISTS employee_detailed_audit;

CREATE TABLE employee_detailed_audit (
	`Employee ID` INT,
    `First Name` VARCHAR(50),
    `Salary` INT,
    `Action Time` DATETIME
);

DROP TRIGGER IF EXISTS employee_insert_audit_trigger;

DELIMITER $$

CREATE TRIGGER employee_insert_audit_trigger
AFTER INSERT 
ON employee_salary
FOR EACH ROW
BEGIN 
	INSERT INTO employee_detailed_audit
	VALUES (
		NEW.employee_id,
        NEW.first_name,
        NEW.salary,
        NOW()
    );
END $$

DELIMITER ;

INSERT INTO employee_salary
VALUES (1001, 'Sarah', 'Johnson', 'Data Analyst', 72000, 2);

SELECT *
FROM employee_detailed_audit;


-- =========================================================
-- TRIGGER 3: BEFORE INSERT SALARY CHECK
-- If salary is less than or equal to 0, set it to 0
-- =========================================================

DROP TRIGGER IF EXISTS salary_check;

DELIMITER $$

CREATE TRIGGER salary_check
BEFORE INSERT 
ON employee_salary
FOR EACH ROW
BEGIN
	IF NEW.salary <= 0 THEN 
		SET NEW.salary = 0;
	END IF;
END $$

DELIMITER ;

INSERT INTO employee_salary 
VALUES (1002, 'Mike', 'Taylor', 'Engineer', -5000, 1);

SELECT * 
FROM employee_salary 
WHERE employee_id = 1002;


-- =========================================================
-- CREATE LOG TABLES FOR PRACTICE TRIGGERS
-- =========================================================

DROP TABLE IF EXISTS employee_insert_log;
CREATE TABLE employee_insert_log (
	`Employee ID` INT,
    `Department ID` INT,
    `Current Timestamp` DATETIME
);

DROP TABLE IF EXISTS employee_salary_history;
CREATE TABLE employee_salary_history (
	`Employee ID` INT,
    `Old Salary` INT,
    `New Salary` INT,
    `Update Timestamp` DATETIME
);


-- =========================================================
-- TRIGGER 4: AFTER INSERT LOG
-- Logs employee_id, dept_id, and timestamp after insert
-- =========================================================

DROP TRIGGER IF EXISTS employee_insert_log_trigger;

DELIMITER $$

CREATE TRIGGER employee_insert_log_trigger
AFTER INSERT 
ON employee_salary
FOR EACH ROW
BEGIN
	INSERT INTO employee_insert_log 
	VALUES (
		NEW.employee_id,
		NEW.dept_id,
		NOW()
	);
END $$

DELIMITER ;


-- =========================================================
-- TRIGGER 5: BEFORE INSERT DATA VALIDATION
-- Handles NULL salary, negative salary, missing first_name, missing dept_id
-- =========================================================

DROP TRIGGER IF EXISTS salary_NULL_and_data_validation_checkker;

DELIMITER $$

CREATE TRIGGER salary_NULL_and_data_validation_checkker
BEFORE INSERT
ON employee_salary
FOR EACH ROW
BEGIN
	IF NEW.salary IS NULL THEN
		SET NEW.salary = 30000;
    END IF;

    IF NEW.salary < 0 THEN
		SET NEW.salary = 0;
    END IF;

    IF NEW.first_name IS NULL THEN
		SET NEW.first_name = 'Unknown';
	END IF;

    IF NEW.dept_id IS NULL THEN
		SET NEW.dept_id = 99;
	END IF;
END $$

DELIMITER ;


-- =========================================================
-- TRIGGER 6: BEFORE UPDATE SALARY VALIDATION
-- Prevents salary from being updated to 0 or negative
-- =========================================================

DROP TRIGGER IF EXISTS prevent_negative_salary_update;

DELIMITER $$

CREATE TRIGGER prevent_negative_salary_update
BEFORE UPDATE
ON employee_salary
FOR EACH ROW
BEGIN
	IF NEW.salary <= 0 THEN
		SET NEW.salary = OLD.salary;
    END IF;
END $$

DELIMITER ;


-- =========================================================
-- TRIGGER 7: AFTER UPDATE SALARY HISTORY
-- Logs old salary, new salary, and update timestamp
-- =========================================================

DROP TRIGGER IF EXISTS salary_update_trigger;

DELIMITER $$

CREATE TRIGGER salary_update_trigger
AFTER UPDATE 
ON employee_salary
FOR EACH ROW
BEGIN
	INSERT INTO employee_salary_history
    VALUES (
		NEW.employee_id,
        OLD.salary,
        NEW.salary,
        NOW()
    );
END $$

DELIMITER ;