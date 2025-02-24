use employees;
-- Employees database is already added database, which is nothing but MySQL official website's practice database

#################################################################################################
                                 ## Session-02 : SQL Cmmands ##
#################################################################################################
/*
1) DDL (Data Definition Language) :-
   CREATE, ALTER, DROP, TRUNCATE, RENAME
-  These commands changes the structure , definition of database.
-  These commands are AUTO-COMMITTED means they saves the changes to the database permanently.

2) DML (Data Manipulation Language) :-
   INSERT, UPDATE, DELETE
-  Use to do modifications in to database. 
-  DML commands are NOT AUTO-COMMITTED means it cann't permanently save the changes in to database.
-  It can rollback (Use to rollback the transaction). 

3) DCL (Data Control Language) (Administrative Use):-
   GRANT, REVOKE
-  Use to grant and take back authorities from user.

4) TCL (Transaction Control Language) :-
   COMMIT, ROLLBACK, SAVE POINT (Rollback up to the particular point)

5) DQL (Data Query Language) :-
   SELECT
   
   
   ## We can create database using two commands - 
   CREATE DATABASE Database_Name;
   CREATE SCHEMA Database_Name;
   
   # We can apply check
   CREATE DATABASE IF NOT EXIST Database_Name;
   
*/
select * from employees; -- It is a employees table
select * from departments;
describe employees;
select emp_no, first_name from employees;
#################################################################################################
## Session-03 : Import SQL File , Select Command , SQL Data Types , Where Clause (Filter data) ##
#################################################################################################
-- we can use aliases, insted of emp_no & first_name such as ENO, FNAME --
select emp_no, first_name from employees;
select emp_no ENO, first_name FNAME from employees;

select * from employees where first_name like 'e%';
select * from employees where first_name like '%en';
select * from employees where first_name like '_a%';

select * from salaries;
select * from salaries where salary > 70000;
select emp_no, salary from salaries;

-- we can increase salary to each emps salary by +10000 --
select emp_no, salary+10000 from salaries;

select * from salaries where salary between 70000 and 80000;

-- Use titles table --
select * from titles;
-- Retrieve Senior Staff and Senior Engineer from titles table --
select * from titles where title in('Senior Staff', 'Senior Engineer');

-- (If the table contains null values, we can fetch the data using where clause) --
-- we can not use (where title = null)- will show error
-- hence we have to use (where title is null)) - will not show error
-- (e.g. SELECT * FROM titles WHERE title IS NULL ) -- 

##############################################################################################
                   ## Session-04 : ORDER BY clause & DISTINCT clause ##
##############################################################################################
-- ORDER BY clause --
## for sorting the rows in the table ##

use classicmodels;
select * from customers;
select * from customers order by contactLastName;
-- This will sort 'contactLastName' rows in alphabetical order -- 
-- By default will sort in Ascending Order --

-- To sort in Descending Order --
select * from customers order by contactLastName desc;

-- Can sort by multiple columns --
select contactLastName LNAME, creditLimit CREDIT from customers order by contactLastName ASC, creditLimit DESC;

-- Sorting on basis of calculation --
select * from orderdetails;
select orderNumber, orderLineNumber, quantityOrdered * priceEach as sumOrderPrice from orderdetails order by  orderNumber;
select orderNumber, orderLineNumber, quantityOrdered * priceEach as sumOrderPrice from orderdetails order by  sumOrderPrice;
-- ========================================================================== --

-- Q. How ORDER BY keyword will treat null values --
-- [REMEMBER: null will always < not null values] --

select * from employees;
select firstName, reportsTo from employees order by reportsTo asc;
-- this will return null value first
select firstName, reportsTo from employees order by reportsTo desc;
-- this will return null value last
-- ======================================================================== --

-- DISTINCT clause --
## Remove duplicates ##

-- Q. How DISTINCT keyword will treat null values --
select * from customers;
select state from customers;

select distinct state from customers;
-- DISTINCT keyword will display null value as once --
-- [REMEMBER: null will always < not null values] --
-- ==================================================================== --
select city, state from customers where state is not null;
select distinct city, state from customers where state is not null;

##############################################################################################
                   ## Session-05 : OPERATORS - AND , OR , NOT IN ##
##############################################################################################
#  AND - Operator 
-- The AND operator displays a record if all the conditions are TRUE.
## AND operator used in the WHERE clause of the SELECT, UPDATE, DELETE statements to form a condition.
## It also used to filter records based on more than one condition. 

use classicmodels;

select * from customers;

select customername, state, country from customers
where state = 'CA' and country = 'USA';
-- Here both the conditions should be true

select customername, state, country from customers
where state = 'NY' and country = 'USA';

-- To get the customerName from state CA and NY and from country USA 
select customername, state, country from customers
where state = 'CA' or state = 'NY' and country = 'USA'
order by state;

-- ==================================================================================
# OR - Operator
-- Here either one of the conditions should be true
select customername, state, country from customers
where state = 'CA' or country = 'USA';

-- ==================================================================================
# AND , OR Operators combined
select * from customers;

select customername, country, creditLimit from customers
where (country = 'USA' or country = 'France') and creditLimit > 100000;

-- ==================================================================================
# OR - Operator
-- The NOT operator is used in combination with other operators to give the opposite result
select * from customers;
select * from customers where customerName like 'A%';
select * from customers where city = 'Madrid';
-- Negate above query to return opposite result
select * from customers where customerName not like 'A%';

-- ==================================================================================
# BETWEEN :- Operator
select * from customers where creditLimit between 70000 and 85000;
select * from customers where creditLimit not between 10000 and 120000;

select * from customers where creditLimit between 70000 and 85000 order by creditLimit desc;

-- ==================================================================================
# IN :- Operator
-- The IN operator allows you to specify multiple values in a WHERE clause.
select customerName, country from customers where country in ('USA','France','Poland');
select customerName, country from customers where country not in ('USA','France','Poland') order by country;

select customerName, country from customers where country in ('USA','France','Poland') order by country;

select customerName from customers where country = 'France';

-- ==================================================================================
# Greater Than (>) and Less Than (<) :- Operator
select customerName, creditLimit from customers where creditLimit > 125000;
select customerName, creditLimit from customers where creditLimit < 20000;

##############################################################################################
		 ## Session-06 : DDL COMMANDS : CREATE  ALTER  DROP  TRUNCATE  RENAME ##
##############################################################################################
use testDB_codestudio;
# CREATE command (DDL):-

create database testDB_codestudio;

use testDB_codestudio;

-- Different dataTypes can be use in Table
-- INT, VARCHAR, CHAR, DATE, TINYINT, TIMESTAMP, TEXT etc.

create table student(
ID int auto_increment primary key,
Name varchar(20) not null,
DOB date not null,
Age tinyint,
CreatedAt TIMESTAMP DEFAULT current_timestamp,
Remarks TEXT
); 

desc student;

insert into student (Name, dob, age, remarks) values ("Ishita", '2018-09-18', 5, "Sr.Kg. student");

select * from student;

insert into student (Name, dob, age, remarks) values ("Deepika", '1992-02-08', 30, "M.Com student");

-- Add DOA(Date of Admission) column to student table
alter table student add DOA datetime default current_timestamp;
desc student;

insert into student (Name, dob, age, remarks) values ("Vivek", '1987-11-08', 35, "B.E. student");
-- =================================================================================

# ALTER command (DDL):-
-- To modify column in table
-- Change the dataType of 'Remarks' column from Text dataType to Varchar dataType

alter table student modify Remarks VARCHAR(100);
alter table student modify Name VARCHAR(25);
desc student;
# If data present in column, If we increase the width of name from 20 to 25, there will be no issue
# But, we cant reduce the size 20 to 5. If data present in column, We have to delete the names data first, then we've to reduce the size.
# But, here 25 to 20 will be allowed.
-- =================================================================================

-- To rename the column name

alter table student change Name FirstName varchar(20);

-- =================================================================================

-- To change the position of column

-- Also to change the DOB to DateOfBirth after CreatedAt
alter table student change DOB DateOfBirth date after CreatedAt;
-- =================================================================================

select * from student;
desc student;
-- To change the position of column
alter table student modify Age tinyint after DateOfBirth;

alter table student modify CreatedAt timestamp default current_timestamp after Remarks;

-- ====================================================================================

-- We can also use RENAME command to rename the column name instead of CHANGE
-- alter table student RENAME column DateOfBirth to DOB;
-- =====================================================================================

-- Modify multiple columns (Change DataTypes) at the same time
alter table student modify Remarks text, modify FirstName text;
desc student;

-- Use of length() function
select * from student where length(FirstName)=10;
-- =====================================================================================

# DROP command (DDL):-
-- Drop the column from table
-- DROP will remove data as well as Table Structure
alter table student drop column DOA;
-- =====================================================================================

# TRUNCATE command (DDL):- (Can NOT Rollback) 
-- TRUNCATE will remove data from table but, table structure remains same
-- truncate table students;
-- =====================================================================================

# DELETE command :- (Can be Rollback)
-- Will remove data from the row
delete from student where ID=3;
select * from student;
-- =====================================================================================

# ROLLBACK command
-- [In MySQL autocommit is 'on', by default. We've to set it 'off' to use ROLLBACK command]
set autocommit = on;
-- [NOTE: autocommit should be ON always because it is MySQL's default setting]
rollback;

insert into student (Name, dob, age, remarks) values ("Vivek", '1987-11-08', 35, "B.E. student");
-- Error Code: 1054. Unknown column 'Name' in 'field list' because later we've modified column name : Name > FirstName

desc student;

insert into student (FirstName, DateOfBirth, Age, Remarks) values ("Vivek", '1987-11-08', 35, "B.E. student");
select * from student;
delete from student where ID=4;
-- =====================================================================================

# RENAME command (DDL)
-- Use to rename Table Name
rename table student to studentDB;
select * from student;
select * from studentDB;

alter table studentDB rename to student;
-- =====================================================================================
# [NOTE: Drop the table and create again to practice DDL commands]
drop table student;
select * from student;
show tables;
-- =====================================================================================

#########################################################################################################################################
                   ## Session-07 :  String Functions (Lower, Upper, Ltrim, Rtrim, Concat, Instr, Substring etc) ##
#########################################################################################################################################
use classicmodels;

select lower('OracLE');
select upper('oracle');
select * from employees;
select lower(firstName) from employees;
select upper(firstName) from employees;
-- ======================================================================
select ltrim('      Oracle'); -- Removes leading space
select rtrim('        oracle    '); -- Removes trailing space
select trim('        Nokia    '); -- Removes both spaces
select trim('f' from 'ffMicrosoft');
select trim('f' from 'ffMicrosoftfff');
-- ======================================================================
select concat("Mic","rosoft");

select * from employees;
select concat(firstName,"  ",lastName) from employees;
-- ======================================================================

# INSTR() :- Returns position of the occurence of a string. e.g. 5
select instr("abcdefg", "efg"); -- > 5 (position of e on 5th number)
select instr("abcdefg", "abc"); -- > 1

select * from products;
select * from products where instr(productLine, "Cars") > 0;
-- ======================================================================

select length("Vivek");
use classicmodels;
select * from classicmodels.employees;
select firstName, length(firstname) as LengthOfString from employees;
-- ======================================================================

select replace("Red Hat", "Red","Green");
select replace("Red Hat Red", "Red","Green");
-- ======================================================================
-- SYNTAX :- 
select substring("String", start, length);

select substring("Microsoft",6,9); -- soft
select substring("Microsoft",1,5); -- Micro


#########################################################################################################################################
                   ## Session-08 : Numeric Functions, Aggregate Functions, DateTime Functions ##
#########################################################################################################################################
use classicmodels;

-- ===============================================================================================
                           	-- ### -- NUMERIC FUNCTIONS -- ### --
-- ===============================================================================================


-- ABS() function : Returns the absolute value of a number
select abs(234.56);   -- 234.56
select abs(50.60);
select abs(70);   -- 70
-- ===============================================================================================

-- MOD() function : Returns the reminder of a number divided by another
select mod(13,5); -- 3 (13 divided by 5) 
select 13 % 5;    -- 3
select 23 % 2;    -- 1

select mod(25,3); -- 1 (25 divided by 3)
-- ===============================================================================================

-- ROUND() function : Rounds a number to a specified number of decimal places.
-- Syntax: ROUND(Number,Decimals)
-- Default value of decimal is always 0

select round(23.45,1);  -- 23.5
select round(-23.45);  -- -23
select round(41.36899,3);  -- 41.369
select round(41.36899);  -- 41
select round(41.36899,2);  -- 41.37
select round(12.44,0);  -- 12

-- ===============================================================================================

-- TRUNCATE() function : Truncates a number to a specified number of decimal places.
-- Basically Trim
-- Syntax: TRUNCATE(Number,Decimals)

select truncate(1.5555486,2);  -- 1.55
select truncate(1.5555486,4);  -- 1.5555
select truncate(123456,-2);  -- 123400
select truncate(23.45, 0);  -- 23

-- ===============================================================================================

-- SQRT() function : Returns a square root of a number.

select sqrt(100);  -- 10
select sqrt(02);  -- 1.4142135623730951
select sqrt(81);  -- 9


-- ===============================================================================================
                           	-- ### -- AGGREGATE FUNCTIONS -- ### --
-- ===============================================================================================
-- SUM, COUNT, MAX, MIN, AVG

use classicmodels;
select * from orderdetails;

-- sum() function : gives the summation of given expression. Returns sum of all values in set.
select sum(quantityOrdered) from orderdetails;
select * from orderdetails where orderNumber = 10102;
select sum(quantityOrdered*priceEach) as totalOrder from orderdetails where orderNumber = 10102;
-- ===============================================================================================

-- avg() function : 

select * from products;
select avg(buyPrice) from products;
-- ===============================================================================================

-- count() function : 

-- It returns the no of rows in a group, including rows with null values.
-- Simply, it returns no. of rows.
select count(*) from products where productLine = "Planes";
select count(*) from products where productLine = "Motorcycles";
select count(*) from products where productCode = "S10_2016";


select * from customers;
select count(*) from customers where country = "Spain";
select * from customers where country = "Spain";
select count(*) from customers where city = "NYC";
-- ===============================================================================================

-- max() function :
 
select * from payments;
select amount from payments;
select max(amount) from payments;
select min(amount) from payments;

select customerNumber, max(amount) from payments;
select * , min(amount) from payments;

-- ===============================================================================================
                           	-- ### -- DATE / TIME FUNCTIONS -- ### --
-- ===============================================================================================

-- curdate() :
-- current_date()  :

select current_date(); -- yyyy-mm-dd --
select curdate(); -- yyyy-mm-dd --
-- ===============================================================================================

-- datediff() :

select datediff('2023-10-11','2023-10-11');   -- 0
select datediff('2023-10-11','2023-10-10');   -- 1
select datediff('2023-10-11','2023-10-15');   -- (-4)
select datediff('2023-10-15','2023-10-11');   -- 4
select datediff('2024-01-07','2023-12-23');   -- 15

select * from orders;
select orderNumber, datediff(requireddate, shippeddate) as daysLeft from orders where status = "Shipped"; 
select orderNumber, datediff(requireddate, shippeddate) as daysLeft from orders where status = "Shipped" order by daysLeft desc;

select now();
-- ===============================================================================================

-- timediff() :
-- Calculates the difference between two TIME or DATETIME values

select timediff('12:00:00','08:00:00');    -- 04:00:00
select timediff('2023-10-09 16:04:16','2023-10-09 13:00:30');   -- 03:03:46
-- ===============================================================================================

-- Month() function: 
-- Returns integer that represents a month of a specified date.

select month('2023-07-12');    -- 7
select month(now());     -- 10
select month(curdate());     -- 10
-- ===============================================================================================

-- day() function :
-- Returns the day of a specified date.

select day('2023-07-12');    -- 12
select day(now());     -- 7 (2024-01-07)
select day(curdate());     -- 7 (2024-01-07)

select * from orders;
select orderNumber, orderDate, day(orderdate) as orderDay from orders;   -- 10100	2003-01-06	6
-- ===============================================================================================

-- week() function :
-- Returns week of the year of selected Date.

select week('2023-03-17');  -- 11th week
select week(now());    -- 41st week
select week(curdate());    -- 41st week

-- ===============================================================================================

-- year() function :
-- Returns year of selected Date.

select year('2021-03-17');  -- 2021
select year(now());    -- 2023
select year(curdate());    -- 2023

select * from orders;
select orderNumber, year(orderDate) as year, status, orderDate from orders order by status;

#########################################################################################################################################
                   ## Session-09 : GROUP BY CLAUSE,  WHERE CLAUSE,  HAVING CLAUSE,  ORDER BY CLAUSE ##
#########################################################################################################################################

use project_hr;
/*
   1) We need to create project_hr database --
   2) Open 'Create_Structure' SQL Script:
	  -->  File > Open SQL Script > F:\Automation Testing\Automation By Prachi Gupta (Hindi)\SQL Tutorial by Prachi\Databases\Project_hr
          > project_hr > open file 'create_structure.sql' > Select ALL > Execute
      -->  Structure will be created

   3) Open 'Insert_Data' SQL Script:
      -->  File > Open SQL Script > project_hr > open file 'insert_data.sql' > Select ALL > Execute
      -->  Data will be inserted
*/

create database project_hr;
use project_hr;

-- ===============================================================================================
                           	-- ### -- GROUP BY clause-- ### --
-- ===============================================================================================
-- GROUP BY clause return unique records from the columns.
-- It is used to collect the data from multiple columns and group by one or more columns.
-- The selected column of the GROUP BY clause must be the part of SELECT clause
-- GROUP BY clause Will always used with aggregate functions.

select * from employees;

-- count how many employees are working in each department.
select department_id, count(*) from employees group by department_id;
select  department_id , count(employee_id) from employees group by department_id;

select * from employees where department_id = 5;

-- get the sum of the salary from each department
select department_id, sum(salary) from employees group by department_id;
select department_id, max(salary), min(salary) , sum(salary) from employees group by department_id;

select job_id, department_id, count(*) from employees group by job_id, department_id;

select * from employees;
-- ===============================================================================================
                           	-- ### -- HAVING clause -- ### --
-- ===============================================================================================
/*
Filter records based on condition
--------------------------------
HAVING clause - Comes after GROUP BY clause 
WHERE clause - comes before GROUP BY clause

Order BY clause - use to sort the results
-- The selected column of the GROUP BY clause must be the part of SELECT clause
*/

-- get the no of records as per job_id
select job_id, count(*) from employees group by job_id;

select job_id, count(*) as NumberOfEmployees from employees group by job_id having count(*) > 3;

-- Return the sum of salary from each department
select department_id, sum(salary) from employees group by department_id;

select department_id, first_name, last_name, sum(salary) from employees group by department_id having sum(salary)>40000;
select department_id, first_name, last_name, salary, sum(salary) from employees group by department_id having sum(salary)>40000;
# Here salary is individuals salary, and sum(salary) is Total salary of each department.

select department_id, first_name, last_name, sum(salary) from employees where department_id <> 9 group by department_id having sum(salary)>20000;

select * from employees where first_name = 'Steven' and last_name = 'King';



-- ===============================================================================================
                           	-- ### -- ORDER BY clause -- ### --
-- ===============================================================================================
select * from employees order by salary desc;
select department_id, sum(salary) from employees where department_id <> 6 group by department_id having sum(salary) > 20000 order by sum(salary);

#########################################################################################################################################
                   ## Session-10 : SET OPERATORS : UNION  & UNION ALL,  INTERSECT,  EXCEPT (a.k.a. MINUS) ##
#########################################################################################################################################

/*
1) UNION - Used to combile two or more sets from multiple SELECT statements in to a single result set.
         - Removes duplicates and keep the distinct values.
      
2) UNION ALL - Used to combine two or more sets of SELECT statements in single set.
             - Allow/add the duplicate values, it will return duplicate values records also
          
3) INTERSECT - (INTERSECT was added in MySQL 8.0.31.) - Used to compare the sets of two queries and returns the common rows.

   INTERSECT ALL - Allows duplicates
   
4) EXCEPT (a.k.a. MINUS) - (EXCEPT was added in MySQL 8.0.31.) - Allows to retrieve rows from one query that do not appear in another query.
		                 -  EXCEPT is used to find the difference between two sets of data.
*/

use testdb_codestudio;

create table t1 (
 id int
);
create table t2 (
id int
);

insert into t1 values (1),(2),(3);
insert into t2 values (2),(3),(4);

-- UNION --
select * from t1
union
select * from t2;

-- UNION ALL --
select * from t1
union all
select * from t2;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
use classicmodels;

select * from employees;
select * from customers;

select firstname from employees
union distinct         -- Not necessary to mention distinct
select contactFirstName from customers;

-- 1) The no. of columns in all the SELECT statements must be the same.
select firstname from employees
union all
select contactFirstName from customers;

-- 2) order of column must be same
select firstname, lastname from employees
union all
select contactFirstName, contactLastName from customers;

/*
Rules to use UNION operator:
1) The no. of columns in all the SELECT statements must be the same.
2) The order of columns in all the SELECT statements must be same.
3) The Data Types of the corresponding coumns in both SELECT statements must be the same or simillar or convertible/compatible.
*/

select concat(firstname, " ", lastname) as FullName from employees
union all
select concat(contactFirstName, " ", contactLastName) from customers;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- INTERSECT --
-- It will return the common record
use testdb_codestudio;

select * from t1;
-- intersect
select * from t2;

-- [NOTE: MySQL Workbench Do NOT support INTERSECT command]
-- Open 'MySQL 8.0 Command Line Client' [BUT its not working]
-- TYPE : select * from t1 intersect select * from t2;

-- EXCEPT (a.k.a. MINUS) operator - 
-- t1 EXCEPT t2 >>>>>> means >>>>> t1 MINUS t2

#########################################################################################################################################
				##  Session-11 : JOINS : INNER JOIN, LEFT JOIN, RIGHT JOIN ,CROSS JOIN, FULL JOIN  ##
#########################################################################################################################################
use classicmodels;

/*
Joins are used with SELECT statement. Joins are used to retrieve data from multiple tables.
The tables are inter-related using primary and foreign key.
*/

-- ===============================================================================================
                           	-- ### -- INNER Join -- ### --
-- ===============================================================================================
-- It retrieves matching records.
-- create database joins_codestudio;
use joins_codestudio;

create table t1 (
num int
);
create table t2 (
num int
);

insert into t1 values (10),(11),(12),(14);
insert into t2 values (11),(12),(13),(15);

select * from t1;
select * from t2;
select * from t1 inner join t2 on t1.num = t2.num;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

use project_hr;
select * from employees;
select * from departments;

select * from employees inner join departments on employees.department_id = departments.department_id;

-- We wish to print - ProductCode, ProductName, textDescription
use classicmodels;
select * from products;
select * from productlines;

select productCode, productName, textDescription from products inner join productlines on products.productLine = productlines.productLine;

-- ===============================================================================================
                           	-- ### -- LEFT Join / LEFT OUTER Join -- ### --
-- ===============================================================================================
-- Returns matched records + Unmatched records (all records) from left table
use joins_codestudio;
select * from t1 left join t2 on t1.num = t2.num;

-- Retrieve the records of customer who has no any order (orderNumber should have NULL values) --
use classicmodels;
select * from customers;
select * from orders;

select customers.customerNumber, customerName, orderNumber from customers left join orders on customers.customerNumber = orders.customerNumber;
select customers.customerNumber, customerName, orderNumber from customers left join orders on customers.customerNumber = orders.customerNumber where orderNumber is null;
select customers.customerNumber, customerName, orderNumber from customers left join orders on customers.customerNumber = orders.customerNumber where orderNumber is not null;
/* 
NOTE:-
[If use as 'select customerNumber, customerName, orderNumber from customers left join .......']
will throw error:-
Error Code: 1052. Column 'customerNumber' in field list is ambiguous
*/

-- ===============================================================================================
                           	-- ### -- RIGHT Join / RIGHT OUTER Join -- ### --
-- ===============================================================================================
-- Returns matched records + Unmatched records (all records) from right table

use joins_codestudio;
select * from t1 right join t2 on t1.num = t2.num;

-- get the record of employees who are not the sales representative of any customer --
use classicmodels;
select employeeNumber, customerNumber from customers right join employees on salesRepEmployeeNumber = employeeNumber;
select employeeNumber, customerNumber from customers right join employees on salesRepEmployeeNumber = employeeNumber where customerNumber is null;

-- ===============================================================================================
                           	-- ### -- CROSS Join / CARTESIAN Join -- ### --
-- ===============================================================================================
-- It is used to generate a paired combination of each row of the first table with each row of the second table
use joins_codestudio;
select * from t1 cross join t2;


-- ===============================================================================================
                           	-- ### -- FULL Join / FULL OUTER Join -- ### --
-- ===============================================================================================
-- Returns matched records from both tables + Unmatched records from left table + Unmatched records from right table
-- Will retrieve all the records from both the tables whether it is matching or not.
-- [NOTE: MySQL dosen't support FULL JOIN, hence skipping this practical example]


#########################################################################################################################################
			                                	##  Session-12 : Sub-Queries  ##
#########################################################################################################################################
/*
# Single row sub-query (Subquery to return single row)
-- In this, we use (<=, >=, !=) operators.
# Multi row sub-query (Subquery to return multiple row)
-- In this, we use (IN, ANY, ALL) operators.

Subquery is a nested query within another query such as SELECT, INSERT, UPDATE or DELETE.
Also a subquery can be nested within another subquery.

A MySQLsubquery is called Inner Query while the query that contains the subquery is called Outer Query
*/

-- ====================================================================================== --
                               ## Single row sub-query ##
-- ====================================================================================== --
use project_hr;
select * from employees;

select * from employees where salary > 12000;
select salary from employees where first_name = 'Michael';

-- Q. Return the employees whose salary is greater than Michael's salary.
select * from employees where salary > (select salary from employees where first_name = 'Michael');
-- ------------------------------------------------------------------------------------------- -- 

use classicmodels;
select * from payments;

-- Q. Return the customer who has the highest payment
select customerNumber, checkNumber, amount from payments where amount = (select max(amount) from payments);

-- ------------------------------------------------------------------------------------------- -- 
-- Q. List the employees having highest salaries
use project_hr;
select * from employees;

select max(salary) from employees;
select employee_id, first_name, last_name, salary from employees where salary = (select max(salary) from employees);

select salary from employees order by salary desc;

-- Q. 2nd highest salary from employees table
select max(salary) from employees where salary < (select max(salary) from employees);

-- Q. 3rd highest salary from employees table
select max(salary) from employees where salary < (select max(salary) from employees where salary < (select max(salary) from employees));

-- Q. Top 5 salary from employees table
select distinct salary from employees order by salary desc limit 5;

-- ====================================================================================== --
                               ## Multi row sub-query ##
-- ====================================================================================== --
use classicmodels;
select * from orders;
select * from customers;

select distinct customerNumber from orders;
-- This well return the customers who placed the order

-- Q. Return the customers who have not placed any order
select customerName from customers where customerNumber NOT IN (select distinct customerNumber from orders);

-- Q. Query to get first_name, last_name, department_id, departmentName of Steven King from employees table.
-- In this table departmentName is not present , it is in another department table 
select * from employees; 
select * from departments;

select  first_name, last_name, department_id, (select department_name from departments where employees.department_id = departments.department_id) departmentName from employees;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -- 




#########################################################################################################################################
			                                	##  Session-13 : Constraints  ##
#########################################################################################################################################
-- Constraints are rules that allows or restricts what values/data will be stored in table.
# NOT NULL         # UNIQUE      
# PRIMARY KEY      # FOREIGN KEY      # COMPOSITE KEY
# CHECK            # DEFAULT          # AUTO-INCREMENT

 -- ===================================================================================== --
                           	-- ### -- NOT NULL CONSTRAINT -- ### --
-- ====================================================================================== --
-- Specifies that the column cannot have null or empty values.
-- column_name data_type NOT NULL;

create database  constraints_codestudio;
use constraints_codestudio;

create table student (
ROLL int not null,
FNAME varchar(20) not null,
LNAME varchar (20) not null,
MARKS int
);

desc student;
insert into student values (1, 'Ishita', 'Shirsath', 99);
select * from student;
insert into student values(2, null, 'Chavan', 80);
-- [Error Code: 1048. Column 'FNAME' cannot be null]
	
drop table student;
show tables; -- student should not be present

 -- ============================================================================================= --
                              	-- ### -- UNIQUE CONSTRAINT-- ### --
-- ============================================================================================== --
-- This constraint ensures that all the values in the column should be unique. 
-- Duplicates not allowed of other dataTypes. 
-- Null duplicates allowed, 
 
create table student(
ROLL int unique,
FNAME varchar(20) unique,
LNAME varchar(20),
MARKS int
);

desc student;
select * from student;

insert into student values (1,'Seeta','Patil',85);
insert into student values (2,'Ram','Patil',86);
-- Error Code: 1062. Duplicate entry '1' for key 'ROLL'

insert into student values (null, 'Deepika','Shirsath',98);
insert into student values (null,'Vivek','Shirsath',95);

insert into student values (null, null, 'Sonawane',85);
insert into student values (null, null, null,85);
insert into student values (null, null, null,null);
insert into student values (3, 'Shyam', null,78);

drop table student;


 -- ============================================================================================= --
                              	-- ### -- PRIMARY KEY CONSTRAINT -- ### --
-- ============================================================================================== --
-- PRIMARY KEY constraint is used to identify each record uniquely. 
-- If any column that contains Primary Key, then that column cannot be null or empty.
-- Duplicates not allowed in column containing primary key. 

create table student(
ROLL int primary key ,
FNAME varchar(20),
LNAME varchar(20),
MARKS int
);
desc student;
select * from student;
insert into student values (1,'Vivek','Shirsath',99);
insert into student values (2,'Deepika','Shirsath',98);

-- Duplicates not allowed with Primary Key
insert into student values(1,'Ishita','Shirsath',87);
-- Error Code: 1062. Duplicate entry '1' for key 'PRIMARY' --

-- Nulls not allowed with Primary Key
insert into student values(null,'Mayur','Shirsath',87);
-- Error Code: 1048. Column 'ROLL' cannot be null -- 
drop table student;

-- ============================================================================================= --
                              	-- ### -- COMPOSITE KEY CONSTRAINT -- ### --
-- ============================================================================================= --
/* It is a combination of two or more columns in a table that allows us to identify each row of the table uniquely. 
e.g. 
    Consider a student table having below columns
    Roll | Fname | Lname | Mobile | Marks
# In this table (Roll and Mobile) of student should be unique.
  Combination of both will be unique
  Mobile no may be duplicate here, but combination is unique.
# (Fname, Lname, Marks) may be duplicate.
*/

create table student(
ROLL int,
FNAME varchar(20),
LNAME varchar(20),
MOBILE varchar(20),
MARKS int,
primary key(ROLL,MOBILE)
);

desc student;
select * from student;

insert into student values (1,'Vivek','Shirsath','9988774455',84);
insert into student values (1,'Vivek','Shirsath','9988774466',84);
insert into student values (2,'Vivek','Shirsath','9988774455',84);
insert into student values (2,'Vivek','Shirsath','9988774455',84);
-- 4th record show error, same combination duplicated
-- Error Code: 1062. Duplicate entry '2-9988774455' for key 'PRIMARY'	

-- ============================================================================================= --
							  -- ### -- FOREIGN KEY CONSTRAINT -- ### --
-- ============================================================================================= --
# It is used to link two tables together.
# FOREIGN KEY of second table refers to the same column having PRIMARY KEY of first table
show tables;

create table department(
dept_id int primary key,
dept_name varchar(20)
);

create table employee(
emp_id int primary key,
emp_name varchar(20),
dept_id int,
foreign key(dept_id) references department(dept_id)
);

insert into department values(1,'IT');
insert into department values(2,'HR');
insert into department values(3,'PAYROLL');
insert into department values(4,'ADMIN');

select * from department;

insert into employee values(1,'Mark', 1);
insert into employee values(2,'John', 1);
insert into employee values(3,'Mike', 2);
insert into employee values(4,'Mary', 3);

select * from employee;

-- If we try to add another emp in employee table with 'dept_id = 7'
-- We can't add employee if the dept dont exist.
-- First, we need to create the dept, then we need to add the emp with the newly added dept_id.

insert into employee values(5,'Thomas', 7);
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails

-- Q. Can we insert null values in FOREIGN KEY column?
insert into employee values(6,'Steve', null);
-- Ans:-   YES

-- Values in parent table that are referenced by child table cannot be deleted or updated, unless you have cascading actions.
-- (On delete cascading action)
-- However values of parent table that are not present in child table can be deleted or updated.

-- ===================================================================================== --
                               --  ON DELETE CASCADE  --

## Delete the table and create again for 'on delete cascade'.
-- We can not delete parent table directly, first we need to delete child table first.
-- If we try to delete parent table first, will show error
drop table employee; -- child table
drop table department; -- parent

create table department(
dept_id int primary key,
dept_name varchar(20)
);             -- parent table

create table employee(
emp_id int primary key,
emp_name varchar(20),
dept_id int,
foreign key(dept_id) references department(dept_id) on delete cascade
);           -- child table

insert into department values(1,'IT');
insert into department values(2,'HR');
insert into department values(3,'PAYROLL');
insert into department values(4,'ADMIN');

select * from department;

insert into employee values(1,'Mark', 1);
insert into employee values(2,'John', 1);
insert into employee values(3,'Mike', 2);
insert into employee values(4,'Mary', 3);

select * from employee;

## On Delete Cascade is enabled in child table. If we delete any department from parent tbl,
-- The records from child table will also delete, bcoz of 'ON DELETE CASCADE' effect
delete from department where dept_id = 1;

drop table department; -- parent tbl
drop table employee; -- child tbl


-- ===================================================================================== --
                               --  ON UPDATE CASCADE  --

## We have to delete the previous tables first
-- First delete child (employee) tbl and then delete parent (department) tbl
-- Create both tbl again for 'ON UPDATE CASCADE'

create table department(
dept_id int primary key,
dept_name varchar(20)
);             -- parent table

create table employee(
emp_id int primary key,
emp_name varchar(20),
dept_id int,
foreign key(dept_id) references department(dept_id) on delete cascade on update cascade
);           -- child table

insert into department values(1,'IT');
insert into department values(2,'HR');
insert into department values(3,'PAYROLL');
insert into department values(4,'ADMIN');

select * from department;

insert into employee values(1,'Mark', 1);
insert into employee values(2,'John', 1);
insert into employee values(3,'Mike', 2);
insert into employee values(4,'Mary', 3);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
			  ######## -- DEFAULT CONSTRAINT IMPLEMENTATION EXAMPLE -- #########
              
## Add emp_status column in employee table
alter table employee add emp_status varchar(20) default('Not_Joined');                               
desc employee;
insert into employee (emp_id, emp_name, dept_id, salary, gender) values(5, 'Fredrick', 3, 14000, 'Male');
-- Here we have not mentioned the 'emp_status', but bydefault it is added in column.
-- This is default constraint applied to the table and resp. column.                        
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

select * from employee;

update department set dept_id = 5 where dept_name = 'IT';
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column. 
-- To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
SET SQL_SAFE_UPDATES=0;
-- Normally set the safe update to 1, because It is MySQL's default setting
SET SQL_SAFE_UPDATES=1;

/* On update cascade: 
When the dept_id set to 5 in department tbl then, 
automatically employee tbl will be updated.
employees dept_id will change from 1 to 5 in employee tbl.
*/

-- ============================================================================================= --
							  -- ### -- CHECK CONSTRAINT -- ### --
-- ============================================================================================= --
use constraints_codestudio;
select * from employee;
desc employee;

# Add salary column to the employee table
Alter table employee add salary int check(salary between 5000 and 50000);

# add Mark's salary 10000 - Acceptable
# add John's salary 3000 - Not Acceptable

SET SQL_SAFE_UPDATES=0;
SET SQL_SAFE_UPDATES=1;

update employee set salary = 10000 where emp_name='Mark';
update employee set salary = 3000 where emp_name='John';
-- Error Code: 3819. Check constraint 'employee_chk_1' is violated.
-- Cannot update, check constraint is violated.

# Add gender column to the employee table and add check for the value of Male and Female only
alter table employee add gender varchar(10) check(gender in ('Male' , 'Female'));
update employee set gender = 'Male' where emp_name = 'Mark';
update employee set gender = 'Female' where emp_name = 'Mary';
update employee set gender = 'Mal' where emp_name = 'John';
-- Error Code: 3819. Check constraint 'employee_chk_2' is violated.
update employee set gender = 'Mle' where emp_name = 'Mike';
-- Error Code: 3819. Check constraint 'employee_chk_2' is violated.

-- ============================================================================================= --
							  -- ### -- DEFAULT CONSTRAINT -- ### --
-- ============================================================================================= --
## It sets the default value for the particular column, where we have not specified any value.

create table orders(
id int not null,
orderNumber int not null,
orderDate date default(current_date())
);

desc orders;
insert into orders (id, orderNumber, orderDate) values (1, 101, '2023-05-23');
insert into orders (id, orderNumber) values (1, 101);

/*
-- row repeated
delete from orders where orderDate='2023-12-30';
*/

insert into orders (id, orderNumber) values(2,201);
select * from orders;

-- ============================================================================================= --
							  -- ### -- AUTO INCREMENT CONSTRAINT -- ### --
-- ============================================================================================= --
create table books(
SrNo int primary key auto_increment,
Name varchar(25),
Author varchar(25)
);
desc books;
select * from books;
insert into books (Name, Author) values ('Rich Dad Poor Dad', 'Robert Kiosaki');
insert into books (Name, Author) values ('Secret', 'Rhonda Byrne');
-- Here 'SrNo' are auto-incrementing.
-- --------------------------------------------------------------------------------------------- -- 


#########################################################################################################################################
											##  Session-14 : Auto Increment, Limit Clause  ##
#########################################################################################################################################

/*
1) Auto increment is a function that operates on numeric data types only. 
   It automatically generates sequential numeric values every time that a record is inserted
   into a table for a field defined as auto increment.
2) The column for which we apply AUTO-INCREMENT, that column must have applied PRIMARY KEY
   If we do not mention PRIMARY KEY, then table will not create.
   Give Error Code: 1075 : Incorrect table definition; there can be only one auto column and it must be defined as key.
*/
use testdb_codestudio;

create table employee(
id int auto_increment primary key,
name varchar(50) not null,
email varchar(50) not null
);

select * from employee;

insert into employee (name, email) values('Paul Bettany','paul@gmail.com');
insert into employee (name, email) values('Chris Hemsworth','chris@rediffmail.com');
insert into employee (name, email) values('Mark Ruffalo','mark@hotmail.com');

delete from employee where id=2;
select * from employee;
-- --------------------------------------------------------------------
#### We can also set new auto-increment
alter table employee auto_increment = 100;
insert into employee (name, email) values('Steve Angello','steve@hotmail.com');
-- This will start the auto-increment feom 100.
-- --------------------------------------------------------------------
-- ============================================================================================= --
							  -- ### -- LIMIT CLAUSE -- ### --
/*
MySQL LIMIT query is used to restrict the no of rows returns from the result set, 
rather than fetching the whole set in the MySQL database.
*/                              
  use project_hr;
  select * from employees;
  select * from employees limit 5; -- Returns 1st 5 rows
  
  # To fetch 5 records from 3rd row
  select * from employees limit 2,5;
  
  
                              
################################################################################################
							##  Session-15 : Views, Index  ##
################################################################################################

						        -- ## -- VIEWS -- ## --
/* 
# View is a virtual table created by joining one or more tables.
  It is an exact mirror image of the original table in database.
# It's possible to use INSERT, UPDATE, DELETE on a VIEW. But these operations will change
  the underlying structure of a VIEW.
  Whatever the changes we do in VIEW, same changes will be happen in original table of VIEW.
*/

use project_hr;
select * from employees;
select employee_id, first_name, last_name, salary from employees;
create view emp_view1 as select employee_id, first_name, last_name, salary from employees;
select * from emp_view1;
-- --------------------------------------------------------------------------------------

								-- ## -- INDEX -- ## --
                                


################################################################################################
					##  Session-16 : Commit, Autocommit, Rollback  ##
################################################################################################
/*
1) Transaction Control Language (TCL) Commands:

a) Commit - Make changes permanent. 
   In MySQL, by default, the COMMIT statement executed automatically.
   It means, autocommit is ON or enabled. 
   If we don't want to commit changes automatically, we have to disable autocommit.
   
 b) Auto Commit
    # To disable autocommit
    SET autocommit = 0;
    OR 
    SET autocommit = OFF;
    
    # To enable autocommit
    SET autocommit = 1;
    OR 
    SET autocommit = ON;
    
c) Rollback - Cancel Changes.     
*/ 
use testdb_codestudio;
select * from employee;

# autocommit is ON by default.
SET autocommit = ON;
insert into employee(name, email) values('Robert Downey','robert@marvel.com');
select * from employee;

SET autocommit = OFF;
insert into employee(name, email) values('Chris Evans','evans@marvel.com');
/* 
- Changes will not be permanent in database.
- When we close the database & Workbench and relaunch Workbench, then changes will not be saved automatically.
- To save permanently, we've to commit the changes. Use 'commit' command after query.

- If autocommit is ON, changes will be permanent
  If autocommit is OFF, we need to use 'commit' command after every statement to make changes permanent.
  
*/
select * from employee;

delete from employee where id=102;

# To make changes permanently. We'll use 'commit' command.
insert into employee(name, email) values('Chris Evans','evans@marvel.com');
commit;
-- ============================================================================== -- 
                              -- ROLLBACK COMMAND --
select * from employee;
SET autocommit = OFF;
delete from employee where id = 104;
# changes will not be permanent. We can rollback those changes.
rollback;

SET autocommit = ON;



################################################################################################
			   ##  Session-17 : Java Database Connectivity (JDBC) with MySQL  ##
################################################################################################














