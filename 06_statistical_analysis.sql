-- ==========================================================
-- FILE: 06_statistical_analysis.sql
-- DESCRIPTION: Summary stats, Univariate and Bivariate distributions
-- ==========================================================

-- ----------------------------------------------------------
-- 1. UNIVARIATE SUMMARY STATISTICS
-- Let's look at the distribution of our product prices.
-- Are most products cheap, or do we have a lot of expensive outliers?
-- ----------------------------------------------------------
SELECT 
    COUNT(ProductID) AS Total_Products,
    MIN(Price) AS Cheapest_Product,
    MAX(Price) AS Most_Expensive,
    AVG(Price) AS Average_Price,
    -- Standard deviation tells us how spread out the prices are
    STDDEV(Price) AS Price_Standard_Deviation
FROM Products;

-- ----------------------------------------------------------
-- 2. UNIVARIATE FREQUENCY DISTRIBUTION
-- How many products do we have in each category?
-- ----------------------------------------------------------
SELECT 
    Category, 
    COUNT(ProductID) AS NumberOfProducts,
    -- Calculating what percentage of the total catalog is this category
    (COUNT(ProductID) * 100.0 / (SELECT COUNT(*) FROM Products)) AS PercentageOfCatalog
FROM Products
GROUP BY Category
ORDER BY NumberOfProducts DESC;

-- ----------------------------------------------------------
-- 3. BIVARIATE FREQUENCY DISTRIBUTION (CROSSTAB)
-- This is the big one. Let's see how customer Age Groups correlate 
-- with what Category of products they buy.
-- We use CASE statements to create custom "buckets" for Age.
-- ----------------------------------------------------------
SELECT 
    CASE 
        WHEN c.Age < 25 THEN 'Under 25'
        WHEN c.Age BETWEEN 25 AND 35 THEN '25 to 35'
        ELSE 'Over 35'
    END AS Age_Group,
    p.Category,
    COUNT(oi.OrderItemID) AS TimesPurchased
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY 
    CASE 
        WHEN c.Age < 25 THEN 'Under 25'
        WHEN c.Age BETWEEN 25 AND 35 THEN '25 to 35'
        ELSE 'Over 35'
    END,
    p.Category
ORDER BY Age_Group, TimesPurchased DESC;

-- ----------------------------------------------------------
-- 4. CUSTOMER DEMOGRAPHICS SUMMARY
-- Let's find the average age of our customers and the standard deviation
-- to understand our primary audience.
-- ----------------------------------------------------------
SELECT 
    City,
    COUNT(CustomerID) AS TotalCustomers,
    AVG(Age) AS AvgAge,
    STDDEV(Age) AS AgeStdDev
FROM Customers
GROUP BY City
ORDER BY TotalCustomers DESC;
