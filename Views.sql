-- Central Complex Query Language

/*	Create a view that summarizes monthly sales by aggregating:
     - OrderMonth (truncated to month)
     - TotalSales, TotalOrders, and TotalQuantities.*/

-- Create View
CREATE VIEW Sales.V_Monthly_Summary AS
(
    SELECT 
        DATETRUNC(month, OrderDate) AS OrderMonth,
        SUM(Sales) AS TotalSales,
        COUNT(OrderID) AS TotalOrders,
        SUM(Quantity) AS TotalQuantities
    FROM Sales.Orders
    GROUP BY DATETRUNC(month, OrderDate)
);
GO

-- Query the View
SELECT * FROM Sales.V_Monthly_Summary;

-- Drop View if it exists
IF OBJECT_ID('Sales.V_Monthly_Summary', 'V') IS NOT NULL
    DROP VIEW Sales.V_Monthly_Summary;
GO

-- Re-create the view with modified logic
CREATE VIEW Sales.V_Monthly_Summary AS
SELECT 
    DATETRUNC(month, OrderDate) AS OrderMonth,
    SUM(Sales) AS TotalSales,
    COUNT(OrderID) AS TotalOrders
FROM Sales.Orders
GROUP BY DATETRUNC(month, OrderDate);
GO

-- VIEW USE CASE - HIDE COMPLEXITY

-- Provide the view that combines details from orders , products, customers and employees.

CREATE VIEW Sales.VIEW_ORDER_DETAILS AS(
	SELECT o.OrderID, o.OrderDate, p.Product, p.Category,
			COALESCE(c.FirstName, '') + ' ' + COALESCE(c.LastName, '') AS CustomerName,
			c.Country AS CustomerCountry,
			COALESCE(e.FirstName, '') + ' ' + COALESCE(e.LastName, '') AS SalesName,
			e.Department, o.Sales, o.Quantity FROM Sales.Orders o 
		LEFT JOIN Sales.Customers c ON o.CustomerID = c.CustomerID
		LEFT JOIN Sales.Products p ON o.CustomerID = c.CustomerID
		LEFT JOIN Sales.Employees e ON o.CustomerID = e.EmployeeID );
GO

-- VIEW USE CASE - DATA SECURITY

-- Create a view for the EU Sales Team that combines details from all tables, but excludes data related to the USA.

CREATE VIEW Sales.VIEW_EU_ORDER_DETAILS AS(
	SELECT o.OrderID, o.OrderDate, p.Product, p.Category,
			COALESCE(c.FirstName, '') + ' ' + COALESCE(c.LastName, '') AS CustomerName,
			c.Country AS CustomerCountry,
			COALESCE(e.FirstName, '') + ' ' + COALESCE(e.LastName, '') AS SalesName,
			e.Department, o.Sales, o.Quantity FROM Sales.Orders o 
		LEFT JOIN Sales.Customers c ON o.CustomerID = c.CustomerID
		LEFT JOIN Sales.Products p ON o.CustomerID = c.CustomerID
		LEFT JOIN Sales.Employees e ON o.CustomerID = e.EmployeeID
	WHERE Country !=  'USA'
);
GO

-- VIEW USE CASE - FLEXIBILITY AND DYNAMIC

-- VIEW USE CASE - VIRTUAL DATA MART IN DATA WAREHOUSE