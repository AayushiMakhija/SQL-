--Comparison Operator

-- Retrieve all customers from Germany

SELECT * FROM customers WHERE country = 'Germany'

-- Retrieve all customers who are not from Germany

SELECT * FROM customers WHERE country != 'Germany'
SELECT * FROM customers WHERE country <> 'Germany'

-- Retrieve all customers with a score greater than 500

SELECT * FROM customers WHERE score >500

-- Retrieve all customers with a score of 500 or more

SELECT * FROM customers WHERE score >=500

-- Retrieve all customers with a score less than 500

SELECT * FROM customers WHERE score < 500

-- Retrieve all customers with a score of 500 or less

SELECT * FROM customers WHERE score <= 500

-- Logical Operator

-- Retrieve all customers who are from USA and have a score greater than 500

SELECT * FROM customers WHERE country = 'USA' AND score > 500

-- Retrieve all customers who are either from USA or have a score greater than 500

SELECT * FROM customers WHERE country = 'USA' OR score > 500

-- Retrieve all customers with a score not less than 500

SELECT * FROM customers WHERE NOT score < 500

-- Range Operator

-- Retrieve all the customers whose score falls in the range between 100 to 500

SELECT * FROM customers WHERE score BETWEEN 100 AND 500
SELECT * FROM customers WHERE score >= 100 AND score <= 500

-- Retrieve all the customers whose score falls not in the range between 100 to 500

SELECT * FROM customers WHERE score NOT BETWEEN 100 AND 500

-- Membership Operators

-- Retrieve all customers from either Germany or USA

SELECT * FROM customers WHERE country IN ('Germany', 'USA')
SELECT * FROM customers WHERE country = 'Germany' OR country = 'USA'

-- Retrieve all customers that are not from Germany and USA

SELECT * FROM customers WHERE country NOT IN ('Germany', 'USA')
SELECT * FROM customers WHERE country != 'Germany' AND country != 'USA'

-- Search Operator

-- Find all customers whose first name starts with 'M'

SELECT * FROM customers WHERE first_name LIKE ('M%')

-- Find all customers whose first name ends with 'n'

SELECT * FROM customers WHERE first_name LIKE ('%n')

-- Find all customers whose first name contains 'r'

SELECT * FROM customers WHERE first_name LIKE ('%r%')

-- Find all customers whose first name has an 'r' at third position

SELECT * FROM customers WHERE first_name LIKE ('__r%')