-- CSE 330 Project - Database Setup
-- First, droping tables in the right order so we don't get foreign key errors if we run this multiple times
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-- Creating the Customers table
-- Using INT for age, and DATETIME for the join date
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE, 
    JoinDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    City VARCHAR(50),
    Age INT
);

-- Products table
-- Used DECIMAL(10,2) for price so we dont loose cents with floating point math
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10, 2) NOT NULL
);

-- Orders table
-- Linking to customers. If a customer is deleted, I guess there orders should disappear too (CASCADE)
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);

-- OrderItems table
-- Because an order can have multiple products, and a product can be in multiple orders
CREATE TABLE OrderItems (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Discount DECIMAL(5, 2) DEFAULT 0.00, 
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Inserting dummy data for customers
-- Just making up random names, citys, and ages
INSERT INTO Customers (FirstName, LastName, Email, JoinDate, City, Age) VALUES
('Aarav', 'Sharma', 'aarav@example.com', '2024-01-15 10:30:00', 'Dhaka', 22),
('Priya', 'Patel', 'priya@example.com', '2024-02-20 14:15:00', 'Chittagong', 28),
('Rohan', 'Das', 'rohan@example.com', '2024-03-05 09:00:00', 'Dhaka', 35),
('Ananya', 'Rahman', 'ananya@example.com', '2024-04-12 16:45:00', 'Sylhet', 19),
('Vikram', 'Singh', 'vikram@example.com', '2024-05-01 11:20:00', 'Dhaka', 42),
('Sneha', 'Ahmed', 'sneha@example.com', '2024-06-18 13:10:00', 'Khulna', 25),
('Rahul', 'Khan', 'rahul@example.com', '2024-07-22 15:30:00', 'Chittagong', 31),
('Ishita', 'Hossain', 'ishita@example.com', '2024-08-09 10:00:00', 'Dhaka', 21),
('Zara', 'Ali', 'zara@example.com', '2024-09-14 17:20:00', 'Sylhet', 29),
('Kabir', 'Chowdhury', 'kabir@example.com', '2024-10-30 12:00:00', 'Dhaka', 38);

-- Inserting some products
-- Mixing electronics, furnitur, and accessories
INSERT INTO Products (ProductName, Category, Price) VALUES
('UltraBook Pro 15', 'Electronics', 1200.00),
('Wireless Noise-Canceling Headphones', 'Electronics', 250.50),
('Mechanical Keyboard', 'Electronics', 85.00),
('Smart Watch Series 6', 'Electronics', 199.99),
('Ergonomic Office Chair', 'Furniture', 350.00),
('Standing Desk', 'Furniture', 450.00),
('Minimalist Backpack', 'Accessories', 45.00),
('Leather Wallet', 'Accessories', 30.00),
('Stainless Steel Water Bottle', 'Accessories', 25.00),
('4K Monitor 27-inch', 'Electronics', 400.00);

-- Inserting orders (linking to customer IDs)
INSERT INTO Orders (CustomerID, OrderDate) VALUES
(1, '2024-10-01 10:15:00'),
(2, '2024-10-05 14:30:00'),
(1, '2024-10-10 09:45:00'),
(3, '2024-10-12 11:00:00'),
(4, '2024-10-15 16:20:00'),
(5, '2024-10-20 10:10:00'),
(2, '2024-10-22 13:50:00'),
(6, '2024-10-25 15:30:00'),
(7, '2024-10-28 12:05:00'),
(8, '2024-11-01 09:30:00'),
(9, '2024-11-02 14:15:00'),
(10, '2024-11-03 17:45:00');

-- Inserting order details
-- Giving different quantities and discounts so we have sumthing to analyze later
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Discount) VALUES
(1, 1, 1, 0.10),  
(1, 2, 2, 0.05),  
(2, 5, 1, 0.00),  
(3, 7, 3, 0.15),  
(4, 3, 1, 0.00),  
(4, 4, 1, 0.10),  
(5, 10, 2, 0.20), 
(6, 8, 5, 0.10),  
(6, 9, 5, 0.10),  
(7, 2, 1, 0.00),  
(8, 6, 1, 0.00),  
(9, 1, 1, 0.05),  
(10, 7, 1, 0.00), 
(11, 4, 2, 0.15), 
(12, 2, 3, 0.10); 
