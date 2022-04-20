-- Stevanella Marco 
-- 101307949
-- ASGMT_1

-- Question 1
SELECT email_address, COUNT (*) AS "Numberr of Orders",
SUM((item_price - discount_amount) * quantity) AS total_order_amount
FROM CUSTOMERS 
INNER JOIN ORDERS ON customers.customer_id = orders.customer_id
INNER JOIN ORDER_ITEMS ON order_items.order_id = orders.order_id
GROUP BY email_address
HAVING COUNT(*) > 1
ORDER BY total_order_amount DESC;

-- Question 2

SELECT product_name AS "Product Name",
SUM((item_price - discount_amount) * quantity) AS "Total order amount"
FROM ORDER_ITEMS
JOIN PRODUCTS p ON order_items.order_id = p.product_id
GROUP BY ROLLUP (product_name);

-- Question 3
-- Show customer email address and productcs, of customers that have ordered at least 1 product.

SELECT email_address AS "Email", COUNT ( DISTINCT oi.product_id ) AS "Product"
FROM customers c, orders o, order_items oi
WHERE c.customer_id = o.customer_id AND o.order_id = oi.order_id
GROUP BY email_address
HAVING COUNT (DISTINCT oi.product_id) > 1;

-- Question 4
-- Use a subquery to replicate the following query: 
--SELECT DISTINCT category_name
--FROM categories c JOIN products p
--ON c.category_id = p.category_id
--ORDER BY category_name

SELECT DISTINCT category_name
FROM categories 
WHERE category_id IN (SELECT category_id FROM products)
ORDER BY category_name;

-- Question 5
-- return the products name and their prices, that are the most expensive compared to the avarage products price in the store.

SELECT product_name, list_price
FROM products
WHERE list_price > ( SELECT AVG (list_price) FROM products)
ORDER BY 2 DESC;

-- Question 6
-- Use the a subquery with the NOT EXISTS operator to retrive the category_name that is never been assigned to a product in the products table. 

SELECT category_name
FROM categories c
WHERE NOT EXISTS (SELECT category_id FROM PRODUCTS p WHERE c.category_id = p.category_id);

-- Question 7 (SOMEHOW NOT WORKING)
-- Return unique discounted products by its name and discount percent.

SELECT product_name AS "Product Name", discount_percent AS "Discount Percentage"
FROM products p
WHERE NOT EXISTS
  (SELECT products.discount_percent FROM products )
WHERE products.discount_percent = p.discount_percent
AND NOT (products.product_name = p.product_name)
ORDER BY p.product_name;

-- Question 8
-- Using a subquery retrive the oldes customer's order by its email address, order id and order date

SELECT c.email_address, o.order_id, o.order_date
FROM customers c INNER JOIN orders o
ON c.customer_id = o.customer_id
-- Subquery
WHERE o.order_date
IN(SELECT MIN (o.order_date)
FROM orders o
GROUP BY o.customer_id);
