Create database `emp1`;
use `emp1`;


-- QUESTION 1. Create the Employee  Table--
CREATE TABLE employee (
empno int(6) NOT NULL,
ename varchar(10) not NULL,
job varchar(15) not NULL,
mgr int(6) default NULL,
hiredate date not NULL,
sal int(8) not NULL,
comm int(5) default NULL,
deptno int(2) not NULL,
primary key(empno),
foreign key(deptno)
references dept(deptno)
);

INSERT INTO employee VALUES ('7369','SMITH','CLERK','7902','1980-12-17','800.00',NULL,'20');
INSERT INTO employee VALUES ('7499','ALLEN','SALESMAN','7698','1981-02-20','1600.00','300.00','30');
INSERT INTO employee VALUES ('7521','WARD','SALESMAN','7698','1981-02-22','1250.00','500.00','30');
INSERT INTO employee VALUES ('7566','JONES','MANAGER','7839','1981-04-02','2975.00',NULL,'20');
INSERT INTO employee VALUES ('7654','MARTIN','SALESMAN','7698','1981-09-28','1250.00','1400.00','30');
INSERT INTO employee VALUES ('7698','BLAKE','MANAGER','7839','1981-05-01','2850.00',NULL,'30');
INSERT INTO employee VALUES ('7782','CLARK','MANAGER','7839','1981-06-09','2450.00',NULL,'10');
INSERT INTO employee VALUES ('7788','SCOTT','ANALYST','7566','1982-12-09','3000.00',NULL,'20');
INSERT INTO employee VALUES ('7839','KING','PRESIDENT',NULL,'1981-11-17','5000.00',NULL,'10');
INSERT INTO employee VALUES ('7844','TURNER','SALESMAN','7698','1981-09-08','1500.00','0.00','30');
INSERT INTO employee VALUES ('7876','ADAMS','CLERK','7788','1983-01-12','1100.00',NULL,'20');
INSERT INTO employee VALUES ('7900','JAMES','CLERK','7698','1981-12-03','950.00',NULL,'30');
INSERT INTO employee VALUES ('7902','FORD','ANALYST','7566','1981-12-03','3000.00',NULL,'20');
INSERT INTO employee VALUES ('7934','MILLER','CLERK','7782','1982-01-23','1300.00',NULL,'10');


-- QUESTION 2 . Create the DEPT Table--
CREATE TABLE dept(deptno INT , dname VARCHAR(20),loc VARCHAR(20));
select * from dept;
INSERT INTO dept VALUES ('10','ACCOUNTING','NEW YORK');
INSERT INTO dept VALUES ('20','RESEARCH','DALLAS');
INSERT INTO dept VALUES ('30','SALES','CHICAGO');
INSERT INTO dept VALUES ('40','OPERATIONS','BOSTON');


-- Question 3.List the Names and salary of the employee whose salary is greater than 1000 --
SELECT Ename, sal
FROM Employee
WHERE Sal > 1000;


-- Question 4.List the details of the employees who have joined before end of September 81.---
Select * from employee
where hiredate <'1981-10-1';


-- Question 5.List Employee Names having I as second character. --
select ename from employee 
where SUBSTRING(ename ,2,1)='I';
 
 
 -- Question 6.List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns --
SELECT ename,sal,sal*0.4 AS Allowences,sal*0.1 AS PF,Sal * 0.5 AS NetSalary
From  employee



-- Question 7.List Employee Names with designations who does not report to anybody --
Select ename,job from employee
where job='clerk'


-- Question 8.List Empno, Ename and Salary in the ascending order of salary
select empno,ename,sal from employee
order by sal ASC;


-- Question 9.How many jobs are available in the Organization?--
select count(DISTINCT job) AS Numjobs
from employee


-- Question 10.Determine total payable salary of salesman category --
SELECT SUM(SAL) AS totalpayblesalary from employee
where job='salesman';


-- Question 11.	List average monthly salary for each job within each department --
select job,deptno,avg(sal) AS Averagemonthlysalary from employee
group by job,deptno;


-- Question 12.	Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working.
select e.ename,e.sal,d.dname AS deptname from employee e
Join DEPT d on e.deptno=d.deptno;

-- Question 13. create salary grade table--
salgrade table
CREATE TABLE salgrade (
grade int,
losal int,
hisal int
);
INSERT INTO salgrade VALUES (1, 700, 1200);
INSERT INTO salgrade VALUES (2, 1201, 1400);
INSERT INTO salgrade VALUES (3, 1401, 2000);
INSERT INTO salgrade VALUES (4, 2001, 3000);
INSERT INTO salgrade VALUES (5, 3001, 9999);


-- Question 14. Referring to grades and their corresponding salary range from the above table fetch the name of the employee, salary, and the corresponding Grade from the employee table (You can use case statements)--
select * from salgrade;
SELECT 
    ename AS Employee_Name,
    sal AS Salary,
    CASE 
        WHEN sal BETWEEN 700 AND 1200 THEN 'Grade 1'
        WHEN sal BETWEEN 1201 AND 1400 THEN 'Grade 2'
        WHEN sal BETWEEN 1401 AND 2000 THEN 'Grade 3'
        WHEN sal BETWEEN 2001 AND 3000 THEN 'Grade 4'  
        WHEN sal BETWEEN 3001 AND 9999 THEN 'Grade 5'
        ELSE 'Grade 5 or below'
    END AS Grade
FROM 
    employee;


-- Question 15.Display the Emp name and the Manager name under whom the Employee works in the below format . (Emp Report to Mgr) --
SELECT e.ename AS "Emp", m.ename AS "Mgr"
FROM employee e
JOIN employee m ON e.ename = m.ename;

 
 
 -- Question 16.Display Empname and Total sal where Total Sal (sal + Comm)--
SELECT Ename, (sal + COALESCE(Comm, 0)) AS "Total Sal"
FROM Employee;


-- Question 17.	Display Empname and Sal whose empno is a odd number --
select ename,sal from employee 
where empno % 2 !=0;

 
-- Question 18.Display Empname , Rank of sal in Organisation , Rank of Sal in their department --
SELECT 
    Ename,
    RANK() OVER (ORDER BY sal DESC) AS "Rank of sal in Organisation",
    RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) AS "Rank of Sal in dept"
FROM 
    Employee;



-- Question 19.Display Top 3 Empnames based on their Salary --
select ename,sal from employee
order by sal DESC
LIMIT 3;



-- Question 20.Display Empname who has highest Salary in Each Department. --
WITH RankedEmployee AS (
    SELECT 
        Ename,
        sal,
        Deptno,
        RANK() OVER (PARTITION BY Deptno ORDER BY sal DESC) AS SalaryRank
    FROM 
        Employee
)

SELECT 
    Ename,
    Deptno,
    sal AS "Highest Salary"
FROM 
    RankedEmployee
WHERE 
    SalaryRank = 1;





















































































