-- These are the kinds of queries analysts write all the time.

-- 1. Top 10 orders by value
SELECT order_id, sum(quantity * unit_price) AS total_price
FROM order_items 
GROUP BY order_id
ORDER BY total_price DESC
LIMIT 10;

-- 2. Number of products sold
SELECT sum(quantity) AS products_sold
FROM order_items;

-- 3. Revenue per product
SELECT product_id, sum(quantity * unit_price) as total_price
FROM order_items 
GROUP BY product_id;


-- 4. Which customer spent the most?
SELECT c.customer_id, c.first_name, c.last_name,
       SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o       ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name,c.last_name
ORDER BY total_spent DESC
LIMIT 4;

-- 5.Find the average order value
SELECT  AVG(quantity * unit_price) AS order_avg
FROM order_items;
-- however this is wrong !!!
-- here is the correction you have to aggregate first then average 
SELECT AVG(order_total) AS average_order_value
FROM (
    SELECT order_id,
           SUM(quantity * unit_price) AS order_total
    FROM order_items
    GROUP BY order_id
) t;
