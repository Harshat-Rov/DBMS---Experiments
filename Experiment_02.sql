-- Experiment 2: Relational schema and integrity constraints
-- Aim: Convert the ER model into relational tables and demonstrate integrity constraints.
CREATE DATABASE IF NOT EXISTS EcommerceIntegrityDB;
USE EcommerceIntegrityDB;
CREATE TABLE Customer(Customer_ID INT PRIMARY KEY, Full_Name VARCHAR(100) NOT NULL, Email VARCHAR(100) NOT NULL UNIQUE);
CREATE TABLE Product(Product_ID INT PRIMARY KEY, Product_Name VARCHAR(100) NOT NULL, Price DECIMAL(10,2) NOT NULL CHECK(Price>=0));
CREATE TABLE Orders(Order_ID INT PRIMARY KEY, Customer_ID INT NOT NULL, FOREIGN KEY(Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE);
CREATE TABLE OrderItem(Order_ID INT, Product_ID INT, Quantity INT NOT NULL CHECK(Quantity>0), PRIMARY KEY(Order_ID,Product_ID), FOREIGN KEY(Order_ID) REFERENCES Orders(Order_ID) ON DELETE CASCADE, FOREIGN KEY(Product_ID) REFERENCES Product(Product_ID));
INSERT INTO Customer VALUES(1,'Aarav Sharma','aarav@example.com');
INSERT INTO Product VALUES(101,'Laptop',55000);
INSERT INTO Orders VALUES(1001,1);
INSERT INTO OrderItem VALUES(1001,101,1);
SELECT * FROM Customer; SELECT * FROM Orders; SELECT * FROM OrderItem;
-- Uncomment separately to test errors:
-- INSERT INTO Orders VALUES(1002,999);
-- INSERT INTO OrderItem VALUES(9999,101,1);
-- INSERT INTO OrderItem VALUES(1001,999,1);

-- Output (expected; run the SQL to capture your actual result):
-- Expected result: Valid rows are accepted. The two invalid INSERT examples are commented out; if run, they should fail because of the foreign-key constraint. CHECK enforcement depends on MySQL version.

