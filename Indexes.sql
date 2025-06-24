-- Indexes

-- Structured Index - 1. Clustered Index

-- Create a Heap Table as a copy of Sales.Customers. Create a Clustered Index on Sales.DBCustomers using CustomerID
SELECT * INTO Sales.DBCustomers FROM Sales.Customers;
SELECT * FROM Sales.DBCustomers WHERE CustomerID = 1;

CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers (CustomerID);

-- Attempt to create a second Clustered Index on the same table (will fail) 
CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers (CustomerID);

-- Drop the Clustered Index 
DROP INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers;

-- Structured Index - 2. Non-Clustered Index

-- Create a Non-Clustered Index on LastName
SELECT * FROM Sales.DBCustomers WHERE LastName = 'Brown';

CREATE NONCLUSTERED INDEX idx_DBCustomers_LastName
ON Sales.DBCustomers (LastName);

-- Create an additional Non-Clustered Index on FirstName
CREATE INDEX idx_DBCustomers_FirstName
ON Sales.DBCustomers (FirstName);

-- Composite Index

-- Create a Composite Index on Country and Score 
CREATE INDEX idx_DBCustomers_CountryScore
ON Sales.DBCustomers (Country, Score);

-- Query that uses the Composite Index
SELECT * FROM Sales.DBCustomers WHERE Country = 'USA' AND Score > 500;

-- Query that likely won't use the Composite Index due to column order
SELECT * FROM Sales.DBCustomers WHERE Score > 500 AND Country = 'USA';

-- Storage Index - 1. Rowstore Index

-- Storage Index - 2. Columnstore Index

-- Create a Clustered Columnstore Index on Sales.DBCustomers

-- If already created then delete it first
DROP INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers;

-- Now Create
CREATE CLUSTERED COLUMNSTORE INDEX idx_DBCustomers_CS
ON Sales.DBCustomers;
GO

-- Create a Non-Clustered Columnstore Index on the FirstName column
CREATE NONCLUSTERED COLUMNSTORE INDEX idx_DBCustomers_CS_FirstName
ON Sales.DBCustomers (FirstName);
GO

-- Unique Index

-- Create a Unique Index on the Category column in Sales.Products. Note: This may fail if duplicate values exist.

CREATE UNIQUE INDEX idx_Products_Category
ON Sales.Products (Category);
  
-- Create a Unique Index on the Product column in Sales.Products
CREATE UNIQUE INDEX idx_Products_Product
ON Sales.Products (Product);
  
-- Insert a duplicate value (should fail if the constraint is enforced)
INSERT INTO Sales.Products (ProductID, Product) VALUES (106, 'Caps');

-- Filtered Index

-- Select Customers where Country is 'USA' 
SELECT * FROM Sales.Customers WHERE Country = 'USA';
  
-- Create a Non-Clustered Filtered Index on the Country column for rows where Country = 'USA'
CREATE NONCLUSTERED INDEX idx_Customers_Country
ON Sales.Customers (Country)
WHERE Country = 'USA';

-- Index Management

-- List all the indexes on specific table

sp_helpindex'Sales.DBCustomers'

-- Monitor Index Usage

SELECT 
	tbl.name AS TableName,
    idx.name AS IndexName,
    idx.type_desc AS IndexType,
    idx.is_primary_key AS IsPrimaryKey,
    idx.is_unique AS IsUnique,
    idx.is_disabled AS IsDisabled,
    s.user_seeks AS UserSeeks,
    s.user_scans AS UserScans,
    s.user_lookups AS UserLookups,
    s.user_updates AS UserUpdates,
    COALESCE(s.last_user_seek, s.last_user_scan) AS LastUpdate
FROM sys.indexes idx
JOIN sys.tables tbl
    ON idx.object_id = tbl.object_id
LEFT JOIN sys.dm_db_index_usage_stats s
    ON s.object_id = idx.object_id
    AND s.index_id = idx.index_id
ORDER BY tbl.name, idx.name;

-- Monitor Missing Indexes

SELECT * FROM sys.dm_db_missing_index_details;

-- Monitor Duplicate Indexes

SELECT  
	tbl.name AS TableName,
	col.name AS IndexColumn,
	idx.name AS IndexName,
	idx.type_desc AS IndexType,
	COUNT(*) OVER (PARTITION BY  tbl.name , col.name ) ColumnCount
FROM sys.indexes idx
JOIN sys.tables tbl ON idx.object_id = tbl.object_id
JOIN sys.index_columns ic ON idx.object_id = ic.object_id AND idx.index_id = ic.index_id
JOIN sys.columns col ON ic.object_id = col.object_id AND ic.column_id = col.column_id
ORDER BY ColumnCount DESC

-- Update Statistics

SELECT 
    SCHEMA_NAME(t.schema_id) AS SchemaName,
    t.name AS TableName,
    s.name AS StatisticName,
    sp.last_updated AS LastUpdate,
    DATEDIFF(day, sp.last_updated, GETDATE()) AS LastUpdateDay,
    sp.rows AS 'Rows',
    sp.modification_counter AS ModificationsSinceLastUpdate
FROM sys.stats AS s
JOIN sys.tables AS t
    ON s.object_id = t.object_id
CROSS APPLY sys.dm_db_stats_properties(s.object_id, s.stats_id) AS sp
ORDER BY sp.modification_counter DESC;

-- Update statistics for a specific automatically created system statistic
UPDATE STATISTICS Sales.DBCustomers _WA_Sys_00000001_6EF57B66;
GO

-- Update all statistics for the Sales.DBCustomers table
UPDATE STATISTICS Sales.DBCustomers;
GO

-- Update statistics for all tables in the database
EXEC sp_updatestats;
GO

-- Monitor Indexes Fragmentation

-- 1. Reorganize

SELECT 
    tbl.name AS TableName,
    idx.name AS IndexName,
    s.avg_fragmentation_in_percent,
    s.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') AS s
INNER JOIN sys.tables tbl 
    ON s.object_id = tbl.object_id
INNER JOIN sys.indexes AS idx 
    ON idx.object_id = s.object_id
    AND idx.index_id = s.index_id
ORDER BY s.avg_fragmentation_in_percent DESC;

-- Reorganize the index (lightweight defragmentation)
ALTER INDEX idx_Customers_CS_Country 
ON Sales.Customers REORGANIZE;
GO

-- 2. Rebuild 

-- Rebuild the index (full rebuild, more resource-intensive)
ALTER INDEX idx_Customers_Country 
ON Sales.Customers REBUILD;
GO