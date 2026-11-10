-- ==========================================================
-- FILE: 02_good_statements_gone_bad.sql
-- DESCRIPTION: Intentionally breaking the database to test constraints
-- Note: If you run this, MySQL Workbench will throw errors. 
-- Thats the point! It proves the database is doing its job.
-- ==========================================================

-- ----------------------------------------------------------
-- 1. PRIMARY KEY VIOLATION
-- Trying to insert a CustomerID that already exists (CustomerID 1 is Aarav)
-- ----------------------------------------------------------
-- This will throw: Error Code: 1062. Duplicate entry '1' for key 'PRIMARY'
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, JoinDate, City, Age) 
VALUES (1, 'Fake', 'Duplicate', 'fake@example.com', '2024-11-10 10:00:00', 'Dhaka', 25);

-- ----------------------------------------------------------
-- 2. UNIQUE CONSTRAINT VIOLATION
-- Trying to register a new customer with an email that Priya already used
-- ----------------------------------------------------------
-- This will throw: Error Code: 1062. Duplicate entry 'priya@example.com' for key 'Email'
INSERT INTO Customers (FirstName, LastName, Email, JoinDate, City, Age) 
VALUES ('Imposter', 'User', 'priya@example.com', '2024-11-10 11:00:00', 'Sylhet', 20);

-- ----------------------------------------------------------
-- 3. FOREIGN KEY VIOLATION
-- Trying to create an order for a CustomerID (99) that doesn't exist
-- ----------------------------------------------------------
-- This will throw: Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails
INSERT INTO Orders (CustomerID, OrderDate) 
VALUES (99, '2024-11-10 12:00:00');

-- ----------------------------------------------------------
-- 4. DATA TYPE / WRONG VALUE VIOLATION
-- Trying to put text into an INT column (Quantity) 
-- ----------------------------------------------------------
-- This will throw: Error Code: 1366. Incorrect integer value: 'five' for column 'Quantity' at row 1
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Discount) 
VALUES (1, 3, 'five', 0.05);

-- ----------------------------------------------------------
-- 5. NOT NULL CONSTRAINT VIOLATION
-- Trying to insert a Product without giving it a ProductName 
-- (Remember we made ProductName VARCHAR(100) NOT NULL)
-- ----------------------------------------------------------
-- This will throw: Error Code: 1048. Column 'ProductName' cannot be null
INSERT INTO Products (ProductName, Category, Price) 
VALUES (NULL, 'Electronics', 150.00);

-- ----------------------------------------------------------
-- 6. CHECKING WHAT HAPPENS IF WE RUN IT WITHOUT THE KEY
-- (Proving that inserting with a valid ID actually works)
-- ----------------------------------------------------------
-- This one WILL succeed because ProductID 3 and OrderID 2 exist.
-- I'm just leaving it here to show that the statement works 
-- once the data type is corrected from 'five' to a number.
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Discount) 
VALUES (2, 3, 5, 0.05);
