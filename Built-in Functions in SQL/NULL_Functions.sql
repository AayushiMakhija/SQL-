-- 1. ISNULL() and COALESCE()

-- Handle NULL - Data Aggregation

-- Find the average scores of the customers

SELECT CustomerID, Score,
    COALESCE(Score, 0) AS Score2,
    AVG(Score) OVER () AS AvgScores,
    AVG(COALESCE(Score, 0)) OVER () AS AvgScores2
FROM Sales.Customers;

-- Handle NULL - Mathematical Operations

/* Display the full name of customers in a single field by merging their first and last names, and add 10 bonus points to each 
customer's score. */

SELECT CustomerID , FirstName ,LastName , Score,
	FirstName +' '+ COALESCE(LastName , ' ') AS FullName,
	COALESCE(Score ,0) +10 AS Bonus_Scores
FROM Sales.Customers

-- Handle NULL - Sorting Data

-- Sort the customers from lowest to highest scores, with NULL values appearing last.

SELECT CustomerID, Score
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score;

-- 2. NULLIF

-- Use Case : Dividing by Zero

-- Find the sales price for each order by dividing sales by quantity. Uses NULLIF to avoid division by zero.

SELECT OrderID, Sales, Quantity, Sales / NULLIF (Quantity,0) AS Price FROM Sales.Orders;

-- 3. IS NULL / IS NOT NULL

-- Use Case : Filtering Data

-- Identify the customers who have no scores.

Select * FROM Sales.Customers WHERE Score IS NULL;

-- Show all the customers who have scores.

SELECT * FROM Sales.Customers WHERE Score IS NOT NULL;

-- Use Case : Anti Joins

-- List all deatials for customers who have not placed any orders

SELECT c.*, o.OrderID FROM Sales.Customers AS c LEFT JOIN Sales.Orders AS o ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL;

-- Demonstrate differences between NULL, empty strings, and blank spaces 

WITH Orders AS (
    SELECT 1 AS Id, 'A' AS Category UNION
    SELECT 2, NULL UNION
    SELECT 3, '' UNION
    SELECT 4, '  '
)
SELECT 
    *,
    DATALENGTH(Category) AS LenCategory,
    TRIM(Category) AS Policy1,
    NULLIF(TRIM(Category), '') AS Policy2,
    COALESCE(NULLIF(TRIM(Category), ''), 'unknown') AS Policy3
FROM Orders;