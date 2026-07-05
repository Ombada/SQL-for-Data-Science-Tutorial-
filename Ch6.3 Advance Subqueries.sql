
-- Chapter 6: Subqueries
-- Ch6.3 Advance Subqueries


-- 1. Find the customer who spent the most money.

SELECT c.customer_id, c.first_name, c.last_name,
SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(oi.quantity * oi.unit_price) =
(
    SELECT MAX(total_spent)
    FROM
    (
        SELECT SUM(quantity * unit_price) AS total_spent
        FROM orders o
        JOIN order_items oi
            ON o.order_id = oi.order_id
        GROUP BY customer_id
    ) AS spending
);

/* Explanation:
Here I using multiple joins and a subquery.
because customers table and order_items table are not dirctly connected 
but theyy can connect through the order table 
customer <-> orders <-> order_items, notice i used inner join because 
im only interested in customers who already placed an order.
The subquery find the maximumm value.*/ 

##################################### EXISTS

-- 2.Find customers who have placed at least one order.

SELECT *
FROM customers c
WHERE EXISTS
(
    SELECT *
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
-- This can also be written as 
SELECT  c.customer_id, c.first_name, c.last_name, c.birth_date, c.phone, c.address, c.city, c.state, c.points
FROM customers c
JOIN orders o
ON o.customer_id = c.customer_id
GROUP BY c.customer_id;
-- another way 
SELECT *
FROM customers
WHERE customer_id IN
(
    SELECT customer_id
    FROM orders
);

############################################# NOT EXISTS

-- 3.Find customers who never placed an order.

SELECT *
FROM customers c
WHERE NOT EXISTS
(
    SELECT *
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
-- Alternative 
SELECT *
FROM customers
WHERE customer_id NOT IN
(
    SELECT customer_id
    FROM orders
);

-- This is similar to the LFET JOIN example 
SELECT c.customer_id, c.first_name, c.last_name, c.birth_date, c.phone, c.address, c.city, c.state, c.points
from customers c 
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL; 

/* Summary

Subqueries can return:

- A single value (Scalar Subquery)
- Multiple values (Multi-row Subquery)
- A complete table (Derived Table)
- A value for each row (Correlated Subquery)

As you continue learning SQL, you'll notice that many problems can be solved using either JOINs or Subqueries. 
Choosing the most appropriate approach depends on readability, performance, and the specific problem you're trying to solve.

*/