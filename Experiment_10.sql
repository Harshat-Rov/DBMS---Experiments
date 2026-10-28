-- Experiment 10: Query optimization and EXPLAIN
-- Aim: Generate at least 10,000 records, analyze five queries using EXPLAIN, and compare plans after indexing.
CREATE DATABASE IF NOT EXISTS QueryOptimizationDB;
USE QueryOptimizationDB;
CREATE TABLE Sales_Records(Record_ID INT PRIMARY KEY,Customer_ID INT NOT NULL,Product_ID INT NOT NULL,Region VARCHAR(30),Sale_Date DATE,Quantity INT,Amount DECIMAL(10,2)) ENGINE=InnoDB;
INSERT INTO Sales_Records
SELECT n,MOD(n,1000)+1,MOD(n,200)+1,CASE MOD(n,4) WHEN 0 THEN 'North' WHEN 1 THEN 'South' WHEN 2 THEN 'East' ELSE 'West' END,DATE_ADD('2025-01-01',INTERVAL MOD(n,365) DAY),MOD(n,10)+1,(MOD(n,10)+1)*(100+MOD(n,500))
FROM (SELECT a.n+b.n*10+c.n*100+d.n*1000+1 AS n FROM
(SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a
CROSS JOIN (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b
CROSS JOIN (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) c
CROSS JOIN (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) d) numbers WHERE n<=10000;
SELECT COUNT(*) AS Total_Records FROM Sales_Records;
EXPLAIN SELECT * FROM Sales_Records WHERE Customer_ID=150;
EXPLAIN SELECT * FROM Sales_Records WHERE Product_ID=50;
EXPLAIN SELECT Region,SUM(Amount) FROM Sales_Records WHERE Region='North' GROUP BY Region;
EXPLAIN SELECT * FROM Sales_Records WHERE Sale_Date BETWEEN '2025-03-01' AND '2025-03-31';
EXPLAIN SELECT Customer_ID,SUM(Amount) FROM Sales_Records GROUP BY Customer_ID HAVING SUM(Amount)>5000;
CREATE INDEX idx_customer ON Sales_Records(Customer_ID);
CREATE INDEX idx_product ON Sales_Records(Product_ID);
CREATE INDEX idx_region_amount ON Sales_Records(Region,Amount);
CREATE INDEX idx_sale_date ON Sales_Records(Sale_Date);
CREATE INDEX idx_customer_amount ON Sales_Records(Customer_ID,Amount);
EXPLAIN SELECT * FROM Sales_Records WHERE Customer_ID=150;
EXPLAIN SELECT * FROM Sales_Records WHERE Product_ID=50;
EXPLAIN SELECT Region,SUM(Amount) FROM Sales_Records WHERE Region='North' GROUP BY Region;
EXPLAIN SELECT * FROM Sales_Records WHERE Sale_Date BETWEEN '2025-03-01' AND '2025-03-31';
EXPLAIN SELECT Customer_ID,SUM(Amount) FROM Sales_Records GROUP BY Customer_ID HAVING SUM(Amount)>5000;

-- Output (expected; run the SQL to capture your actual result):
-- Expected result: Sales_Records contains 10000 records. Five EXPLAIN plans are compared before/after indexes; query plan details and runtime vary by environment.

