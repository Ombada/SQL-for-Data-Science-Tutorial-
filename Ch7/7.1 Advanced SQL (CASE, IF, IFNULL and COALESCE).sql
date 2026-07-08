--  Chapter 7: Advanced SQL


/*In this chapter, we'll explore more advanced SQL techniques that make queries cleaner, more readable, and more powerful.

We'll learn:

- CASE expressions
- IF() function
- IFNULL()
- COALESCE()
- Mathematical functions
- String functions
- Date functions
*/

--  1. CASE Expression

/*  The CAS` expression works like an IF-ELSE statement in programming languages.

  Syntax


CASE
    WHEN condition THEN value
    WHEN condition THEN value
    ELSE value
END


*/

--  Example 1: Customer Membership
-- Classify customers according to their points into Bronze (less than 1000) Silver (1000-2000) and Gold (more than 2000).


SELECT customer_id, first_name, last_name, points, 
    CASE
        WHEN points < 1000 THEN 'Bronze'
        WHEN points BETWEEN 1000 AND 2000 THEN 'Silver'
        WHEN points BETWEEN 2001 AND 3000 THEN 'Gold'
        ELSE 'Platinum'
    END AS membership
FROM customers;


--  Example 2: Order Status 1 is'Pending', 2 is'Shipped', and 3 is 'Delivered' any other number is unknown status 

SELECT order_id, status,
    CASE
        WHEN status = 1 THEN 'Pending'
        WHEN status = 2 THEN 'Shipped'
        WHEN status = 3 THEN 'Delivered'
        ELSE 'Unknown'
    END AS order_status
FROM orders;






--  2. IF()

/* IF returns one value if a condition is true and another if it is false.

Syntax

IF(condition, true_value, false_value)
*/

-- Example 3:  Show whether customers are VIPs i.e, with more than 3000 points.

SELECT first_name, last_name, points,
    IF(points > 3000,
       'VIP Customer',
       'Regular Customer') AS customer_type
FROM customers;







-- 3. IFNULL()
/*
Sometimes a column contains NULL values.

Instead of displaying NULL, we can replace it.
*/


-- Example 4: Display phone numbers, if the phone number is null then display No Phone Number.

SELECT first_name, last_name,
    IFNULL(phone,'No Phone Number') AS phone
FROM customers;








-- 4. COALESCE()
/*
COALESCE() returns the first non-null value.

syntax
 COALESCE(first_value,second_value,default_value) AS Contact
*/

-- Example 5


SELECT
    first_name,
    last_name,
    COALESCE(phone,address,'Unknown') AS Contact
FROM customers;

/*
If

Phone = NULL

Address = 123 Main St

Result -> 123 Main St

If

Phone = NULL

Address = NULL

Result -> Unknown

*/
