-- COUNT() Function

-- Find the total numbers of orders for each customers, additionally provide details such as order id and order date

SELECT OrderID, OrderDate,CustomerID, COUNT(*) OVER (PARTITION BY CustomerID)AS Total_Orders FROM Sales.Orders;

-- Find the total number of customers , additionally providing all customer's details

SELECT CustomerID, FirstName, LastName, Country, Score,
	COUNT(*) OVER () AS Total_Customers
FROM Sales.Customers;

-- Find the total number of scores for the customers

SELECT CustomerID, Score, COUNT(Score) OVER () AS Total_Scores FROM Sales.Customers;

-- Check whether the table 'Orders' contains any duplicate row

SELECT OrderID, COUNT(*) OVER (PARTITION BY OrderID) AS CheckPK FROM Sales.Orders;

-- Check whether the table 'OrdersArchieve' contains any duplicate row

SELECT OrderID, COUNT(*) OVER (PARTITION BY OrderID) AS CheckPK FROM Sales.OrdersArchive;

-- SUM() Function

/* Find the Total Sales Across All Orders and the Total Sales for Each Product , additionally, provide details such as order id 
and order date */

SELECT OrderID, OrderDate,ProductID, Sales, SUM(Sales) OVER() AS Total_sales_orders,
	SUM(Sales) OVER (PARTITION BY ProductID) AS Total_sales_product
FROM Sales.Orders;

-- Find the percentage contribution of each product's sales to the total sales

SELECT OrderID, OrderDate, ProductID,Sales, SUM(Sales) OVER () AS Total_Sales,
	ROUND(CAST(Sales AS FLOAT) / SUM(Sales) OVER () * 100, 2) AS PercentageOfTotal
FROM Sales.Orders;

-- AVG() Function

/* Find the average sales across all orders and average sales for each product. Additionally, provide details such as order id 
and order date*/

SELECT  OrderID ,ProductID, OrderDate ,AVG(Sales) OVER() AS Avg_sales_orders,
	AVG(Sales) OVER (PARTITION BY ProductID) AS Avg_sales_products
FROM Sales.Orders;

-- Find the Average Scores of Customers. Additionally, provide details such as Customer ID and LastName

SELECT CustomerID, LastName, Score, 
	AVG(COALESCE(Score,0)) OVER () AS Avg_scores
FROM Sales.Customers;

-- Find all orders where Sales exceed the average Sales across all orders

SELECT * FROM (SELECT  OrderID ,ProductID,Sales, OrderDate ,AVG(Sales) OVER() AS Avg_sales
FROM Sales.Orders)t WHERE Sales > Avg_sales;

-- MIN/MAX Functions

/* Find the highest and lowest sales across all the orders and highest and lowest sales for each products. Additionally provide
details such as order id and order date*/

SELECT OrderID, OrderDate, ProductID, Sales,
	MIN(Sales) OVER() AS Min_sales_orders,MAX(Sales) OVER() AS Max_sales_orders,
	MIN(Sales) OVER(PARTITION BY ProductID)AS Min_sales_products,MAX(Sales) OVER(PARTITION BY ProductID) AS Max_sales_products
FROM Sales.Orders;

-- Show the employees with the highest salaries

SELECT * FROM (SELECT EmployeeID, FirstName,Salary,
	MAX(Salary) OVER () AS Highest_salary
FROM Sales.Employees)t WHERE Salary = Highest_salary;

-- Find the deviation of each Sale from the minimum and maximum Sales

SELECT OrderID, OrderDate, ProductID, Sales,
	MIN(Sales) OVER() AS Min_sales_orders,MAX(Sales) OVER() AS Max_sales_orders,
	Sales - MIN(Sales) OVER () AS DeviationFromMin,
    MAX(Sales) OVER () - Sales AS DeviationFromMax
FROM Sales.Orders;

--  Use Case : Running total and Rolling total

-- Use Case : Moving Average

-- Calculate the moving average of Sales for each Product over time

SELECT OrderID, OrderDate, ProductID, Sales, 
	AVG(Sales) OVER(PARTITION BY ProductID) AS AVG_Sales,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) AS Moving_Avg
FROM Sales.Orders;

-- Calculate the moving average of Sales for each Product over time including only the next order

SELECT OrderID, OrderDate, ProductID, Sales, 
	AVG(Sales) OVER(PARTITION BY ProductID) AS AVG_Sales,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING ) AS ROLLING_AVG
FROM Sales.Orders;
