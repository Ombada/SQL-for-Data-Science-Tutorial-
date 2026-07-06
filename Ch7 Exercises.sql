
# Ch7 Exercises
/*
EX 1: 

First display every customer with one of these membership levels:
- Bronze ( < 1000)
- Silver (1000 - 1999)
- Gold (2000 - 2999)
- Platinum ( >= 3000)
then find the most common status among the customers.
*/

-- Part A find the membership table, we will use this as subquery for part B
SELECT customer_id, first_name, last_name, points, 
CASE 
	WHEN points < 1000 THEN 'Bronze'
	WHEN points BETWEEN 1000 AND 1999 THEN 'Silver'
	WHEN points BETWEEN 2000 AND 2999 THEN 'Gold'
	ELSE  'Platinum'
END AS membership
FROM customers;


SELECT membership, COUNT(*) AS total_customers
FROM (
SELECT customer_id, first_name, last_name, points, 
CASE 
	WHEN points < 1000 THEN 'Bronze'
	WHEN points BETWEEN 1000 AND 1999 THEN 'Silver'
	WHEN points BETWEEN 2000 AND 2999 THEN 'Gold'
	ELSE  'Platinum'
END AS membership
FROM customers ) as membership_table
GROUP BY membership
ORDER BY total_customers DESC
LIMIT 1;




-- EX2: find the year with the most orders, then find the month with the most orders of that year.

-- In order to solve this EX you will need to have good understanding of subqueries 
-- I will divide it in two main Parts A and B

-- PartA: find the year with the most orders
-- Step 1: create a table for all the years and the number of orders in each year

         SELECT YEAR(order_date) AS Order_Year, COUNT(*) AS num_orders
		 FROM orders
		 GROUP BY Order_Year;
         
-- step 2: write a scalar subquery to find the maximum number of oderes using the first subquery

		SELECT MAX(num_orders)
		FROM ( SELECT YEAR(order_date) AS Order_Year, COUNT(*) AS num_orders
			   FROM orders
			   GROUP BY YEAR(order_date) ) AS num_orders_table;

-- step 3: just combine step1 and step2 

		SELECT Order_Year
		FROM (SELECT YEAR(order_date) AS Order_Year, COUNT(*) AS num_orders
			  FROM orders
			  GROUP BY Order_Year) AS num_orders_table
		WHERE num_orders =  (
						 SELECT MAX(num_orders)
						 FROM( SELECT YEAR(order_date) AS Order_Year, COUNT(*) AS num_orders
							   FROM orders
							   GROUP BY YEAR(order_date)) AS t );

-- PartB: The query in step 3 returns the year with the most orders
-- step 1: now we will find the table of every order and the months in this year
         SELECT order_id, MONTH(order_date) AS month
		 FROM orders
		 WHERE YEAR(order_date) = (SELECT Order_Year
		 FROM (SELECT YEAR(order_date) AS Order_Year, COUNT(*) AS num_orders
			  FROM orders
			  GROUP BY Order_Year) AS num_orders_table
		 WHERE num_orders =  (
						 SELECT MAX(num_orders)
						 FROM( SELECT YEAR(order_date) AS Order_Year, COUNT(*) AS num_orders
							   FROM orders
							   GROUP BY YEAR(order_date)) AS t ));

-- step 2: find the number of orders in each month 
 SELECT month, COUNT(*) AS num_orders
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
		 GROUP BY month;
-- step 3 find the maximum number of orders in a month
SELECT MAX(num_orders)
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
		 GROUP BY month) as l;
         
-- step 4: combine step 2 and 3

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


-- One can think to solve the privious EX in a simpler method as follows:
SELECT MONTH(order_date) AS order_month,
       COUNT(*) AS num_orders
FROM orders
WHERE YEAR(order_date) =
(
    SELECT YEAR(order_date)
    FROM orders
    GROUP BY YEAR(order_date)
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
GROUP BY MONTH(order_date)
ORDER BY num_orders DESC
LIMIT 1;

-- HOWEVER THIS IS NOT CORRECT 
-- it will only retrn one month, there could be the case that many months have the exact maximum number of orders 
-- and the last solution will fail to retrieve all of them  
-- WE WILL SIMPLIFY THE CORRECT SOLUTION IN THE NEXT CHAPTER USING Common Table Expressions (CTEs)
