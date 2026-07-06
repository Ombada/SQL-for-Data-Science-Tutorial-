-- Ch7.3  String Functions

-- The following functions will be addressed they have the same function as in any programming language 

/*
1. UPPER
2. LOWER
3. CONCAT
4. LENGTH
5. SUBSTRING
6. REPLACE
7. TRIM
*/





-- Example 1: Uppercase names.

SELECT UPPER(first_name)
FROM customers;


-- Example 2: Lowercase names.

SELECT LOWER(first_name)
FROM customers;


-- Example 3: Full Name

SELECT CONCAT(first_name,' ',last_name) AS Full_Name
FROM customers;


--  Example 4: Length of names


SELECT first_name, LENGTH(first_name)
FROM customers;


--  Example 5: Extract first three letters

SELECT SUBSTRING(first_name,1,3)
FROM customers;


--  Example 6: Replace text

SELECT REPLACE(address,'Street','St.') AS address
FROM customers;



--  Example 7: Trim spaces


SELECT TRIM('    SQL Tutorial     ') AS No_space;
