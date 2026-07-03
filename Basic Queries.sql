-- Basic Queries

-- 1.  select all the columns (*) from table customers
SELECT *
FROM customers;



-- 2. select specific columns (first_name, last_name) from table customers
SELECT first_name, last_name
FROM customers;



-- 3. Aliasing is changing or assigning a name to a column using the (AS) command
SELECT  first_name, last_name, birth_date AS BD
FROM customers;



/* Normally, we use an alias when we create a new column from one or more existing columns. 
An alias gives the new column a meaningful name, making the query output easier to read and understand*/


-- 4. Retrieve first_name, last_name, points and the the points divided by 50 as Bouns_in_Euro from customers
SELECT  first_name, last_name, points, (points / 50) AS Bouns_in_Euro
FROM customers;



-- 5.  Another example for alias: retrievr the full name and the points for each customer
-- Notice that we dont have a column for full_name so we have to concatnate first and last name and give it an alias as full_name 
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM customers;

/*
Take home messages:
I. There is no SQL query without SELECT.
II. An alias is a temporary name assigned to a column or a table for the duration of a query. 
Aliases improve readability, especially when creating calculated columns or working with multiple tables in joins.

*/
