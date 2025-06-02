-- Insert the values in customers table

INSERT INTO customers (id, first_name, country , score) VALUES (6, 'Anna', 'USA', NULL), (7, 'Sam', NULL, 100)

-- Insert data from the customers table into persons table

INSERT INTO persons(id, person__name , birth_date, phone) SELECT id, first_name, NULL, 'unknown' FROM customers

-- Change the score of customer ID 6 to 0

UPDATE customers SET score = 0 WHERE id = 6

-- Change the score od customer ID 7 to 0 and update the country to 'UK'

UPDATE customers SET score = 0 , country = 'UK' WHERE id = 7

-- Delete all customers with an ID greater than 5

DELETE FROM customers WHERE id > 5

-- Delete all data from the table persons

DELETE FROM persons 

