-- Joins
-- 1.Display each order together with the customer's first and last name
SELECT o.order_id, c.first_name, c.last_name
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id;

-- 2. Display order_id, customer name, order date, and status
SELECT o.order_id, c.first_name, 
	   c.last_name, o.order_date, o.status
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id;

-- 3. Display all orders placed by John Smith
SELECT o.*
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.first_name = 'John' AND c.last_name = 'Smith';
  
  
-- II. LEFT JOIN 
-- 4.Show customers who have never placed an order
-- The following will not return anything (logical Erorr)
SELECT c.first_name, c.last_name, o.order_id 
from customers c 
JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL; 

/* Here we need a LEFT JOIN since it keeps every row from the left table (customers). 
If no matching order exists, the columns from orders are filled with NULL.
So the correct answer will be: */
SELECT c.first_name, c.last_name, o.order_id 
from customers c 
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL; 

-- 5. Count how many orders each customer has made
-- The following is also an example of logical error 
SELECT customer_id,  COUNT(order_id) AS number_of_orders
FROM orders
GROUP BY customer_id
ORDER BY number_of_orders DESC ;

/* This will return only the customer_id and the number of orders 
of the customers who actually placed an order and ignores all
other customers who never placed an order.
A better way to solve this query will be: */

SELECT c.customer_id, c.first_name, c.last_name,
       COUNT(o.order_id) AS number_of_orders
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id
order by number_of_orders desc ; 


/*To avoid the logical errors while using joins here is 
a Rule of Thump:
INNER JOIN → Only matching rows.
LEFT JOIN → All rows from the left table, plus matching rows from the right.
RIGHT JOIN → All rows from the right table, plus matching rows from the left.
*/ 