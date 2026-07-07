-- Chapter 8: Common Table Expressions (CTEs)
/*
CTE 1
    ↓
CTE 2
    ↓
    .
    .
    .
    ↓
Main Query

*/

-- Example 1: Customers Spending Above Average
-- Find the customers with above average spending  


WITH customer_spending AS
(
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(oi.quantity * oi.unit_price) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
)

SELECT *
FROM customer_spending
WHERE total_spent >
(
    SELECT AVG(total_spent)
    FROM customer_spending
);


T-- his is much cleaner than repeating the same calculation twice.



/* Summary

In this chapter we learned how to:

- Create Common Table Expressions using `WITH`
- Replace complicated subqueries with readable SQL
- Use multiple CTEs in a single query
- Reuse temporary result sets
- Improve readability and maintainability

CTEs are widely used in analytics, reporting, and data engineering 
because they allow complex problems to be broken into smaller, logical steps.
*/
