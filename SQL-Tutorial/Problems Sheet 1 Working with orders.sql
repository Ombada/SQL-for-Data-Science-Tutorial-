-- 1. Display all order items with the total_price
SELECT order_id, product_id, quantity, unit_price,
        (quantity*unit_price) AS total_price
FROM order_items;

-- 2. Find the total value of each order.
SELECT order_id, SUM(quantity * unit_price) AS order_total
FROM order_items
GROUP BY order_id;

-- 3. Find the most expensive order
SELECT order_id, SUM(quantity * unit_price) AS order_total
FROM order_items
GROUP BY order_id 
ORDER BY order_total DESC
LIMIT 1;

-- 4. Find the average order value
SELECT  AVG(quantity * unit_price) AS order_avg
FROM order_items;
/* This is qite simple, however this its not correct 
here is the correction you have to aggregate first then average */
SELECT AVG(order_total) AS average_order_value
FROM (
    SELECT order_id,
           SUM(quantity * unit_price) AS order_total
    FROM order_items
    GROUP BY order_id
) t;

-- 5.Find the total revenue generated
SELECT SUM(quantity * unit_price) AS total_revenue
FROM order_items;
