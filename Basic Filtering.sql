-- Ch2: Basic Filtering 

-- Filtering is associated with the word "WHERE"

-- 1. Retrieve customers whose phone number is NULL
SELECT *
FROM customers
WHERE phone IS NULL;


-- 2. Retrieve customers living in CA or NY

SELECT *
FROM customers
WHERE state IN ('CA', 'NY');

-- Alternative

SELECT *
FROM customers
WHERE state = 'CA' OR state = 'NY';


-- 3. Retrieve customers whose first name starts with "A"

SELECT *
FROM customers
WHERE first_name LIKE 'A%';


-- 4. Retrieve customers whose last name contains "son"

SELECT *
FROM customers
WHERE last_name LIKE '%son%';


-- 5. Retrieve customers born between 1980 and 2000

SELECT *
FROM customers
WHERE birth_date BETWEEN '1980-01-01' AND '2000-12-31';

-- Alternative

SELECT *
FROM customers
WHERE birth_date >= '1980-01-01' AND birth_date <= '2000-12-31';


-- 6. Retrieve customers whose first name starts with B and who live in MA.
SELECT *
FROM customers
WHERE first_name LIKE 'B%' AND state = 'MA';


-- 7. Display all orders placed by customer 5
SELECT *
FROM orders
WHERE customer_id = 5;

