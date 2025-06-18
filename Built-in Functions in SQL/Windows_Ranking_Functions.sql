-- Interger Based Ranking Functions

-- ROW_NUMBER() Function

-- Rank the orders based on their sales from highest to lowest

SELECT OrderID, Sales ,ProductID, ROW_NUMBER() OVER(ORDER BY Sales DESC) AS Sales_rank FROM Sales.Orders;

-- RANK() Function

-- Rank the orders based on their sales from highest to lowest

SELECT OrderID, Sales ,ProductID, RANK() OVER(ORDER BY Sales DESC) AS Sales_rank FROM Sales.Orders;

-- DENSE_RANK() Function

-- Rank the orders based on their sales from highest to lowest

SELECT OrderID, Sales ,ProductID, DENSE_RANK() OVER(ORDER BY Sales DESC) AS Sales_rank FROM Sales.Orders;

-- ROW_NUMBER Use Case : TOP-N Analysis

-- Find the top highest sales for each product

SELECT * FROM(
	SELECT OrderID, Sales ,ProductID, ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) AS RankByProduct
	FROM Sales.Orders)t 
WHERE RankByProduct = 1;

-- ROW_NUMBER Use Case : BOTTOM-N Analysis

-- Find the lowest 2 customers based on their total sales

SELECT * FROM (
    SELECT CustomerID, SUM(Sales) AS TotalSales, ROW_NUMBER() OVER (ORDER BY SUM(Sales)) AS RankCustomers
    FROM Sales.Orders
    GROUP BY CustomerID
) AS BottomCustomerSales WHERE RankCustomers <= 2;

-- ROW_NUMBER Use Case : Generate Unique IDs

-- Assign Unique IDs to the Rows of the 'Order Archive'

SELECT OrderID, OrderDate, ROW_NUMBER() OVER (ORDER BY OrderID , OrderDate) AS UniqueID
    FROM Sales.OrdersArchive

-- ROW_NUMBER Use Case : Identify Duplicates

-- Identify Duplicate Rows in 'Order Archive' and return a clean result without any duplicates

SELECT * FROM (SELECT ROW_NUMBER() OVER (PARTITION BY OrderID ORDER BY CreationTime DESC) AS rn,
        * FROM Sales.OrdersArchive
) AS UniqueOrdersArchive
WHERE rn = 1;

-- NTILE Function

-- Divide Orders into Groups Based on Sales

SELECT OrderID, Sales, ProductID,
    NTILE(1) OVER (ORDER BY Sales) AS OneBucket,
    NTILE(2) OVER (ORDER BY Sales) AS TwoBuckets,
    NTILE(3) OVER (ORDER BY Sales) AS ThreeBuckets,
    NTILE(4) OVER (ORDER BY Sales) AS FourBuckets,
    NTILE(2) OVER (PARTITION BY ProductID ORDER BY Sales) AS TwoBucketByProducts
FROM Sales.Orders;

-- Use Case : Data Segmentation

-- Segment all Orders into 3 Categories: High, Medium, and Low Sales.

SELECT
    OrderID,
    Sales,
    Buckets,
    CASE 
        WHEN Buckets = 1 THEN 'High'
        WHEN Buckets = 2 THEN 'Medium'
        WHEN Buckets = 3 THEN 'Low'
    END AS SalesSegmentations
FROM (
    SELECT
        OrderID,
        Sales,
        NTILE(3) OVER (ORDER BY Sales DESC) AS Buckets
    FROM Sales.Orders
) AS SalesBuckets;

-- Use Case : Equalizing Loads

-- In order to export the data , divide the orders into 2 groups

SELECT
        *,
        NTILE(2) OVER ( ORDER BY OrderID) AS Buckets
    FROM Sales.Orders

-- Percentage Based Ranking Functions

-- CUME_DIST Function

-- PERCENT_RANK Function

-- Find the products that falls within the highest 40% of prices

SELECT Product, Price, DistRank,
    CONCAT(DistRank * 100, '%') AS DistRankPerc
FROM ( SELECT Product, Price,
        CUME_DIST() OVER (ORDER BY Price DESC) AS DistRank FROM Sales.Products
) AS PriceDistribution
WHERE DistRank <= 0.4;