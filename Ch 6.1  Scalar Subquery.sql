-- Ch 6: Scalar Subquery


 /* A subquery is a query nested inside another query. Instead of using a fixed value, the outer query uses the result returned by the inner query.

Think of a subquery as asking SQL to solve a smaller problem first, then using that answer to solve the main problem.

General syntax:

SELECT ...
FROM table_name
WHERE column operator (
    SELECT ...
);

*/

--  1. Find all customers whose points are greater than the average number of points.
USE sql_store;
SELECT *
FROM customers
WHERE points >
(
    SELECT AVG(points)
    FROM customers
);


/* First, SQL calculates the average number of customer points. 
Suppose the average is: 1845

The query becomes:

SELECT *
FROM customers
WHERE points > 1845;

*/



-- 2: Find the most expensive product.

SELECT *
FROM products
WHERE unit_price =
(
    SELECT MAX(unit_price)
    FROM products
);

-- This can also be written as 
SELECT *
FROM products
ORDER BY unit_price DESC
LIMIT 1 ;




-- 3. Display all products whose price is above the average product price.

SELECT *
FROM products
WHERE unit_price >
(
    SELECT AVG(unit_price)
    FROM products
);


-- Example 4. Find the youngest customer.

SELECT *
FROM customers
WHERE birth_date =
(
    SELECT MAX(birth_date)
    FROM customers
);


-- notice that Since newer dates represent younger people, we use MAX().
