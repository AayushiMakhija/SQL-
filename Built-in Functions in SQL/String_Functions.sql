-- Manipulation Functions

-- 1. CONCATE()

-- Concatenate first name and country into one column

SELECT first_name, country , CONCAT(first_name,' ', country) AS name_country FROM customers;

-- 2. LOWER() & UPPER()

-- Convert the first_name to lowercase

SELECT first_name , LOWER(first_name) AS Lower_case FROM customers;

-- Covert the first_name to uppercase

SELECT first_name , UPPER(first_name) AS Upper_case FROM customers;

-- 3. TRIM()

-- Find the customers whose first_name contains leading or trailing spaces

SELECT first_name, LEN(first_name) AS len_name, LEN(TRIM(first_name)) AS len_trim_name, LEN(first_name)-LEN(TRIM(first_name)) AS flag
FROM customers WHERE LEN(first_name) != LEN(TRIM(first_name)) ;
-- WHERE first_name != TRIM(first_name)

-- 4. REPLACE

-- Remove dashes from the phone number

SELECT '123-456-7890' AS old_number , REPLACE ('123-456-7890', '-','') AS new_number;

-- Replace the file extension from .txt to .csv

SELECT 'report.txt' AS old_file, REPLACE('report.txt', '.txt', '.csv') AS new_file;

-- Calculations Functions

-- 1. LEN()

-- Calculate the length of each customer's first_name

SELECT first_name, LEN(first_name) AS len_first_name FROM customers;

-- String Extraction Functions

-- 1. LEFT()

-- Retrieve first two characters of each first_name

SELECT first_name, LEFT(TRIM(first_name), 2) AS first_two_char FROM customers;

-- 2. RIGHT()

-- Retrieve last two characters of each first_name

SELECT first_name, RIGHT(TRIM(first_name), 2) AS last_two_char FROM customers;

-- 3. SUBSTRING()

-- Retrieve a list of the customer's first name removing the first character

SELECT first_name, SUBSTRING(TRIM(first_name), 2, LEN(first_name)) AS sub_name FROM customers;
