-- ==========================================================
-- FILE: 03_core_query_mechanics.sql
-- DESCRIPTION: Practice queries for Joins, Group By, Having, etc.
-- ==========================================================

-- ----------------------------------------------------------
-- 1. BASIC SELECT, WHERE, ORDER BY
-- Find all customers who live in Dhaka, sorted by age (oldest first)
-- ----------------------------------------------------------
SELECT FirstName, LastName, Age 
FROM Customers
WHERE City = 'Dhaka'
ORDER BY Age DESC;

-- ----------------------------------------------------------
-- 2. INNER JOIN & AGGREGATION
-- Show me a list of orders with the customer's name and the total price of the order
-- (Using JOIN and SUM)
-- ----------------------------------------------------------
SELECT 
    o.OrderID, 
    c.FirstName, 
    c.LastName, 
    SUM(p.Price * oi.Quantity) AS Total_Amount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY o.OrderID, c.FirstName, c.LastName
ORDER BY Total_Amount DESC;

-- ----------------------------------------------------------
-- 3. LEFT JOIN (Finding Missing Data)
-- Find customers who havent placed any orders yet
-- (A LEFT JOIN keeps all customers, but shows NULL for the order ID)
-- ----------------------------------------------------------
SELECT 
    c.FirstName, 
    c.LastName, 
    o.OrderID
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- ----------------------------------------------------------
-- 4. GROUP BY and HAVING
-- Find categories where the average product price is more than 100
-- (We use WHERE to filter rows, but HAVING to filter groups)
-- ----------------------------------------------------------
SELECT 
    Category, 
    AVG(Price) AS Avg_Price
FROM Products
GROUP BY Category
HAVING AVG(Price) > 100;

-- ----------------------------------------------------------
-- 5. SUBQUERY
-- Find the name of the product that has the highest price in the whole store
-- (Doing this without LIMIT 1 to show we know how to use subqueries)
-- ----------------------------------------------------------
SELECT ProductName, Price
FROM Products
WHERE Price = (
    SELECT MAX(Price) FROM Products
);

-- ----------------------------------------------------------
-- 6. AGGREGATION WITH CONDITIONAL LOGIC
-- How many orders has each city generated in total?
-- ----------------------------------------------------------
SELECT 
    c.City, 
    COUNT(o.OrderID) AS Total_Orders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.City
ORDER BY Total_Orders DESC;
