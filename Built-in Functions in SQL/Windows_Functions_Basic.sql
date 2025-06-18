-- PARTITION BY Clauses

-- Find the total sales across all the orders aditionally provide the details such as order id and order date

SELECT OrderID, OrderDate, Sales,
	SUM(Sales) Over() AS Total_Sales
	FROM Sales.Orders;

-- Find the total sales for each product aditionally provide the details such as order id and order date

SELECT OrderID, OrderDate, Sales, ProductID,
	SUM(Sales) Over(PARTITION BY ProductID) AS Total_Sales
	FROM Sales.Orders;

-- Find the total sales for each combination of product and order status

SELECT OrderID, OrderDate, Sales,ProductID,OrderStatus,
	SUM(Sales) Over(PARTITION BY ProductID , OrderStatus) AS Total_Sales
	FROM Sales.Orders;

-- ORDER BY Clauses

-- Rank each order based on their sales from highest to lowest , additionally provide the order id and order date 

SELECT OrderID, OrderDate, Sales,
	RANK() Over(ORDER BY Sales DESC) AS Rank_Sales
	FROM Sales.Orders;

-- Frame Clauses

-- Calculate Total Sales by Order Status for current and next two orders 

SELECT OrderID, OrderDate, Sales,ProductID ,OrderStatus,
	SUM(Sales) Over(PARTITION  BY OrderStatus ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS Total_Sales
	FROM Sales.Orders;

-- Calculate Total Sales by Order Status for current and previous two orders 

SELECT OrderID, OrderDate, ProductID, OrderStatus, Sales,
    SUM(Sales) OVER (PARTITION BY OrderStatus ORDER BY OrderDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Total_Sales
FROM Sales.Orders;

-- Find the total sales for each order status, only for two products 101 and 102

SELECT OrderID, OrderDate, Sales,ProductID ,OrderStatus,
	SUM(Sales) Over(PARTITION  BY OrderStatus) AS Total_Sales
	FROM Sales.Orders WHERE ProductID IN (101,102);

-- Rank customers based on their total sales

SELECT CustomerID, SUM(Sales) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS Rank_Customers
FROM Sales.Orders
GROUP BY CustomerID;