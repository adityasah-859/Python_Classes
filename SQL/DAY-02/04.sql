CREATE DATABASE demo2;
USE demo2;

CREATE TABLE dept(
	deptno INT PRIMARY KEY,
    dname VARCHAR(50) NOT NULL,
    loc VARCHAR(13)
);

CREATE TABLE emp (
    empno    INT PRIMARY KEY,
    ename    VARCHAR(10) NOT NULL,
    job      VARCHAR(9)  NOT NULL,
    mgr      INT,
    hiredate DATE NOT NULL,
    sal      DECIMAL(7,2) CHECK (sal > 0),
    comm     DECIMAL(7,2),
    deptno   INT,
    CONSTRAINT fk_deptno FOREIGN KEY (deptno) REFERENCES dept(deptno)
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


SELECT ename, sal, sal*12 AS annual_salary
FROM emp
WHERE sal*12 > 30000;

SELECT deptno, COUNT(*) AS emp_count
FROM emp
GROUP BY deptno
HAVING emp_count > 3
ORDER BY emp_count ASC;


SELECT * FROM emp
WHERE job = "SALESMAN" OR job = "ANALYST";

SELECT * FROM emp 
WHERE ename LIKE "M%";

SELECT * FROM emp
WHERE YEAR(hiredate) = 1981;

SELECT MIN(sal) AS min_sal, MAX(sal) AS max_sal
FROM emp;

SELECT * FROM emp
WHERE DAYNAME(hiredate) = "THURSDAY";

SELECT * FROM emp;

SELECT dname, COUNT(*) AS count
FROM dept AS d
LEFT JOIN
emp AS e
ON d.deptno = e.deptno
GROUP BY d.deptno
HAVING COUNT(*) > 3;


SELECT ename, TIMESTAMPDIFF(MONTH,hiredate,CURDATE()) AS number_of_month_worked
FROM emp;

DESC emp;
     
SELECT * FROM emp;
     
SELECT COUNT(*) FROM emp;
     
DESC dept;
     
SELECT * FROM dept;

SELECT COUNT(*) FROM dept;


SELECT ename,sal,dname,loc   -- <-- Cartesian Join
FROM emp, dept;

SELECT e.empno, e.ename, d.deptno, d.dname -- <-- Cross Join
FROM emp AS e 
CROSS JOIN 
dept AS d;

SELECT ename, sal, deptno, dname, loc  -- <-- Ambigious since same column in 2 tables
FROM emp, dept; -- Fails

SELECT ename, sal, dept.deptno, dname, loc -- <-- To avoid Ambigious
FROM emp, dept; 

SELECT e.ename, e.sal, d.deptno, d.dname, d.loc 
FROM emp e, dept d; -- <-- ALiasing

SELECT e.ename, e.sal, d.deptno, d.dname, d.loc 
FROM emp e, dept d 
WHERE e.deptno = d.deptno;  -- <-- Inner Join

SELECT e.ename, e.sal, d.deptno, d.dname, d.loc 
FROM emp e 
JOIN dept d -- <-- Inner Join
ON e.deptno = d.deptno;

SELECT e.ename, d.loc 
FROM emp e 
JOIN dept d 
ON e.deptno = d.deptno 
WHERE d.loc = 'CHICAGO';

SELECT e1.ename AS employee, e2.ename AS manager 
FROM emp e1 
JOIN emp e2 
ON e1.mgr = e2.empno;

SELECT e1.ename AS employee_name, e1.sal AS employee_salary,
       e2.ename AS manager_name, e2.sal AS manager_salary 
FROM emp e1
JOIN emp e2 
ON e1.mgr = e2.empno
WHERE e1.sal > e2.sal;


SELECT AVG(sal) FROM emp;

SELECT ename,sal 
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp); -- <-- emp whose salary greater than avg sal


SELECT e.ename, e.sal 
FROM emp e
JOIN (SELECT AVG(sal) AS avg_sal FROM emp) a
ON e.sal > a.avg_sal;


CREATE TABLE t1(a VARCHAR(10), b VARCHAR(10), c VARCHAR(10));
INSERT INTO t1 VALUES('x', 'y', 'z');
INSERT INTO t1 VALUES('p', 'q', 'r');

CREATE TABLE t2(a VARCHAR(10), b VARCHAR(10));
INSERT INTO t2 VALUES('x', 'y');
INSERT INTO t2 VALUES('u', 'v');

SELECT * FROM t1;
SELECT * FROM t2;

SELECT * FROM t1 JOIN t2 ON t1.a = t2.a;

SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a;  -- <-- Left Join

SELECT * FROM t1 LEFT OUTER JOIN t2 ON t1.a = t2.a; -- <-- Left Outer Join same as LEFT JOIN

SELECT * FROM t1 RIGHT JOIN t2 ON t1.a = t2.a;  -- <-- Right Join

SELECT * FROM t1 RIGHT OUTER JOIN t2 ON t1.a = t2.a; -- <-- Same as Right Join

SELECT * FROM t1 FULL JOIN t2 ON t1.a = t2.a; -- Fail on MySQL 

SELECT *
FROM t1
LEFT JOIN t2 ON t1.a = t2.a

UNION  -- <-- Use This For FULL JOIN

SELECT *
FROM t1
RIGHT JOIN t2 ON t1.a = t2.a;

SELECT 
    ROW_NUMBER() OVER (ORDER BY sal) AS rownum,  -- <-- ROWNUM Basics
    sal, ename
FROM emp;

SELECT 
    RANK() OVER (ORDER BY sal) AS rownum, -- <-- RANK - Gives Ranking Gives Ranking but if there are 2 of same rank then after the 2 there will be the next to next rank
    sal, ename
FROM emp;

SELECT 
    DENSE_RANK() OVER (ORDER BY sal) AS rownum, -- <-- DENSE RANK - Gives Ranking but if there are 2 of same rank then after the 2 there will be the next rank
    sal, ename
FROM emp;