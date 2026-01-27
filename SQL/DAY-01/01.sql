-- DDL commands-- 

CREATE DATABASE IF NOT EXISTS demo; -- <--For creating a DB
USE demo; -- <--Using the DB

SHOW TABLES; -- <-- SHOWS the tables

CREATE TABLE cust_alter(   -- <-- Creating the table
	customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

DESCRIBE cust_alter;  -- <-Shows about the table

ALTER TABLE cust_alter ADD phone VARCHAR(15);  -- <--- Modify the table columns  (ADD) <-- Add a column
DESCRIBE cust_alter;

ALTER TABLE cust_alter MODIFY phone VARCHAR(30);  -- <-- (MODIFY) <-- Change the datatype of column
DESCRIBE cust_alter;

ALTER TABLE cust_alter DROP phone; -- <-- Deletes the phone column
DESCRIBE cust_alter;

DROP TABLE IF EXISTS cust_cons;  -- <-- Deletes the table
CREATE TABLE cust_cons(
	customer_id INT,
    customer_name VARCHAR(50)
);
DESCRIBE cust_cons;

ALTER TABLE cust_cons ADD CONSTRAINT pk_cust PRIMARY KEY(customer_id);  -- <--Adding a constraint of primary key to customer_id
DESCRIBE CUST_CONS;

ALTER TABLE cust_cons DROP PRIMARY KEY;   -- <-- Removing the constraint of primary key from customer_id
DESCRIBE cust_cons;
DESC cust_cons;

DROP TABLES IF EXISTS orders_drop;  
CREATE TABLE IF NOT EXISTS orders_drop(
	order_id INT,
    order_date DATE
);
DESC orders_drop;

DROP TABLE IF EXISTS orders_drop;  
DESC orders_drop;

DROP TABLE IF EXISTS orders_trunc;
CREATE TABLE IF NOT EXISTS orders_trunc(
	order_id INT,
    order_date DATE
);

INSERT INTO orders_trunc(order_id,order_date) VALUES  -- <-- Inset data into the table
(101,'2025-01-10'),
(102,'2025-02-11');

SELECT * FROM orders_trunc; -- <-- View all columns data of table

TRUNCATE TABLE orders_trunc; -- <--  Delete all rows of the table but keeps the column structure

SELECT * FROM orders_trunc;

DROP TABLE IF EXISTS cust_rename;
CREATE TABLE IF NOT EXISTS cust_rename(
	customer_id INT,
    customer_name VARCHAR(50)
);

DESC cust_rename;
RENAME TABLE cust_rename TO cust_rename_new;  -- <-- Rename the current table to a new name
DESC cust_rename_new;

DROP DATABASE demo;



-- Next Sheet

CREATE DATABASE IF NOT EXISTS demo;
USE demo;

CREATE TABLE products_op (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price INT,
    quantity INT
);

DESC products_op;


INSERT INTO products_op (product_id, product_name, price, quantity) VALUES
(1, 'Laptop', 50000, 2),
(2, 'Mouse', 500, 10),
(3, 'Keyboard', 1500, 5);

SELECT * FROM products_op;

SELECT product_name, price + quantity AS result -- <-- Adding two columns
FROM products_op;

SELECT product_name, price - quantity AS result -- <-- Subtracting two columns
FROM products_op;

SELECT product_name,price * quantity AS result -- <-- Multiplying two columns
FROM products_op;

SELECT price / NULLIF(quantity,0) -- <-- Dividing two columns if the quantity is zero then directly return zero else divide and return
FROM products_op; 

CREATE TABLE emp_rel (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT
);

DESC emp_rel;

INSERT INTO emp_rel (emp_id, emp_name, salary) VALUES
(1, 'Arjun Raj', 60000),
(2, 'Priya Nair', 45000),
(3, 'Ramesh Kumar', 70000);

SELECT * FROM emp_rel;

SELECT * FROM emp_rel  
WHERE salary >= 50000; -- <-- Greater than

SELECT * FROM emp_rel 
WHERE salary <> 60000; -- <-- Not equal to

SELECT *
FROM emp_rel
WHERE salary = 45000;

SELECT *
FROM emp_rel
WHERE salary = 'ABC';  -- <--  Data mismatch


CREATE TABLE cust_logic (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    status VARCHAR(20)
);
INSERT INTO cust_logic VALUES (1, 'Arjun Raj', 'Bengaluru', 'Active');

INSERT INTO cust_logic VALUES (2, 'Priya Nair', 'Chennai', 'Inactive');

INSERT INTO cust_logic VALUES (3, 'Ramesh Kumar', 'Hyderabad', 'Active');

INSERT INTO cust_logic VALUES (4, 'Kavita Desai', 'Mumbai', 'Active');

SELECT * FROM cust_logic;

SELECT * FROM cust_logic WHERE city = "Chennai" AND status = "Inactive";

SELECT * FROM cust_logic WHERE city = "Mumbai" OR city = "Chennai";

SELECT * FROM cust_logic WHERE city != "Mumbai";

SELECT * FROM cust_logic WHERE status = "Active" AND customer_id > 1;

SELECT CONCAT(customer_name, " from ", city) AS full_info  -- <-- Concat different columns
FROM cust_logic;

SELECT CONCAT(customer_name, " is ",status)
FROM cust_logic;

SELECT *
FROM cust_logic
WHERE city IN ('Mumbai', 'Chennai');

SELECT *
FROM cust_logic
WHERE customer_id IN (1, 2, 3);  -- <-- Values in this 

SELECT *
FROM emp_rel
WHERE salary BETWEEN 45000 AND 70000;

SELECT *
FROM cust_logic
WHERE customer_name LIKE 'A%'; -- <--  names starting with A

SELECT *
FROM cust_logic
WHERE customer_name LIKE '%S'; -- <-- names ending with S

SELECT *
FROM cust_logic
WHERE status IS NULL; -- <-- Where status is not mentioned

SELECT *
FROM cust_logic
WHERE status IS NOT NULL; -- <-- WHere status is mentioned

SELECT * 
FROM cust_logic 
WHERE Status != NULL; -- No results

SELECT *
FROM emp_rel
WHERE salary > (
    SELECT salary
    FROM emp_rel
    WHERE emp_name = 'Priya Nair'
);

SELECT *
FROM emp_rel
WHERE salary > ANY ( -- <-- If any one satisfy then it will show like priya has less salary so other rows will show
    SELECT salary
    FROM emp_rel
);

SELECT *
FROM cust_logic c -- <-- 
WHERE EXISTS (
    SELECT 1
    FROM emp_rel e
    WHERE e.emp_id = c.customer_id
);


-- NEW SHEET --

CREATE DATABASE mysql_datatypes_demo;
use mysql_datatypes_demo;

CREATE TABLE numeric_types (
    id INT PRIMARY KEY,
    stock INT,
    price DECIMAL(10,2),
    discount_rate FLOAT,
    tax_rate DOUBLE
);

INSERT INTO numeric_types VALUES
(1, 50, 1999.99, 0.10, 0.18),
(2, 20, 499.50, 0.05, 0.12);

SELECT 
    id,
    price + (price * tax_rate) AS price_with_tax,
    price - (price * discount_rate) AS discounted_price,
    price * stock AS inventory_value,
    price / NULLIF(stock, 0) AS unit_price
FROM numeric_types;


-- Invalid: string value for INT
INSERT INTO numeric_types VALUES (3, 'ABC', 100.00, 0.2, 0.1);

CREATE TABLE string_types (
    id INT PRIMARY KEY,
    country_code CHAR(2),
    customer_name VARCHAR(50),
    email VARCHAR(100),
    comments TEXT
);

INSERT INTO string_types VALUES
(1, 'IN', 'Arjun Sharma', 'arjun@example.com', 'Premium customer'),
(2, 'US', 'Priya Nair', 'priya@example.com', 'New signup');

SELECT 
    CONCAT(customer_name, ' <', email, '>') AS contact_info
FROM string_types;

SELECT 
    UPPER(customer_name) AS upper_name,
    LOWER(customer_name) AS lower_name
FROM string_types;

SELECT customer_name, LENGTH(customer_name) AS name_length, SUBSTRING(customer_name,1,5) AS short_name
FROM string_types;

SELECT customer_name FROM string_types WHERE customer_name LIKE "A%";

-- Error - Data too long for column 'customer_name' at row 1
INSERT INTO string_types VALUES
(3, 'IND', 'VeryLongCustomerNameExceedingLimit', 'test@example.com', 'Invalid example');

CREATE TABLE IF NOT EXISTS datetime_types(
	id INT PRIMARY KEY,
    order_date DATE,
    order_time TIME,
    created_at DATETIME
);

INSERT INTO datetime_types VALUES
(1, '2025-01-10', '10:30:00', '2025-01-10 10:30:00'),
(2, STR_TO_DATE('2025-01-11','%Y-%m-%d'), '14:15:00', NOW());

SELECT
    id,
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    DAY(order_date) AS order_day
FROM datetime_types;

SELECT order_date, DATE_ADD(order_date, INTERVAL 7 DAY) AS plus_7_days,
	DATE_SUB(order_date,INTERVAL 1 MONTH) AS minus_1_month
    FROM datetime_types;
    
SELECT *
FROM datetime_types
WHERE order_date BETWEEN '2025-01-01' AND '2025-01-31';

-- Invalid date
INSERT INTO datetime_types VALUES (3, '2025-15-40', '12:00:00', NOW());

CREATE TABLE boolean_null_types (
    id INT PRIMARY KEY,
    is_active BOOLEAN,
    remarks VARCHAR(50)
);

INSERT INTO boolean_null_types VALUES
(1, TRUE, 'Active'),
(2, FALSE, NULL),
(3, 1, 'Enabled'),
(4, 0, 'Disabled');

-- Correct NULL check
SELECT * FROM boolean_null_types WHERE remarks IS NULL;

-- Incorrect NULL check (returns no rows)
SELECT * FROM boolean_null_types WHERE remarks = NULL;