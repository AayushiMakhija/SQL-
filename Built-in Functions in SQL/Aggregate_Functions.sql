-- Find the total number of customers

SELECT COUNT(*) AS TotalCustomers FROM Sales.Customers;

-- Find the total number of orders

SELECT COUNT(*) AS TotalOrders FROM Sales.Orders;

-- Find the total sales of all orders

SELECT SUM(Sales) AS TotalSales FROM Sales.Orders;

-- Find the average sales of all orders

SELECT AVG(Sales) AS AvgSales FROM Sales.Orders;

-- Find the highest score among all the customers

SELECT MAX(Score) AS HighestScore FROM Sales.Customers;

-- Find the lowest score among all the customers

SELECT MIN(Score) AS LowestScore FROM Sales.Customers;

