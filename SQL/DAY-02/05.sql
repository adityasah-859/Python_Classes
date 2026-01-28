CREATE DATABASE retail_db;
USE retail_db;
SHOW TABLES;

DESC customers;
SELECT * FROM customers LIMIT 10;
SELECT COUNT(*) FROM customers;

DESC orders;
SELECT * FROM orders LIMIT 10;
SELECT COUNT(*) FROM orders;

DESC order_items;
SELECT * FROM order_items LIMIT 10;
SELECT COUNT(*) FROM order_items;

DESC products;
SELECT * FROM products LIMIT 10;
SELECT COUNT(*) FROM products;

DESC categories;
SELECT * FROM categories LIMIT 10;
SELECT COUNT(*) FROM categories;

DESC departments;
SELECT * FROM departments LIMIT 10;
SELECT COUNT(*) FROM departments;
 
-- 1. Identify Peak Order Dates

SELECT order_date, COUNT(*) AS count
FROM orders
GROUP BY order_date
ORDER BY COUNT(*) DESC LIMIT 10;

-- 2. Dates with high order Volume (>120)

SELECT order_date, COUNT(*)
FROM orders
GROUP BY order_date
HAVING COUNT(*) > 120;

-- 3. Compute Revenue for second order id

SELECT order_item_order_id, ROUND(SUM(order_item_subtotal),2) AS Revenue_2nd_Order 
FROM order_items
GROUP BY order_item_order_id
HAVING order_item_order_id = 2;


-- 4. Revenue Per Order

SELECT order_item_order_id, SUM(order_item_subtotal) AS Revenue
FROM order_items
GROUP BY order_item_order_id;

-- 5. Monthly order Count for Reporting

SELECT YEAR(order_date) AS Year_,MONTHNAME(order_date)  AS Month_, COUNT(*) AS orderCount
FROM orders
GROUP BY MONTHNAME(order_date), YEAR(order_date);


USE demo1;

SELECT * FROM emp;


