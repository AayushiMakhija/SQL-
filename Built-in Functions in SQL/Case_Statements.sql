-- Use Case : Categorizing Data

/* Create a report showing total sales for each category:
	   - High: Sales over 50
	   - Medium: Sales between 20 and 50
	   - Low: Sales 20 or less
   The results are sorted from highest to lowest total sales.
*/

SELECT
    Category,
    SUM(Sales) AS TotalSales
FROM (
	SELECT OrderID, Sales ,
	CASE 
		WHEN Sales> 50 THEN 'High'
		WHEN Sales > 20 THEN 'Medium'
		ELSE 'Low'
	END AS Category
	FROM Sales.Orders)t
GROUP BY Category ORDER BY TotalSales DESC ;

-- Use Case : Mapping Values

-- Retrieve employees details with gender displayed as full text

SELECT EmployeeID, FirstName, LastName, Gender,
CASE 
	WHEN Gender = 'F' THEN 'Female'
	WHEN Gender = 'M' THEN 'Male'
	ELSE 'Not Available'
END AS Gender_full_text
FROM Sales.Employees;

-- Retrieve customer details with abbreviated country codes 

SELECT * ,
Case 
	WHEN Country = 'Germany' THEN 'DE'
        WHEN Country = 'USA'     THEN 'US'
        ELSE 'n/a'
END AS Country_Code
FROM Sales.Customers;

-- Quick from Syntax

SELECT * ,
Case Country
	WHEN 'Germany' THEN 'DE'
    WHEN 'USA' THEN 'US'
    ELSE 'n/a'
END AS Country_Code
FROM Sales.Customers;

-- Use Case : Handling NULL

-- Find the average scores of customers, treating NULL as 0, and provide CustomerID and LastName details.

SELECT CustomerID , LastName , Score ,
AVG(CASE
		WHEN Score IS NULL THEN 0
		ELSE Score
	END) OVER () AS AvgScores
FROM Sales.Customers;

-- Use Case : Conditional Aggregation

-- Count how many times each customer has made an order with sales greater than 30.

SELECT CustomerID,
    SUM(
        CASE
            WHEN Sales > 30 THEN 1
            ELSE 0
        END
    ) AS TotalOrdersHighSales,
    COUNT(*) AS TotalOrders
FROM Sales.Orders
GROUP BY CustomerID;
