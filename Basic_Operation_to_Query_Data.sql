-- To select the database
USE MyDatabase

-- Retrieve all the customer data

SELECT * FROM customers

-- Retrieve each customer's name, country and score from the customer data 

SELECT first_name , country, score FROM customers

-- Retrieve customers with scores not equal to 0

SELECT * FROM customers WHERE score != 0 

-- Retrieve name and country of customers which are from Germany

SELECT first_name, country FROM customers WHERE country = 'Germany'

-- Retrieve all the customers and sort the results by the highest score first

SELECT * FROM customers ORDER BY score DESC

-- Retrieve all the customers and sort the results by the lowest score first

SELECT * FROM customers ORDER BY score ASC

-- Retrieve all the customers and sort the results by the country and then by the highest score first

SELECT * FROM customers ORDER BY country , score DESC 

-- Find the total score for each country

SELECT country , SUM(score)AS total_score FROM customers GROUP BY country 

-- Find the total score and total number of customers for each country

SELECT country ,COUNT(id) AS total__customers, SUM(score)AS total_score FROM customers GROUP BY country

/* Find the average score for each country considering only customers with a score not equal to 0 and return only those countries
with an average score greater than 430 */

SELECT country , AVG(score) AS avg_score FROM customers WHERE score != 0 GROUP BY country HAVING AVG(score) > 430

-- Return Unique list of all countries

SELECT DISTINCT country FROM customers

-- Retrieve data of only 3 customers

SELECT TOP(3) * FROM customers

-- Retrieve top 3 customers with highest score

SELECT TOP(3) * FROM customers ORDER BY score DESC

-- Retrieve lowest 2 customers based on the score

SELECT TOP(2) * FROM customers ORDER BY score 

-- Retrieve all the orders data

SELECT * FROM orders

-- Get 2 most recent orders

SELECT TOP(2) * FROM orders ORDER BY order_date DESC


