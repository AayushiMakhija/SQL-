-- Identity Columns

-- Create a table employees and use the identity column as primary key.

CREATE TABLE Employees (
    EmpID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50),
    Department NVARCHAR(50)
);

-- Insert Values

INSERT INTO Employees (Name, Department)
VALUES 
    ('Alice', 'HR'),
    ('Bob', 'IT'),
    ('Charlie', 'Finance');

SELECT * FROM Employees;

-- Sequences

-- Creating a Sequence in Ascending Order

CREATE SEQUENCE sequence_1
START WITH 1
increment BY 1
minvalue 0
maxvalue 100
cycle;

-- Creating a Sequence in Descending Order

CREATE SEQUENCE sequence_2
START WITH 100
increment BY -1
minvalue 1
maxvalue 100
cycle;

-- Using a Sequence to Insert Values

CREATE TABLE students
( 
ID INT,
NAME CHAR(20)
);

INSERT INTO students VALUES
(NEXT VALUE FOR sequence_1, 'Shubham'),
(NEXT VALUE FOR sequence_1, 'Aman');

SELECT * FROM students;

-- Creating a Sequence with Cache.

CREATE SEQUENCE sequence_3
START WITH 1
INCREMENT BY 1
CACHE 10;