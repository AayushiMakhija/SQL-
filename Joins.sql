-- No Join

-- Retrieve all data from customers and orders as separate results

SELECT * FROM customers;
SELECT * FROM orders;

-- Inner Join

-- Get all the customers along with their orders but only for customers who have placed an orders

SELECT c.id, c.first_name , o.order_id , o.sales FROM customers AS c INNER JOIN orders AS o ON c.id = o.customer_id 

-- Left Join

-- Get all customers along with their orders including those without orders

SELECT c.id, c.first_name , o.order_id , o.sales FROM customers AS c LEFT JOIN orders AS o ON c.id = o.customer_id

-- Get all customers along with their orders, including orders without mathcing the customers

SELECT c.id, c.first_name , o.order_id , o.sales FROM orders AS o LEFT JOIN customers AS c ON c.id = o.customer_id

-- Right Join

-- Get all customers along with their orders, including orders without mathcing the customers

SELECT c.id, c.first_name , o.order_id , o.sales FROM customers AS c RIGHT JOIN orders AS o ON c.id = o.customer_id

-- Get all customers along with their orders including those without orders

SELECT c.id, c.first_name , o.order_id , o.sales FROM orders AS o RIGHT JOIN customers AS c ON c.id = o.customer_id

-- Full Join

-- Get all the customers and all the orders, even if there's no match

SELECT c.id, c.first_name , o.order_id , o.sales FROM customers AS c FULL JOIN orders AS o ON c.id = o.customer_id

-- Left Anti Join

-- Get all customers who haven't placed orders

SELECT c.id, c.first_name , o.order_id , o.sales FROM customers AS c LEFT JOIN orders AS o ON c.id = o.customer_id WHERE o.customer_id IS NULL

-- Get all the orders without matching customers

SELECT c.id, c.first_name , o.order_id , o.sales FROM orders AS o LEFT JOIN customers AS c ON c.id = o.customer_id WHERE c.id IS NULL

-- Right Anti Join

-- Get all the orders without matching customers

SELECT c.id, c.first_name , o.order_id , o.sales FROM customers AS c RIGHT JOIN orders AS o ON c.id = o.customer_id WHERE C.id IS NULL

-- Get all customers who haven't placed orders

SELECT c.id, c.first_name , o.order_id , o.sales FROM orders AS o RIGHT JOIN customers AS c ON c.id = o.customer_id WHERE o.customer_id IS NULL

-- Full Anti Join

-- Get all the customers without orders and orders without customers

SELECT c.id, c.first_name , o.order_id , o.sales FROM customers AS c FULL JOIN orders AS o ON c.id = o.customer_id where c.id IS NULL OR o.customer_id IS NULL

-- Tasks

-- Get all the customers along with their orders , but only for customers who have plced there orders (Without using INNER JOIN)

SELECT c.id, c.first_name , o.order_id , o.sales FROM customers AS c FULL JOIN orders AS o ON c.id = o.customer_id where c.id = o.customer_id

-- Cross Join (Cartesian Join)

-- Generate all the possible combinations of customers and orders

SELECT * FROM customers CROSS JOIN orders

-- Task

/* Using SalesDB, retrieve a list of all orders , along with the related customers, products and employees details.
For each order display:
1. Order ID
2. Customer's Name
3.Product name
4. Sales Amount
5.Product Price
6. Salesperson's Name
*/

USE SalesDB

SELECT o.OrderID,
o.Sales AS Sales_Amount,
c.FirstName AS CustomerFirstName,
c.LastName AS CustomerLastName,
p.Product AS Product_Name,
e.FirstName AS SalesPerson_FirstName,
e.LastName AS SalesPerson_LastName,
p.Price AS Product_Price
FROM Sales.Orders AS o 
LEFT JOIN Sales.Customers AS c ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p ON o.ProductID = p.ProductID 
Left JOIN Sales.Employees AS e ON o.SalesPersonID = e.EmployeeID