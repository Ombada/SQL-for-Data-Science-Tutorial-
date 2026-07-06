-- Ch7.4 Date Functions
/* 
1.  CURDATE()
2.  NOW()
3. TIMESTAMPDIFF

*/
-- Example 1: Today's date

SELECT CURDATE();


-- Example 2:  Current time

SELECT NOW();


--  Example 3: Customer ages

SELECT first_name, birth_date,
TIMESTAMPDIFF(YEAR,birth_date,CURDATE()) AS Age
FROM customers;


-- Example 4: Extract the year of each order

SELECT
order_id,
YEAR(order_date) AS Order_Year
FROM orders;


--  Example 5: Extract the month of each order

SELECT
order_id,
MONTH(order_date) AS Order_Month
FROM orders;


-- Example 6: Extract the day of each order


SELECT
order_id,
DAY(order_date) AS Order_Day
FROM orders;
