-- Set the score 250 where the id is equal to 6 and commit the changes 

BEGIN TRANSACTION
UPDATE customers SET score = 250 WHERE id = 5
COMMIT TRANSACTION

-- Rollback the inserted data

BEGIN TRANSACTION
INSERT INTO customers (id, first_name, country , score) VALUES (6, 'Sarra', 'USA', 150), (7, 'Salim', 'Turkey', 100)
ROLLBACK TRANSACTION

-- Make the savepoints in the customers table

BEGIN TRANSACTION
INSERT INTO customers (id, first_name, country , score) VALUES (6, 'Sarra', 'USA', 150)

SAVE TRANSACTION A 

INSERT INTO customers (id, first_name, country , score) VALUES (7, 'Salim', 'Turkey', 300)

SAVE TRANSACTION B

INSERT INTO customers (id, first_name, country , score) VALUES (8, 'Burak', 'Turkey', 100)

SAVE TRANSACTION C

INSERT INTO customers (id, first_name, country , score) VALUES (9, 'Asena', 'Turkey', 50)

SAVE TRANSACTION D

-- Rollback the save point C

ROLLBACK TRANSACTION B
