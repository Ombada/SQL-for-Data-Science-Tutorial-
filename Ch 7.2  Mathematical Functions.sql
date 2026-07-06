
-- Ch 7.2  Mathematical Functions

/*
1. ROUND
2. Ceiling
3.Floor
4.ABS
*/


-- Example 1: Round product prices.

SELECT
    name,
    unit_price,
    ROUND(unit_price) AS rounded_price
FROM products;



-- Example 2: Round to two decimals.

SELECT ROUND(123.4567,2);


-- Example 3: Ceiling

SELECT CEILING(19.2);


-- Example 4: Floor

SELECT FLOOR(19.9);



-- Example 5: Absolute value

SELECT ABS(-15);

