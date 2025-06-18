-- LEAD()/LAG() Functions

-- Use Case : Time Series Analysis

-- Analyze the month-over-month(MoM) by finding the percentage change in sales between the current and previous month

SELECT *, CurrentMonthSales - PreviousMonthSales AS MoM_Change,
    ROUND(CAST((CurrentMonthSales - PreviousMonthSales) AS FLOAT)/ PreviousMonthSales * 100, 1) AS MoM_Perc
FROM (SELECT MONTH(OrderDate) AS OrderMonth, SUM(Sales) AS CurrentMonthSales,
        LAG(SUM(Sales)) OVER (ORDER BY MONTH(OrderDate)) AS PreviousMonthSales FROM Sales.Orders
    GROUP BY MONTH(OrderDate)
) AS MonthlySales;

-- Use Case : Customer Retention Analysis

-- Analyze customer loyalty by ranking customers based on the average numbers of days between orders

SELECT CustomerID, AVG(DaysUntilNextOrder) AS AvgDays,
    RANK() OVER (ORDER BY COALESCE(AVG(DaysUntilNextOrder), 999999)) AS RankAvg
FROM ( SELECT OrderID, CustomerID, OrderDate AS CurrentOrder,
        LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS NextOrder,
        DATEDIFF(day,OrderDate,LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate)) AS DaysUntilNextOrder
    FROM Sales.Orders) AS CustomerOrdersWithNext GROUP BY CustomerID;

-- FIRST_VALUE()/LAST_VALUE Functions

-- Find the lowest and highest sales for each products

SELECT OrderID, OrderDate, Sales,ProductID,
	FIRST_VALUE(Sales) OVER (ORDER BY ProductID ,Sales) AS Lowest_Sales,
	LAST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS Highest_Sales,
	Sales - FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales) AS SalesDifference
FROM Sales.Orders