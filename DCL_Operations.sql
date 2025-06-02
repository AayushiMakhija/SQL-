-- Create the login user to which you give or remove the permissions

CREATE LOGIN sudhir WITH PASSWORD = 'StrongPassword123!'
USE MyDatabase
CREATE USER sudhir FOR LOGIN sudhir

-- Grant the permission to insert and select the data from the customer table to Sudhir

GRANT SELECT, INSERT ON customers TO sudhir

-- Grant the permission to insert and select the data from the customer table with grant option to Sudhir 

GRANT SELECT, INSERT ON customers TO sudhir WITH GRANT OPTION 

-- Revoke the pemissions to insert and select the data from the customer table from Sudhir

REVOKE INSERT, SELECT ON customers FROM sudhir

-- Revoke the pemissions to insert and select the data from the customer table with grant option from Sudhir

REVOKE GRANT OPTION FOR SELECT, INSERT ON customers FROM sudhir CASCADE

-- Remove the user sudhir

DROP USER sudhir

DROP LOGIN sudhir
