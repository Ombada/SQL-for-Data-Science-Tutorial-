-- Chapter 8: Common Table Expressions (CTEs)

/* 

 Introduction

A Common Table Expression (CTE) is a temporary named result set that exists only during the execution of a query.

Instead of writing long and complicated nested subqueries, we can divide the problem into smaller, 
easier-to-understand steps.

Think of a CTE as creating a temporary table that can be referenced immediately in the main query.

A CTE improves:

- Readability
- Maintainability
- Debugging
- Query organization

 Syntax:


WITH cte_name AS
(
    SELECT ...
)

SELECT *
FROM cte_name;

The keyword **WITH** tells SQL that we are defining a temporary result set.

*/


-- remember EX sheet ch 7 problem 2
-- find the year with the most orders, then find the month with the most orders of that year.
SELECT month 
FROM ( SELECT month, COUNT(*) AS num_orders
		 FROM (SELECT order_id, MONTH(order_date) AS month
		 FROM orders
		 WHERE YEAR(order_date) = (SELECT Order_Year
		 FROM (SELECT YEAR(order_date) AS Order_Year, COUNT(*) AS num_orders
			  FROM orders
			  GROUP BY Order_Year) AS num_orders_table
		 WHERE num_orders =  (
						 SELECT MAX(num_orders)
						 FROM( SELECT YEAR(order_date) AS Order_Year, COUNT(*) AS num_orders
							   FROM orders
							   GROUP BY YEAR(order_date)) AS t )) ) AS m
		 GROUP BY month) AS l
WHERE num_orders = (SELECT MAX(num_orders)
					FROM ( SELECT month, COUNT(*) AS num_orders
							 FROM (SELECT order_id, MONTH(order_date) AS month
							 FROM orders
							 WHERE YEAR(order_date) = (SELECT Order_Year
							 FROM (SELECT YEAR(order_date) AS Order_Year, COUNT(*) AS num_orders
								  FROM orders
								  GROUP BY Order_Year) AS num_orders_table
							 WHERE num_orders =  (
											 SELECT MAX(num_orders)
											 FROM( SELECT YEAR(order_date) AS Order_Year, COUNT(*) AS num_orders
												   FROM orders
												   GROUP BY YEAR(order_date)) AS t )) ) AS m
							 GROUP BY month) as l);

-- This solution is very complicated and not easy to read
-- Instead of writing nested subqueries, we can separate the calculation.

-- First we find the total number of orders in each year
WITH yearly_orders AS
(
    SELECT
        YEAR(order_date) AS order_year, COUNT(*) AS num_orders
    FROM orders
    GROUP BY YEAR(order_date)
),

-- Then we find the maximum number of orders among the years
 max_yearly_orders AS 
(
SELECT MAX(num_orders)  AS max_y_o
FROM yearly_orders
), 

-- Then we find the year with the maximum number of orders 
 best_year AS
(
    SELECT order_year
    FROM yearly_orders
    WHERE num_orders = (SELECT max_y_o FROM max_yearly_orders)
),
-- Then we find the number of orders  in all months of this year 
monthly_orders AS
(
    SELECT
        MONTH(order_date) AS order_month,
        COUNT(*) AS num_orders
    FROM orders
    WHERE YEAR(order_date) = (SELECT order_year FROM best_year)
    GROUP BY MONTH(order_date)
),
-- Then we find the maximum number of orders among the months
 max_month_orders AS 
(
SELECT MAX(num_orders)  AS max_m_o
FROM monthly_orders
)
-- Finally we find the month with maximum number of orders in the year with maximum number of orders
SELECT order_month
FROM monthly_orders
WHERE num_orders = (SELECT max_m_o FROM max_month_orders);


-- See how easy you can understand the second query 
-- its more readable and interpretable 
