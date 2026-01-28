-- NOT NULL --

CREATE TABLE IF NOT EXISTS demo.cust_notnull(
		customer_id INT NOT NULL,
        cutomer_name VARCHAR(50) NOT NULL,
        email VARCHAR(100)
);

ALTER TABLE cust_notnull RENAME COLUMN cutomer_name TO customer_name ;

DESC demo.cust_notnull;
USE demo;

INSERT INTO cust_notnull(customer_id, customer_name, email)
VALUES(1,'Arjun Sharma','arjun@example.com');

INSERT INTO cust_notnull(customer_id,email) -- <-- Customer_name cannot be NULL
VALUES(2,'Ajay@gmail.com');

SELECT * FROM cust_notnull;


-- DEFAULT --

CREATE TABLE cust_defalut(
	customer_id INT PRIMARY KEY,
    isActive VARCHAR(20) DEFAULT "Active"  -- <-- DEFAULT constraint
);
DESC cust_defalut;
INSERT INTO cust_defalut(customer_id)
VALUES("99");

SELECT * FROM cust_defalut;


-- UNIQUE --

CREATE TABLE cust_unique(
	customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE  -- <-- UNIQUE constraint
);

DESC cust_unique;

INSERT INTO cust_unique(customer_id,customer_name,email)
VALUES(1,"Aditya","aditya@gmail.com");

INSERT INTO cust_unique(customer_id,customer_name,email)
VALUES(2,"Adi","aditya@gmail.com");   -- <-- Duplicate Entry

SELECT * FROM cust_unique;


-- CHECK --

CREATE TABLE od_check(
	order_id INT,
    product_name VARCHAR(50),
    quantity INT CHECK(quantity BETWEEN 1 AND 100),
    price INT CHECK(price > 0)
);

INSERT INTO od_check(order_id, product_name, quantity, price)
VALUES(12,"Apple",23,999);

SELECT * FROM od_check;

INSERT INTO od_check(order_id, product_name, quantity, price)
VALUES(32,"Mango",989,0);  -- <-- Violates check constraint



-- PRIMARY KEY

CREATE TABLE prod_pk(
	product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL
);

INSERT INTO prod_pk(product_id,product_name)
VALUES(1, "Ice-cream");

INSERT INTO prod_pk(product_id,product_name)
VALUES(1, "Chocolate");   -- <-- Duplicate entry for id



-- FOREIGN KEY

CREATE TABLE cust_fk(
	customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL
);

DESC cust_fk;

CREATE TABLE orders_fk(
	order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY(customer_id) REFERENCES cust_fk(customer_id)  -- <-- Foreign Key
);

DESC orders_fk;
SHOW CREATE TABLE orders_fk; -- <-- Shows the syntax used to create the table

CREATE TABLE orders_fk1 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES cust_fk(customer_id)
);

DESC orders_fk1;

SHOW CREATE TABLE orders_fk1;

INSERT INTO cust_fk
VALUES (1, 'Arjun Sharma');

INSERT INTO cust_fk
VALUES (2, 'Priya Nair');

INSERT INTO orders_fk
VALUES (101, 1, '2025-01-10');


INSERT INTO orders_fk
VALUES (102, 2, STR_TO_DATE('2025-01-11', '%Y-%m-%d'));

SELECT * FROM cust_fk;

SELECT * FROM orders_fk;

INSERT INTO orders_fk
VALUES (103, 999, STR_TO_DATE('2025-01-12', '%Y-%m-%d')); -- <-- The customer id is not present in the cust_fk 



-- NEW SHEET (Aggregate Functions)

USE demo1;
SHOW TABLES;

SELECT sal FROM emp;

SELECT MAX(sal) FROM emp;

SELECT MIN(sal) FROM emp;

SELECT SUM(sal) FROM emp;

SELECT AVG(sal) FROM emp;

SELECT COUNT(*) FROM emp;

SELECT COUNT(ename) FROM emp;

SELECT COUNT(COMM) FROM EMP;

SELECT deptno FROM dept;

SELECT DISTINCT deptno FROM emp;

SELECT COUNT(DISTINCT deptno) FROM emp;


SELECT deptno, COUNT(*) 
FROM emp
GROUP BY deptno;

SELECT job, COUNT(*)
FROM emp
GROUP BY job;


SELECT deptno, MIN(sal), MAX(sal)
FROM emp
GROUP BY deptno;

SELECT deptno
FROM emp
GROUP BY deptno;

SELECT deptno, ename
FROM emp
GROUP BY deptno, ename;

SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY deptno, job;

SELECT SUM(sal)
FROM emp
GROUP BY deptno;

SELECT SUM(sal)
FROM emp
GROUP BY deptno;


SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno;


-- HAVING --

SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno
HAVING COUNT(*) > 3; -- <-- Always comes after GROUP BY which applies condtion on deptno i.e. GROUP BY COLUMN



-- ORDER BY --

SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno
HAVING COUNT(*) > 3
ORDER BY COUNT(*) ASC; -- <-- Sorts 

