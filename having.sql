-- Ch5: HAVING 

/* HAVING is used to filter groups after GROUP BY, 
just as WHERE is used to filter individual rows before grouping.*/ 


-- 1. Find states with more than 2 customers
-- The following is wrong since the num_customers column has not been created yet 
SELECT state, COUNT(customer_id) AS num_customers
FROM customers
where num_customers > 2
GROUP BY  state;

-- The following is correct as the table num_customers is immedialty created after GROUP BY
SELECT state, COUNT(customer_id) AS num_customers
FROM customers
GROUP BY  state
HAVING num_customers > 2;


-- 2. Find customers who placed more than one order
SELECT customer_id, COUNT(order_id) AS num_orders
FROM orders
GROUP BY  customer_id
HAVING num_orders > 1;


-- 3. Find orders worth more than $100
SELECT order_id, SUM(unit_price * quantity) as order_worth
FROM order_items
GROUP BY  order_id
HAVING order_worth > 100;


-- 4. Find products sold in quantities greater than 10
SELECT product_id, SUM(quantity) AS total_quantity
FROM order_items
GROUP BY product_id
HAVING total_quantity > 10;


-- 5. Find cities with at least 5 customers
SELECT city, COUNT(*) AS num_customers
FROM customers
GROUP BY city
HAVING num_customers >= 5;


-- 6. Find states with more than one customer born after January 1, 1990
-- This is an example for combining WHERE and HAVING
SELECT state, COUNT(*) AS total_customers
FROM customers
WHERE birth_date > '1990-01-01'
GROUP BY state
HAVING COUNT(*) > 1;

-- 7. Find states with at least two customers with points more than 1000
SELECT state, COUNT(*) AS total_customers
FROM customers
WHERE points > 1000
GROUP BY state
HAVING COUNT(*) >= 2;
