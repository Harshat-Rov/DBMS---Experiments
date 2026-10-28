-- Experiment 9: Railway booking indexes
-- Aim: Create at least 5,000 railway booking records, compare execution plans before and after indexes, and use EXPLAIN.
CREATE DATABASE IF NOT EXISTS RailwayDB;
USE RailwayDB;
CREATE TABLE Railway_Booking(Booking_ID INT PRIMARY KEY,Passenger_Name VARCHAR(50),Train_No INT,Train_Name VARCHAR(50),Source_Station VARCHAR(50),Destination_Station VARCHAR(50),Journey_Date DATE,Seat_No INT,Fare DECIMAL(10,2)) ENGINE=InnoDB;
INSERT INTO Railway_Booking
SELECT n,CONCAT('Passenger_',n),12000+MOD(n,20),CONCAT('Express_',MOD(n,20)),
CASE MOD(n,5) WHEN 0 THEN 'Lucknow' WHEN 1 THEN 'Delhi' WHEN 2 THEN 'Kanpur' WHEN 3 THEN 'Varanasi' ELSE 'Prayagraj' END,
CASE MOD(n,5) WHEN 0 THEN 'Delhi' WHEN 1 THEN 'Kanpur' WHEN 2 THEN 'Lucknow' WHEN 3 THEN 'Prayagraj' ELSE 'Varanasi' END,
DATE_ADD('2026-01-01',INTERVAL MOD(n,365) DAY),MOD(n,72)+1,300+MOD(n,20)*50
FROM (SELECT a.n+b.n*10+c.n*100+d.n*1000+1 AS n FROM
(SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a
CROSS JOIN (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b
CROSS JOIN (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) c
CROSS JOIN (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) d) numbers WHERE n<=5000;
SELECT COUNT(*) AS Total_Records FROM Railway_Booking;
EXPLAIN SELECT * FROM Railway_Booking WHERE Train_No=12005;
EXPLAIN SELECT * FROM Railway_Booking WHERE Passenger_Name='Passenger_2500';
EXPLAIN SELECT * FROM Railway_Booking WHERE Train_No=12005 AND Journey_Date='2026-05-15';
CREATE INDEX idx_train_no ON Railway_Booking(Train_No);
CREATE INDEX idx_passenger_name ON Railway_Booking(Passenger_Name);
CREATE INDEX idx_train_date ON Railway_Booking(Train_No,Journey_Date);
EXPLAIN SELECT * FROM Railway_Booking WHERE Train_No=12005;
EXPLAIN SELECT * FROM Railway_Booking WHERE Passenger_Name='Passenger_2500';
EXPLAIN SELECT * FROM Railway_Booking WHERE Train_No=12005 AND Journey_Date='2026-05-15';
SHOW INDEX FROM Railway_Booking;

-- Output (expected; run the SQL to capture your actual result):
-- Expected result: Railway_Booking contains 5000 records. EXPLAIN is shown before/after indexes; do not claim a fixed speedup because execution plans and timings depend on MySQL version and environment.

