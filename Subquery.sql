--  SUBQUERY - RESULT TYPES

-- Scalar Query

SELECT AVG(Sales) FROM Sales.Orders;

-- Row Query

SELECT CustomerID FROM Sales.Orders;

-- Table Query

SELECT OrderID, OrderDate FROM Sales.Orders;

-- SUBQUERY - FROM Clause

-- Find the products that have a price higher than the average price of all products

SELECT * FROM(
SELECT ProductID, Product, Price, AVG(Price) OVER () AS AVG_Price FROM Sales.Products)t 
WHERE Price > AVG_Price;

-- Rank customers based on their total amount of sales
SELECT *, RANK() OVER(ORDER BY Total_Sales DESC) AS Customer_Rank FROM (
SELECT CustomerID, SUM(Sales) AS Total_Sales FROM Sales.Orders GROUP BY CustomerID )t;

-- SUBQUERY - SELECT Clause

-- Show the product ids , names, price and total number of orders.

SELECT ProductID, Product, Price,
    (SELECT COUNT(*) FROM Sales.Orders) AS TotalOrders 
FROM Sales.Products;

-- SUBQUERY - JOIN Clause

-- Show all customer details and find the total orders for each customers

SELECT c.*, o.TotalOrders
FROM Sales.Customers AS c
LEFT JOIN (SELECT CustomerID, COUNT(*) AS TotalOrders FROM Sales.Orders GROUP BY CustomerID) AS o
ON c.CustomerID = o.CustomerID;

-- SUBQUERY - WHERE Clause

-- Comparison Operator
-- Find the products that have a price higher than the average price of all products

SELECT ProductID , Price FROM Sales.Products WHERE Price > (SELECT AVG(Price) AS avg_price FROM Sales.Products);

-- IN/NOT IN Operators
-- Show the details of orders made by customers in Germany

SELECT * FROM Sales.Orders WHERE CustomerID IN (SELECT CustomerID FROM Sales.Customers WHERE Country = 'Germany');

-- Show the details of orders made by customers who are not from Germany

SELECT * FROM Sales.Orders WHERE CustomerID  NOT IN (SELECT CustomerID FROM Sales.Customers WHERE Country = 'Germany');

-- ANY/ALL Operators
-- Find female employees whose salaries are greater than the salaries of any male employees.

SELECT EmployeeID, FirstName, Gender, Salary FROM Sales.Employees WHERE Gender = 'F' AND Salary > ANY(
SELECT Salary FROM Sales.Employees WHERE Gender = 'M' )

-- Find female employees whose salaries are greater than the salaries of all male employees.

SELECT EmployeeID, FirstName, Gender, Salary FROM Sales.Employees WHERE Gender = 'F' AND Salary > ALL(
SELECT Salary FROM Sales.Employees WHERE Gender = 'M' )

-- Correlated/Non-Correlated Subquery

-- Show all customer details and find the total orders for each customers

SELECT *, (SELECT COUNT(*) FROM Sales.Orders o WHERE o.CustomerID = c.CustomerID) AS Total_Orders FROM Sales.Customers c

-- EXISTS Operator

-- Show the details of orders made by customers in Germany

SELECT * FROM Sales.Orders AS o WHERE EXISTS ( SELECT * FROM Sales.Customers AS c WHERE Country = 'Germany' AND 
c.CustomerID = o.CustomerID)