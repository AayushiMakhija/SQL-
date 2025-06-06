-- Create a table that contains the order details and it is in un-normalised form

CREATE TABLE orders_detail (
    OrderID INT,
    CustomerName VARCHAR(100),
    CustomerAddress VARCHAR(255),
    ProductID VARCHAR(10),
    ProductName VARCHAR(100),
    Quantity INT,
    ProductPrice DECIMAL(10, 2),
    TotalAmount DECIMAL(10, 2)
);

-- Insert the values in the order details table 

INSERT INTO orders_detail(OrderID, CustomerName, CustomerAddress, ProductID, ProductName, Quantity, ProductPrice, TotalAmount)
VALUES
(101, 'Alice', '123 Main St, NY', 'P01', 'Keyboard', 2, 500.00, 1000.00),
(102, 'Bob', '55 West Ave, LA', 'P02', 'Mouse', 1, 200.00, 200.00),
(103, 'Alice', '123 Main St, NY', 'P02', 'Mouse', 3, 200.00, 600.00);

SELECT * FROM orders_detail

-- Perform the normalisation on the orders_detail table

-- Check for 1NF:

SELECT * FROM orders_detail

-- The orders_detail table is in 1NF because there is no cell which contains the multiple values.

-- Check for 2NF:

SELECT * FROM orders_detail

/* The order_detail table is not in 2NF because there is a partial dependency between the OrderID and CustomerName, CustomerAddress
and between ProductID and ProductName, ProductPrice. So to convert the table in 2NF , we have to decompose the table into : 
1. Order_D = OrderID and CustomerName
2. Product_D = ProductID , ProductName and ProductPrice
3. Quantity_D = OrderID , ProductID and Quantity
4. Customer_D = CustomerName and CustomerAddress*/

CREATE TABLE Order_D(
	OrderID INT PRIMARY KEY,
	CustomerName Varchar(100))

INSERT INTO Order_D(OrderID, CustomerName) SELECT OrderID , CustomerName FROM orders_detail

SELECT * FROM Order_D

CREATE TABLE Product_D(
	ProductID VARCHAR(10) PRIMARY KEY,
	ProductName VARCHAR(100) ,
	ProductPrice DECIMAL(10, 2))

INSERT INTO Product_D(ProductID , ProductName , ProductPrice) SELECT DISTINCT ProductID , ProductName , ProductPrice FROM orders_detail

SELECT * FROM Product_D

CREATE TABLE Quantity_D(
	OrderID INT,
	ProductID VARCHAR(10),
	Quantity INT,
	PRIMARY KEY (OrderID , ProductID)
)

INSERT INTO Quantity_D(OrderID, ProductID, Quantity) SELECT OrderID, ProductID ,Quantity FROM orders_detail

SELECT * FROM Quantity_D

CREATE TABLE Customer_D(
	CustomerName VARCHAR(100),
	CustomerAddress VARCHAR(255)
	)

INSERT INTO Customer_D(CustomerName, CustomerAddress) SELECT DISTINCT CustomerName, CustomerAddress FROM orders_detail

SELECT * FROM Customer_D

-- Now the table is in 2NF 

-- Check for 3NF

/* We have the only transitivity between the OrderID , CustomerName and CustomerAddress which is removed by creating the table 
Order_D and Customer_D*/

SELECT * FROM Order_D

SELECT * FROM Customer_D

-- Now the table is in 3NF 

-- Check for BCNF

/* There is no prime attribute which can be derived from the other prime or non prime attributes.All functional dependencies in
each table have their determinant (left-hand side) as a super key. So the table is now in BCNF */

-- Now the orders_detail table is in normalised form and we have the following tables:

SELECT * FROM Order_D

SELECT * FROM Product_D

SELECT * FROM Quantity_D

SELECT * FROM Customer_D