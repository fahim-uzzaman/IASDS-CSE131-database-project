-- ==========================================================
-- FILE: 04_advanced_analytics.sql
-- DESCRIPTION: CTEs, Window Functions, and Date/Time stuff
-- ==========================================================

-- ----------------------------------------------------------
-- 1. COMMON TABLE EXPRESSION (CTE)
-- Let's find out who are the top 3 highest spending customers.
-- Using a CTE makes this easier to read than a giant nested subquery.
-- ----------------------------------------------------------
WITH CustomerSpending AS (
    SELECT 
        c.CustomerID,
        c.FirstName,
        c.LastName,
        SUM(p.Price * oi.Quantity) AS TotalSpent
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN OrderItems oi ON o.OrderID = oi.OrderID
    JOIN Products p ON oi.ProductID = p.ProductID
    GROUP BY c.CustomerID, c.FirstName, c.LastName
)
SELECT * FROM CustomerSpending
ORDER BY TotalSpent DESC
LIMIT 3;

-- ----------------------------------------------------------
-- 2. WINDOW FUNCTIONS (RANK)
-- Find the top 2 most expensive products in EACH category.
-- Before we learned window functions, this was super hard.
-- Now we just use PARTITION BY.
-- ----------------------------------------------------------
WITH RankedProducts AS (
    SELECT 
        Category,
        ProductName,
        Price,
        RANK() OVER(PARTITION BY Category ORDER BY Price DESC) as PriceRank
    FROM Products
)
SELECT Category, ProductName, Price, PriceRank
FROM RankedProducts
WHERE PriceRank <= 2;

-- ----------------------------------------------------------
-- 3. DATE / TIME FUNCTIONS
-- Calculate how many days each customer has been in our system
-- (Calculating from their JoinDate to the current date)
-- ----------------------------------------------------------
SELECT 
    FirstName,
    LastName,
    JoinDate,
    DATEDIFF(CURRENT_DATE(), JoinDate) AS DaysSinceJoined
FROM Customers
ORDER BY DaysSinceJoined DESC;

-- ----------------------------------------------------------
-- 4. RUNNING TOTAL (Another Window Function)
-- Show me the daily sales, and a running total of sales over time.
-- ----------------------------------------------------------
WITH DailySales AS (
    SELECT 
        DATE(o.OrderDate) AS SaleDate, 
        SUM(p.Price * oi.Quantity) AS DailyTotal
    FROM Orders o
    JOIN OrderItems oi ON o.OrderID = oi.OrderID
    JOIN Products p ON oi.ProductID = p.ProductID
    GROUP BY DATE(o.OrderDate)
)
SELECT 
    SaleDate, 
    DailyTotal,
    -- This adds up all previous days to get a running total
    SUM(DailyTotal) OVER (ORDER BY SaleDate) AS RunningTotal
FROM DailySales;
