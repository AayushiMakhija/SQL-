-- CTAS(Create Table As Select)

-- USE CASE -- Optimize the Performance

-- Create a table using CTAS that shows total number of orders for each month

IF OBJECT_ID('Sales.Monthly_Orders','U') IS NOT NULL
	DROP TABLE Sales.Monthly_Orders;
GO

SELECT DATENAME(MONTH,OrderDate) AS Months, COUNT(OrderID) AS Total_Orders 
INTO Sales.Monthly_Orders
FROM Sales.Orders GROUP BY DATENAME(MONTH,OrderDate);

-- USE CASE -- Creating a Snapshot

-- USE CASE -- Physical Data Marts in Data Warehouse

-- TEMP Tables

-- Data Mirgration using temporary tables.

-- Step 1: Create Temporary Table (#Orders)

SELECT
    *
INTO #Orders
FROM Sales.Orders;

SELECT * FROM #Orders;

-- Step 2: Clean Data in Temporary Table

DELETE FROM #Orders
WHERE OrderStatus = 'Delivered';

SELECT * FROM #Orders;

-- Step 3: Load Cleaned Data into Permanent Table (Sales.OrdersTest)

SELECT
    *
INTO Sales.OrdersTest
FROM #Orders;

SELECT * FROM Sales.OrdersTest;