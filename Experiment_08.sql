-- Experiment 8: Transactions and concurrency
-- Aim: Implement banking transactions using COMMIT, ROLLBACK and SAVEPOINT, and demonstrate isolation levels and two-session testing.
CREATE DATABASE IF NOT EXISTS BankingDB;
USE BankingDB;
CREATE TABLE Bank_Account(Account_ID INT PRIMARY KEY,Account_Holder VARCHAR(50),Balance DECIMAL(10,2) NOT NULL CHECK(Balance>=0)) ENGINE=InnoDB;
INSERT INTO Bank_Account VALUES(101,'Rahul Sharma',50000),(102,'Priya Singh',30000),(103,'Amit Kumar',40000);
SELECT * FROM Bank_Account;
START TRANSACTION;
UPDATE Bank_Account SET Balance=Balance-5000 WHERE Account_ID=101;
UPDATE Bank_Account SET Balance=Balance+5000 WHERE Account_ID=102;
COMMIT;
SELECT * FROM Bank_Account;
START TRANSACTION;
UPDATE Bank_Account SET Balance=Balance-10000 WHERE Account_ID=101;
UPDATE Bank_Account SET Balance=Balance+10000 WHERE Account_ID=103;
ROLLBACK;
SELECT * FROM Bank_Account;
START TRANSACTION;
UPDATE Bank_Account SET Balance=Balance-3000 WHERE Account_ID=101;
SAVEPOINT transfer_point;
UPDATE Bank_Account SET Balance=Balance+3000 WHERE Account_ID=102;
ROLLBACK TO SAVEPOINT transfer_point;
COMMIT;
SELECT * FROM Bank_Account;
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION; SELECT Balance FROM Bank_Account WHERE Account_ID=101; COMMIT;
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION; SELECT Balance FROM Bank_Account WHERE Account_ID=101; COMMIT;
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION; SELECT Balance FROM Bank_Account WHERE Account_ID=101; COMMIT;
-- Test in two separate MySQL sessions:
-- Session 1: START TRANSACTION; SELECT Balance FROM Bank_Account WHERE Account_ID=101; UPDATE Bank_Account SET Balance=Balance-5000 WHERE Account_ID=101; COMMIT;
-- Session 2: START TRANSACTION; SELECT Balance FROM Bank_Account WHERE Account_ID=101; UPDATE Bank_Account SET Balance=Balance-3000 WHERE Account_ID=101; COMMIT;

-- Output (expected; run the SQL to capture your actual result):
-- Expected result: SELECT shows three bank accounts with starting balances 50000.00, 30000.00, and 40000.00. COMMIT preserves changes; ROLLBACK cancels them; concurrency tests must be run in two separate sessions.

