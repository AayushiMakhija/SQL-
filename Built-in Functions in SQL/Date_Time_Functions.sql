/* Three ways to get date and time : 
1. From the column which contains the data of datatype date and time.
2. By hardcoded data
3. By using function GETDATE()
*/

SELECT OrderID, CreationTime, 
	'2025-08-20' AS HardCoded,
	GETDATE() AS Today
FROM Sales.Orders;

-- Manipulation of date and time can be done by following functions:

-- Part Extraction Functions

-- 1. DAY() & MONTH() & YEAR()

-- Separate the day,month and year of the date of creation time 

SELECT OrderID, CreationTime,
	  DAY(CreationTime) AS DAY,
	  MONTH(CreationTime) AS MONTH,
	  YEAR(CreationTime) AS YEAR
FROM Sales.Orders;

-- 2. DATEPART()

-- Retrieve different parts of date and time of creation time 

SELECT OrderID, CreationTime,
	  DATEPART( day ,CreationTime) AS DAY_dp,
	  DATEPART(month ,CreationTime) AS MONTH_dp,
	  DATEPART(year , CreationTime) AS YEAR_dp,
	  DATEPART(hour , CreationTime) AS HOUR_dp,
	  DATEPART(minute , CreationTime) AS MINUTE_dp,
	  DATEPART(second , CreationTime) AS SECOND_dp,
	  DATEPART(quarter , CreationTime) AS QUARTER_dp,
	  DATEPART(week , CreationTime) AS WEEK_dp
FROM Sales.Orders;

-- 3. DATENAME()

-- Retrieve month name and weekday name from the Creation time

SELECT OrderID, CreationTime,
	  DATENAME(month, CreationTime) AS MONTH_dn,
	  DATENAME(weekday, CreationTime) AS WEEKDAY_dn
FROM Sales.Orders;

-- 4. DATETRUNC()

-- Truncate the date and time of creation time to minutes .

SELECT OrderID, CreationTime,
	  DATETRUNC(minute, CreationTime) AS DandT_MIN
FROM Sales.Orders;

-- 5. EOMONTH()

-- Change the date to end of the month date

SELECT OrderID, CreationTime,
	  EOMONTH(CreationTime) AS EOMONTH_CT
FROM Sales.Orders;

-- Task

-- How many orders were placed each year

SELECT DATEPART(year, OrderDate) AS Years, COUNT(*) AS orders_per_year FROM Sales.Orders GROUP BY DATEPART(year, OrderDate);

-- How many orders were placed each month

SELECT DATENAME(month, OrderDate) AS Months, COUNT(*) AS orders_per_year FROM Sales.Orders GROUP BY DATENAME(month, OrderDate);

-- Show all orders that were placed during the month of February

SELECT * FROM Sales.Orders WHERE MONTH(OrderDate) = 2;

-- Format and Casting

-- 1. FORMAT()

-- Change the creation time format into different formats

SELECT OrderID, CreationTime, 
	FORMAT(CreationTime,'MM-dd-yyyy') AS USA_Format,
	FORMAT(CreationTime,'dd-MM-yyyy') AS Europe_Format,
	FORMAT(CreationTime,'dd') AS DD,
	FORMAT(CreationTime,'ddd') AS DDD,
	FORMAT(CreationTime,'dddd') AS DDDD,
	FORMAT(CreationTime,'MM') AS MM,
	FORMAT(CreationTime,'MMM') AS MMM,
	FORMAT(CreationTime,'MMMM') AS MMMM
FROM Sales.Orders;

-- Task

-- Display CreationTime using a custom format: Example: Day Wed Jan Q1 2025 12:34:56 PM

SELECT OrderID, CreationTime, 
	'Day ' + FORMAT(CreationTime, 'ddd MMM') 
	+ ' Q' + DATENAME(quarter, CreationTime) + FORMAT(CreationTime, ' yyyy hh:mm:ss tt') AS Custom_date
FROM Sales.Orders;

-- How many orders were placed each year, formatted by month and year (e.g., "Jan 25")?

SELECT
    FORMAT(CreationTime, 'MMM yy') AS OrderDate,
    COUNT(*) AS TotalOrders
FROM Sales.Orders
GROUP BY FORMAT(CreationTime, 'MMM yy');

-- 2. CONVERT()

-- Demonstrate conversion using CONVERT.

SELECT
    CONVERT(INT, '123') AS [String to Int CONVERT],
    CONVERT(DATE, '2025-08-20') AS [String to Date CONVERT],
    CreationTime,
    CONVERT(DATE, CreationTime) AS [Datetime to Date CONVERT],
    CONVERT(VARCHAR, CreationTime, 32) AS [USA Std. Style:32],
    CONVERT(VARCHAR, CreationTime, 34) AS [EURO Std. Style:34]
FROM Sales.Orders;

-- 3. CAST()

-- Convert data types using CAST.

SELECT
    CAST('123' AS INT) AS [String to Int],
    CAST(123 AS VARCHAR) AS [Int to String],
    CAST('2025-08-20' AS DATE) AS [String to Date],
    CAST('2025-08-20' AS DATETIME2) AS [String to Datetime],
    CreationTime,
    CAST(CreationTime AS DATE) AS [Datetime to Date]
FROM Sales.Orders;

-- Calculations

-- 1. DATEADD()

-- Perform date arithmetic on OrderDate.

SELECT OrderID, OrderDate,
    DATEADD(day, -10, OrderDate) AS TenDaysBefore,
    DATEADD(month, 3, OrderDate) AS ThreeMonthsLater,
    DATEADD(year, 2, OrderDate) AS TwoYearsLater
FROM Sales.Orders;

-- 2. DATEDIFF()

-- Calculate the age of employees

SELECT EmployeeID ,BirthDate,FORMAT(GETDATE() , 'yy-MM-dd') AS TODAY, DATEDIFF(YEAR , BirthDate , GETDATE()) AS AGE FROM Sales.Employees;

-- Find the average shipping duration in days for each month

SELECT MONTH (OrderDate) AS Order_date, AVG(DATEDIFF(DAY , OrderDate , ShipDate)) AS Avg_Durations FROM Sales.Orders GROUP BY MONTH (OrderDate);

--Time Gap Analysis
-- Find the number of days between each order and previous order

SELECT OrderID, OrderDate AS CurrentOrderDate,
    LAG(OrderDate) OVER (ORDER BY OrderDate) AS PreviousOrderDate,
    DATEDIFF(day, LAG(OrderDate) OVER (ORDER BY OrderDate), OrderDate) AS NoOfDays
FROM Sales.Orders;

-- Date Validation

-- 1. ISDATE()

-- Validate OrderDate using ISDATE and convert valid dates.

SELECT
    OrderDate,
    ISDATE(OrderDate) AS IsValidDate,
    CASE 
        WHEN ISDATE(OrderDate) = 1 THEN CAST(OrderDate AS DATE)
        ELSE '9999-01-01'
    END AS NewOrderDate
FROM (
    SELECT '2025-08-20' AS OrderDate UNION
    SELECT '2025-08-21' UNION
    SELECT '2025-08-23' UNION
    SELECT '2025-08'
) AS t;
-- WHERE ISDATE(OrderDate) = 0;
