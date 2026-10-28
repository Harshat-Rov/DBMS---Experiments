-- Experiment 1: E-commerce ER diagram and schema
-- Aim: Design an e-commerce ER diagram and create its relational tables in MySQL.
CREATE DATABASE IF NOT EXISTS EcommerceDB;
USE EcommerceDB;
CREATE TABLE Customer(Customer_ID INT PRIMARY KEY AUTO_INCREMENT, Full_Name VARCHAR(100) NOT NULL, Email VARCHAR(100) NOT NULL UNIQUE, Phone VARCHAR(20));
CREATE TABLE Address(Address_ID INT PRIMARY KEY AUTO_INCREMENT, Customer_ID INT NOT NULL, Address_Line VARCHAR(200), City VARCHAR(60), State VARCHAR(60), Postal_Code VARCHAR(15), FOREIGN KEY(Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE);
CREATE TABLE Seller(Seller_ID INT PRIMARY KEY AUTO_INCREMENT, Seller_Name VARCHAR(100) NOT NULL, Email VARCHAR(100) UNIQUE);
CREATE TABLE Category(Category_ID INT PRIMARY KEY AUTO_INCREMENT, Category_Name VARCHAR(80) NOT NULL UNIQUE);
CREATE TABLE Product(Product_ID INT PRIMARY KEY AUTO_INCREMENT, Product_Name VARCHAR(120) NOT NULL, Category_ID INT NOT NULL, Seller_ID INT NOT NULL, Product_Type VARCHAR(30), Price DECIMAL(10,2) NOT NULL, FOREIGN KEY(Category_ID) REFERENCES Category(Category_ID), FOREIGN KEY(Seller_ID) REFERENCES Seller(Seller_ID));
CREATE TABLE Orders(Order_ID INT PRIMARY KEY AUTO_INCREMENT, Customer_ID INT NOT NULL, Address_ID INT, Order_Date DATETIME DEFAULT CURRENT_TIMESTAMP, Order_Status VARCHAR(30) DEFAULT 'Placed', FOREIGN KEY(Customer_ID) REFERENCES Customer(Customer_ID), FOREIGN KEY(Address_ID) REFERENCES Address(Address_ID) ON DELETE SET NULL);
CREATE TABLE OrderItem(Order_ID INT, Product_ID INT, Quantity INT NOT NULL, Unit_Price DECIMAL(10,2) NOT NULL, PRIMARY KEY(Order_ID,Product_ID), FOREIGN KEY(Order_ID) REFERENCES Orders(Order_ID) ON DELETE CASCADE, FOREIGN KEY(Product_ID) REFERENCES Product(Product_ID));
CREATE TABLE Payment(Payment_ID INT PRIMARY KEY AUTO_INCREMENT, Order_ID INT NOT NULL UNIQUE, Payment_Date DATETIME DEFAULT CURRENT_TIMESTAMP, Amount DECIMAL(10,2) NOT NULL, Payment_Method VARCHAR(30), Payment_Status VARCHAR(30) DEFAULT 'Pending', FOREIGN KEY(Order_ID) REFERENCES Orders(Order_ID) ON DELETE CASCADE);
CREATE TABLE Delivery(Delivery_ID INT PRIMARY KEY AUTO_INCREMENT, Order_ID INT NOT NULL UNIQUE, Tracking_Number VARCHAR(60) UNIQUE, Delivery_Status VARCHAR(30) DEFAULT 'Processing', FOREIGN KEY(Order_ID) REFERENCES Orders(Order_ID) ON DELETE CASCADE);
INSERT INTO Customer(Full_Name,Email,Phone) VALUES ('Aarav Sharma','aarav@example.com','9000000001'),('Diya Singh','diya@example.com','9000000002');
INSERT INTO Address(Customer_ID,Address_Line,City,State,Postal_Code) VALUES (1,'12 Main Road','Lucknow','Uttar Pradesh','226001'),(2,'24 Park Street','Kanpur','Uttar Pradesh','208001');
INSERT INTO Seller(Seller_Name,Email) VALUES ('Tech Seller','seller@example.com');
INSERT INTO Category(Category_Name) VALUES ('Electronics'),('Accessories');
INSERT INTO Product(Product_Name,Category_ID,Seller_ID,Product_Type,Price) VALUES ('Laptop',1,1,'Physical',55000),('Mouse',2,1,'Physical',700);
INSERT INTO Orders(Customer_ID,Address_ID) VALUES (1,1);
INSERT INTO OrderItem VALUES (1,1,1,55000),(1,2,2,700);
INSERT INTO Payment(Order_ID,Amount,Payment_Method,Payment_Status) VALUES (1,56400,'UPI','Paid');
INSERT INTO Delivery(Order_ID,Tracking_Number,Delivery_Status) VALUES (1,'TRK10001','Shipped');
SELECT * FROM Customer; SELECT * FROM Product; SELECT * FROM Orders; SELECT * FROM OrderItem; SELECT * FROM Payment; SELECT * FROM Delivery;

-- Output (expected; run the SQL to capture your actual result):
-- Expected result: Database and tables are created; sample e-commerce rows are inserted and SELECT statements display the inserted records. Exact row counts depend on the INSERT statements in this file.


-- ER diagram image: ER_Diagram.png
