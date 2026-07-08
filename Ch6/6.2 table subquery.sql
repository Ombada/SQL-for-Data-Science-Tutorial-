-- Chapter 6: Subqueries

-- 1. Display customers who have placed at least one order.

SELECT *
FROM customers
WHERE customer_id IN
(
    SELECT customer_id
    FROM orders
);
-- here only colmns from customers table will be returned
-- One can also write this with join, however here you will get all the colmns from both tables

SELECT c.customer_id, c.first_name, c.last_name, c.birth_date, c.phone, c.address, c.city, c.state, c.points
FROM customers c
JOIN orders o
ON  c.customer_id = o.customer_id
group by c.customer_id;


-- we can also solve this in two steps 
-- step one find the customer_id of the customers who placed an order
 SELECT customer_id 
 FROM orders;
-- This will return 2,5,6,7,8,10 Then we can write in step two 
SELECT *
FROM customers
WHERE customer_id IN (2,5,6,7,8,10);


-- 2. Find customers who have never placed an order.

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



-- 3. Find all products that appear in at least one order.

SELECT *
FROM products
WHERE product_id IN
(
    SELECT product_id
    FROM order_items
);


-- 4. Find products that have never been sold.

SELECT *
FROM products
WHERE product_id NOT IN
(
    SELECT product_id
    FROM order_items
);


-- 5. Find customers who placed more orders than the average customer.

SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) >
(
    SELECT AVG(order_count)
    FROM
    (
        SELECT COUNT(*) AS order_count
        FROM orders
        GROUP BY customer_id
    ) AS customer_orders -- Every temperory table must have an alias
);
 /*
 Explanation

The inner query counts the number of orders for each customer.

The second query calculates the average number of orders.

Finally, the outer query displays customers whose order count exceeds that average.

*/

-- 6. Find customer(s) with the maximum number of points.

SELECT *
FROM customers
WHERE points =
(
    SELECT MAX(points)
    FROM customers
);

-- 7. Find orders whose total value is greater than the average order value.

SELECT order_id,
       SUM(quantity * unit_price) AS total_value
FROM order_items
GROUP BY order_id
HAVING SUM(quantity * unit_price) >
(
    SELECT AVG(order_total)
    FROM
    (
        SELECT SUM(quantity * unit_price) AS order_total
        FROM order_items
        GROUP BY order_id
    ) AS order_totals
);

