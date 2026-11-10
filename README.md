# ISRT-CSE330-Database-Project
A comprehensive MySQL project for CSE 330. Showcases relational database design, complex JOINs, CTEs, Window Functions, UDFs, and statistical analytics (correlation &amp; regression) to demonstrate advanced SQL data analysis.


Here is a professional, comprehensive `README.md` tailored exactly to your CSE 330 syllabus. It is designed to impress your instructor by explicitly mapping your SQL files to the course contents.

Copy and paste this directly into your GitHub repository's `README.md` file:

---

#  Retail Sales & Customer Analytics Database (MySQL)

**Course:** CSE 330 (Databases) - ISRT, University of Dhaka  
**Semester:** 2025  
**Project Type:** Comprehensive SQL & Statistical Analytics Portfolio  

##  Project Overview
This project demonstrates a complete end-to-end database implementation and data analysis workflow using **MySQL**. It moves beyond basic CRUD operations to showcase advanced query mechanics, database programmability (UDFs), and statistical analysis (correlation and regression) performed directly within the SQL environment.

The database models a simplified E-Commerce system tracking customers, products, orders, and order details.

##  Syllabus Coverage Matrix
This project was specifically designed to cover every topic outlined in the CSE 330 syllabus:

| Syllabus Topic | Where it is implemented in this repo |
| :--- | :--- |
| **Intro, Data Types, Table Creation** | `01_schema_and_data.sql` |
| **When Good Statements Go Bad** | `02_good_statements_gone_bad.sql` (Demonstrating constraint violations) |
| **Select, From, Where, Group By, Having** | `03_core_query_mechanics.sql` |
| **SQL Joins & Subqueries** | `03_core_query_mechanics.sql` |
| **CTEs & Window Functions** | `04_advanced_analytics.sql` |
| **User-Defined Functions (UDFs)** | `05_user_defined_functions.sql` |
| **Date/Time Functions** | `04_advanced_analytics.sql` |
| **Summary Statistics & Bivariate** | `06_statistical_analysis.sql` |
| **Correlation & Regression** | `07_correlation_regression.sql` |

---

##  Repository Structure

*   **`01_schema_and_data.sql`**: Contains the `CREATE TABLE` statements (with appropriate Primary/Foreign keys and `DECIMAL`, `DATETIME` data types) and `INSERT` statements to populate the database with realistic dummy data.
*   **`02_good_statements_gone_bad.sql`**: Scripts that intentionally trigger errors (e.g., Foreign Key violations, inserting strings into INT columns) to demonstrate robust database design and error handling.
*   **`03_core_query_mechanics.sql`**: Foundational queries using `INNER JOIN`, `LEFT JOIN`, `GROUP BY`, `HAVING`, and subqueries.
*   **`04_advanced_analytics.sql`**: Complex analysis utilizing Common Table Expressions (`WITH`), Window Functions (`RANK() OVER`), and Date/Time functions to track customer lifetime value.
*   **`05_user_defined_functions.sql`**: Creation of a custom UDF (`CalculateDiscountedPrice`) to modularize business logic.
*   **`06_statistical_analysis.sql`**: Queries calculating univariate stats (mean, standard deviation) and bivariate frequency distributions (grouping customers by age and spend).
*   **`07_correlation_regression.sql`**: Manual calculation of Pearson Correlation Coefficient and simple Linear Regression formulas using aggregate SQL functions (since native `CORR()` is not built into standard MySQL).
*   **`/outputs/`**: Folder containing screenshots or `.csv` exports of the successful query results for visual proof.

---

##  Tech Stack & Setup
*   **Database Engine:** MySQL 8.0+
*   **Tools Used:** MySQL Workbench / DBeaver

### How to Run This Project
1. Clone the repository to your local machine.
2. Open your MySQL client.
3. Create a new database: `CREATE DATABASE cse330_project;`
4. Execute the SQL files in numerical order (`01_...`, `02_...`, etc.) to build the schema, insert data, and run the queries.

---

##  Highlighted Queries

### 1. Window Functions (Ranking)
*See `04_advanced_analytics.sql`*
Finds the top 3 best-selling products in *each* category without using complex subqueries.
```sql
SELECT * FROM (
    SELECT ProductName, Category, SUM(Quantity) as TotalSold,
           RANK() OVER(PARTITION BY Category ORDER BY SUM(Quantity) DESC) as SalesRank
    FROM OrderItems
    JOIN Products ON OrderItems.ProductID = Products.ProductID
    GROUP BY ProductName, Category
) ranked_products
WHERE SalesRank <= 3;
```

### 2. Statistical Analysis (Manual Regression in SQL)
*See `07_correlation_regression.sql`*
Calculates the slope of the regression line between `Discount_Rate` and `Quantity_Purchased`.
*(The exact mathematical formula is implemented using `SUM()`, `AVG()`, and `COUNT()`).*

---

##  Author
**Md. Fahimuzzaman**
*   Registration Number ID: [2023916089]
*   Institute of Applied Statistics and Data Science / IASDS, University of Dhaka
*   Course: CSE 330 (SQL for Data Science)

---
*Disclaimer: The data used in this project is synthetic and generated for educational purposes only.*
