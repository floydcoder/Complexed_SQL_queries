-- LAB TEST 1
-- MARCO STEVANELLA 101307949

-- QUERY 1

SELECT category_name as CATEGORY_NAME, COUNT(*) AS PRODUCT_COUNT,
MAX (p.list_price)AS MOST_EXPENSIVE_PRODUCT
FROM categories 
c JOIN products p ON c.category_id = p.category_id
GROUP BY category_name
ORDER BY 2 DESC;

-- QUERY 2

SELECT last_name || ' ' || first_name AS FULL_NAME
FROM customers
WHERE last_name BETWEEN 'L%' AND 'a%'
ORDER BY
last_name;

