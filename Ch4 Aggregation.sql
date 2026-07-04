-- Ch 4: Aggregation.

/*
				ORDER BY Vs GROUP BY
                
GROUP BY asks: "How can I combine these rows into groups?"
ORDER BY asks: "In what order should I display the rows?"

GROUP BY : Groups rows into categories	
ORDER BY : Sorts rows

GROUP BY: Used with aggregate functions (COUNT, SUM, AVG, etc.)
ORDER BY : Sort the data according to the selected column in an ascending order 
*/


-- 1. How many customers are there?
SELECT COUNT(*) AS total_num_cust
From customers;

-- 2. How many customers live in each state?
SELECT state, COUNT(*) AS num_customers
FROM customers
GROUP BY state;

-- 3.1 Find the earliest birth date (the youngest person)
SELECT birth_date 
FROM customers
ORDER BY birth_date ASC
LIMIT 1;
-- another way
SELECT MIN(birth_date) AS earliest_birth_date
FROM customers;

-- 3.2 Find the most recent birth date

SELECT MAX(birth_date) AS latest_birth_date
FROM customers;

-- 4. cont the number of orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- 5. How many orders does each customer have?
SELECT customer_id, COUNT(*) AS num_orders
From orders
group by customer_id;

-- return the customer with the most orders 
SELECT customer_id, COUNT(*) AS num_orders
From orders
group by customer_id
order by num_orders desc;
 

-- 6. How many customers are in each city?
SELECT city, COUNT(*) AS num_customers
FROM customers
GROUP BY city;

-- 7.Number of customers per state, highest first
SELECT state, COUNT(*) AS num_customers
FROM customers
GROUP BY state
order by num_customers desc;

-- 8. Average age of customers
SELECT AVG(TIMESTAMPDIFF(YEAR, birth_date, CURDATE())) AS avg_age
FROM customers;

-- 9. Find the total_quantity of each order.
SELECT order_id, SUM(quantity) AS total_quantity
FROM order_items
GROUP BY order_id;
