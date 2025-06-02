-- Create a new table called persons with columns: id, person_name, birth_date, phone

CREATE TABLE persons(
	id INT NOT NULL,
	person__name VARCHAR(50) NOT NULL,
	birth_date DATE NULL,
	phone VARCHAR(15) NOT NULL,
	CONSTRAINT pk_person PRIMARY KEY(id)
	)


-- Alter the persons table by adding an email column

ALTER TABLE persons ADD email VARCHAR(50) NOT NULL

-- Remove the column phone from the persons table

ALTER TABLE persons DROP COLUMN phone 

-- DELETE the table persons from the database

DROP TABLE persons

-- Delete all the data from the table persons

TRUNCATE TABLE persons


