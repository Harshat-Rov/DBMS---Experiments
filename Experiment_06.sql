-- Experiment 6: Stored Procedures, Triggers, and Validation
-- Aim: To create a stored procedure transfer_employee(emp_id, new_dept_id) with validation and error handling, and to implement triggers for salary validation and audit logging, including testing of edge cases.

CREATE DATABASE IF NOT EXISTS AuditProcedureDB;
USE AuditProcedureDB;

DROP PROCEDURE IF EXISTS transfer_employee;
DROP TRIGGER IF EXISTS before_employee_salary_update;
DROP TRIGGER IF EXISTS after_employee_salary_update;
DROP TABLE IF EXISTS Salary_Audit;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;

-- 1. Base Tables
CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(100) NOT NULL
);

CREATE TABLE Employee (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(100) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    Dept_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

INSERT INTO Department (Dept_ID, Dept_Name) VALUES 
(1, 'Sales'), 
(2, 'Engineering');

INSERT INTO Employee (Emp_ID, Emp_Name, Salary, Dept_ID) VALUES 
(1, 'Alex', 60000.00, 1);

-- 2. Audit Trail Table
CREATE TABLE Salary_Audit (
    Audit_ID INT AUTO_INCREMENT PRIMARY KEY,
    Emp_ID INT,
    Old_Salary DECIMAL(10,2),
    New_Salary DECIMAL(10,2),
    Changed_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Stored Procedure with Error Handling
DELIMITER $$
CREATE PROCEDURE transfer_employee(
    IN p_emp_id INT,
    IN p_new_dept_id INT
)
BEGIN
    DECLARE emp_count INT DEFAULT 0;
    DECLARE dept_count INT DEFAULT 0;

    SELECT COUNT(*) INTO emp_count FROM Employee WHERE Emp_ID = p_emp_id;
    SELECT COUNT(*) INTO dept_count FROM Department WHERE Dept_ID = p_new_dept_id;

    IF emp_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Employee does not exist';
    ELSEIF dept_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Department does not exist';
    ELSE
        UPDATE Employee
        SET Dept_ID = p_new_dept_id
        WHERE Emp_ID = p_emp_id;
    END IF;
END$$
DELIMITER ;

-- Test Successful Transfer Procedure
CALL transfer_employee(1, 2);
SELECT * FROM Employee WHERE Emp_ID = 1;

-- Edge Case Tests (Uncomment individually to test error raising):
-- CALL transfer_employee(999, 2);  -- Fails: Employee does not exist
-- CALL transfer_employee(1, 999);  -- Fails: Department does not exist

-- 4. BEFORE UPDATE Trigger: Data Validation
DELIMITER $$
CREATE TRIGGER before_employee_salary_update
BEFORE UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF NEW.Salary < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Salary cannot be negative';
    END IF;
END$$
DELIMITER ;

-- Edge Case Test (Uncomment to test trigger rejection):
-- UPDATE Employee SET Salary = -5000 WHERE Emp_ID = 1;

-- 5. AFTER UPDATE Trigger: Audit Logging
DELIMITER $$
CREATE TRIGGER after_employee_salary_update
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF OLD.Salary <> NEW.Salary THEN
        INSERT INTO Salary_Audit (Emp_ID, Old_Salary, New_Salary)
        VALUES (OLD.Emp_ID, OLD.Salary, NEW.Salary);
    END IF;
END$$
DELIMITER ;

-- Test Valid Salary Update and Audit Recording
UPDATE Employee SET Salary = 65000 WHERE Emp_ID = 1;

-- Verify Audit and Master Records
SELECT * FROM Salary_Audit;
SELECT Emp_ID, Emp_Name, Salary FROM Employee WHERE Emp_ID = 1;

-- Expected Output:
-- transfer_employee updates Alex's Dept_ID from 1 to 2.
-- Salary update triggers an entry in Salary_Audit (Old: 60000, New: 65000).
-- Negative salary update is blocked with SQLSTATE 45000.