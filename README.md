# ISRT-CSE330-Database-Project

A comprehensive MySQL project for CSE 330. Showcases relational database design, complex JOINs, CTEs, Window Functions, UDFs, and statistical analytics (correlation & regression) to demonstrate advanced SQL data analysis.

---

# Retail Sales & Customer Analytics Database (MySQL)

**Course:** CSE 330 (Databases) - ISRT, University of Dhaka  
**Semester:** 2025  
**Project Type:** SQL & Statistical Analytics Portfolio  

## Project Overview
For this project, I wanted to build something that goes beyond just basic `SELECT *` queries. I designed a simplified E-Commerce database to track customers, products, orders, and order details. 

Instead of just storing data, the main goal here was to use MySQL to actually analyze it—doing advanced query mechanics, writing custom functions (UDFs), and even doing statistical analysis (correlation and regression) right inside the database.

## Syllabus Coverage Matrix
I mapped out the files specifically to match what we learned in CSE 330 this semester:

| Syllabus Topic | Where it is implemented in this repo |
| :--- | :--- |
| **Intro, Data Types, Table Creation** | `01_schema_and_data.sql` |
| **When Good Statements Go Bad** | `02_good_statements_gone_bad.sql` (I intentionally broke constraints to show how the DB handles errors) |
| **Select, From, Where, Group By, Having** | `03_core_query_mechanics.sql` |
| **SQL Joins & Subqueries** | `03_core_query_mechanics.sql` |
| **CTEs & Window Functions** | `04_advanced_analytics.sql` |
| **User-Defined Functions (UDFs)** | `05_user_defined_functions.sql` |
| **Date/Time Functions** | `04_advanced_analytics.sql` |
| **Summary Statistics & Bivariate** | `06_statistical_analysis.sql` |
| **Correlation & Regression** | `07_correlation_regression.sql` |

---

## Repository Structure

*   **`01_schema_and_data.sql`**: The `CREATE TABLE` statements (with Primary/Foreign keys, `DECIMAL`, `DATETIME` types) and dummy data insertion.
*   **`02_good_statements_gone_bad.sql`**: Queries that intentionally throw errors (like Foreign Key violations or putting strings into INT columns) to prove the database design is solid.
*   **`03_core_query_mechanics.sql`**: The foundational stuff—`INNER JOIN`, `LEFT JOIN`, `GROUP BY`, `HAVING`, and subqueries.
*   **`04_advanced_analytics.sql`**: The complex stuff. Using Common Table Expressions (`WITH`), Window Functions (`RANK() OVER`), and Date/Time functions.
*   **`05_user_defined_functions.sql`**: Creating a custom UDF (`CalculateDiscountedPrice`) to handle business logic.
*   **`06_statistical_analysis.sql`**: Calculating univariate stats (mean, standard deviation) and bivariate frequency distributions (like grouping customers by age and spend).
*   **`07_correlation_regression.sql`**: Manual calculation of Pearson Correlation Coefficient and simple Linear Regression formulas using aggregate SQL functions (since MySQL doesn't have a built-in `CORR()` function like Postgres does).
*   **`/outputs/`**: A folder where I put screenshots or `.csv` exports of the query results so you can see them working without running the code.

---

## Tech Stack & Setup
*   **Database Engine:** MySQL 8.0+
*   **Tools Used:** MySQL Workbench

### How to Run This Project
1. Clone the repository or download the files.
2. Open MySQL Workbench (or whatever client you use).
3. Create a new database: `CREATE DATABASE cse330_project;`
4. Run the files in numerical order (`01_...`, `02_...`, etc.) to build the schema, insert data, and run the queries.

---

## Highlighted Queries

### 1. Window Functions (Ranking)
*See `04_advanced_analytics.sql`*
Finds the top 3 best-selling products in *each* category without using messy nested subqueries.

```sql
SELECT * FROM (
    SELECT ProductName, Category, SUM(Quantity) as TotalSold,
           RANK() OVER(PARTITION BY Category ORDER BY SUM(Quantity) DESC) as SalesRank
    FROM OrderItems
    JOIN Products ON OrderItems.ProductID = Products.ProductID
    GROUP BY ProductName, Category
) ranked_products
WHERE SalesRank <= 3;
