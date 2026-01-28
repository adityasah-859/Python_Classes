-- Assignment 1

CREATE DATABASE IF NOT EXISTS assignment;
USE assignment;
CREATE TABLE IF NOT EXISTS orders(
	order_id INT,
	order_date DATETIME,
    order_customer_id INT,
    order_status VARCHAR(10)
);

ALTER TABLE orders MODIFY order_status VARCHAR(50);
DESC orders;

INSERT INTO orders (order_id, order_date, order_customer_id, order_status)
VALUES
(1, '2013-07-25 00:00:00.0', 11599, 'CLOSED'),
(2, '2013-07-25 00:00:00.0', 256, 'PENDING_PAYMENT'),
(3, '2013-07-25 00:00:00.0', 12111, 'COMPLETE'),
(4, '2013-07-25 00:00:00.0', 8827, 'CLOSED'),
(5, '2013-07-25 00:00:00.0', 11318, 'COMPLETE'),
(6, '2013-07-25 00:00:00.0', 7130, 'COMPLETE'),
(7, '2013-07-25 00:00:00.0', 4530, 'COMPLETE'),
(8, '2013-07-25 00:00:00.0', 2911, 'PROCESSING'),
(9, '2013-07-25 00:00:00.0', 5657, 'PENDING_PAYMENT'),
(10, '2013-07-25 00:00:00.0', 5648, 'PENDING_PAYMENT'),
(11, '2013-07-25 00:00:00.0', 918, 'PAYMENT_REVIEW'),
(12, '2013-07-25 00:00:00.0', 1837, 'CLOSED'),
(13, '2013-07-25 00:00:00.0', 9149, 'PENDING_PAYMENT'),
(14, '2013-07-25 00:00:00.0', 9842, 'PROCESSING'),
(15, '2013-07-25 00:00:00.0', 2568, 'COMPLETE'),
(16, '2013-07-25 00:00:00.0', 7276, 'PENDING_PAYMENT'),
(17, '2013-07-25 00:00:00.0', 2667, 'COMPLETE'),
(18, '2013-07-25 00:00:00.0', 1205, 'CLOSED'),
(19, '2013-07-25 00:00:00.0', 9488, 'PENDING_PAYMENT'),
(20, '2013-07-25 00:00:00.0', 9198, 'PROCESSING');

DESC orders;

SELECT * FROM orders;

SELECT DISTINCT order_status FROM orders;

SELECT * FROM orders WHERE order_status = "COMPLETE" OR order_status = "CLOSED";

SELECT order_status,COUNT(order_status) AS count FROM orders GROUP BY order_status;


-- Case Study --

CREATE DATABASE demo1;
USE demo1;

CREATE TABLE dept(
	deptno INT,
    dname VARCHAR(14),
    loc VARCHAR(13)
);

CREATE TABLE emp (
    empno    INT,
    ename    VARCHAR(10),
    job      VARCHAR(9),
    mgr      INT,
    hiredate DATE ,
    sal      DECIMAL(7,2) ,
    comm     DECIMAL(7,2),
    deptno   INT
);

INSERT INTO dept VALUES
(10,'ACCOUNTING','NEW YORK'),
(20,'RESEARCH','DALLAS'),
(30,'SALES','CHICAGO'),
(40,'OPERATIONS','BOSTON');

INSERT INTO emp VALUES
(7369,'SMITH','CLERK',7902,'1980-12-17',800.00,NULL,20),
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600.00,300.00,30),
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250.00,500.00,30),
(7566,'JONES','MANAGER',7839,'1981-04-02',2975.00,NULL,20),
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250.00,1400.00,30),
(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850.00,NULL,30),
(7782,'CLARK','MANAGER',7839,'1981-06-09',2450.00,NULL,10),
(7788,'SCOTT','ANALYST',7566,'1982-12-09',3000.00,NULL,20),
(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000.00,NULL,10),
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500.00,0.00,30),
(7876,'ADAMS','CLERK',7788,'1983-01-12',1100.00,NULL,20),
(7900,'JAMES','CLERK',7698,'1981-12-03',950.00,NULL,30),
(7902,'FORD','ANALYST',7566,'1981-12-03',3000.00,NULL,20),
(7934,'MILLER','CLERK',7782,'1982-01-23',1300.00,NULL,10);

-- Retrieve employees whose annual salary exceeds 30,000
SELECT * FROM emp WHERE sal*12 > 30000;

-- Retrieve employees who are analysts and salesmen
SELECT * FROM emp WHERE job = "ANALYST" OR job = "SALESMAN";

-- Retrieve unique job roles
SELECT DISTINCT job FROM emp;

-- Retrieve the SALESMAN and change job title to MARKETING in the result set
SELECT ename, "MARKETING" AS job FROM emp WHERE job = "SALESMAN";

-- Retrieve the highest salary paid to employee
SELECT * FROM emp WHERE sal = (
	SELECT max(sal)
    FROM emp
);

-- Retrieve the lowest salary paid to employee
SELECT * FROM emp WHERE sal = (
	SELECT min(sal)
    FROM emp
);

-- Retrieve total number of employees
SELECT COUNT(empno) FROM emp;

-- Retrieve unique departments
SELECT DISTINCT dname FROM dept;

-- Retrieve total salary paid to each department
SELECT d.dname, SUM(e.sal) AS total_salary 
FROM dept d
LEFT JOIN emp e
ON d.deptno = e.deptno
GROUP BY d.dname;


-- 06 SHEET ----

SELECT CURDATE() AS today;

SELECT CURDATE() + INTERVAL 1 DAY AS tomorrow;

SELECT CURDATE() - INTERVAL 1 DAY AS Yesterday;

SELECT DATEDIFF(CURDATE(),CURDATE()) AS date_difference;

SELECT DATEDIFF(CURDATE(), '2025-01-23') AS date_difference;

SELECT DATE_FORMAT(CURDATE(),'%d/%m/%y') AS formatted_date;

SELECT UPPER(DAYNAME(CURDATE())) AS today;

SELECT DATE_FORMAT(CURDATE(),'%a') AS day_abbreviation;

SELECT NOW() AS curr_time;

SELECT current_time();

SELECT DATE_FORMAT(CURRENT_TIMESTAMP(),'%H:%i:%s') AS curr_Time;

SELECT STR_TO_DATE('24/09/25', '%d/%m/%y') AS converted_date;

SELECT LAST_DAY(CURDATE()) AS month_end;

