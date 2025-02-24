-- create database --
-- Instead of CREATE DATABASE we can use CREATE SCHEMA also.
-- Both commands will do the same work.
-- SCHEMA is the logical representation of database.
-- We can also use check before creating database, 
-- CREATE DATABASE IF NOT EXISTS databaseName


create database Esapphire;
show databases;

-- to see current date and time
select now(),curdate(),curtime();

use esapphire;

CREATE TABLE Employee(
 ID INT,
 Name VARCHAR (200),
 Salary INT,
 Country VARCHAR (200)
 ); 
 
 select * from employee;
 
INSERT INTO Employee VALUES 
(1,'Adam',10000,'USA'),
(2,'James',10000,'Germany'),
(3,'John',20000,'India'),
(4,'Alexa',20000,'Austrilia'),
(5,'Nick',40000,'Singapore'),
(6,'Justin',70000,'Germany'),
(7,'Steve',60000,'Austrilia'),
(8,'Henry',80000,'India');

-- to add column to the existing table --
alter table employee add Designation varchar(40);

-- to drop the column from existinfg table --
alter table employee drop column Designation;

-- first set sql safe updates = 0 to enable update 
SET SQL_SAFE_UPDATES=0;
update employee set Designation = 'Jr. Tester' where id = 1;
update employee set Designation = 'Sr. Developer' where id = 2;
update employee set Designation = 'Jr. Tester' where id = 3;
update employee set Designation = 'Team Leader' where id = 4;
update employee set Designation = 'Jr. Tester' where id = 5;
update employee set Designation = 'Jr. Developer' where id = 6;
update employee set Designation = 'Sr. Tester' where id = 7;
update employee set Designation = 'Project Manager' where id = 8;


-- at runtime we can change the designation of any employee using id or name attribute --
update employee set Designation = 'Sr. Developer' where id = 5;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- to update the records in the row --

-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column 
-- To disable safe mode, toggle the option in Preferences -> SQL Queries and reconnect.   0.000 sec --
-- For this We need to write below command before performing update command --
SET SQL_SAFE_UPDATES=0;

update employee
set Salary=30000
where Name = 'John';


-- to delete the records from the table --
delete from employee where id=6;

 select * from employee;

-- to add the column DOJ (Date of Joining) --
alter table employee add DOJ date;

-- to update the employee DOJ --
update employee set DOJ = '2022-12-07'
where id =3;

desc employee;

-- to delete record from table --
delete from employee where id=8;

-- to drop (delete) the table --
drop table employee;

show tables;

-- to show the records --
select ID, Name, Salary from employee where id=4;
select ID, Name, Salary from employee where id=6;

select * from employee;

-- LOGICAL OPERATOR -- -- LOGICAL OPERATOR -- -- LOGICAL OPERATOR --
-- and --
select * from employee where ID=1 & Name='Adam';

-- NOT IN --
SELECT * FROM Employee WHERE Name Not IN ('John', 'Nick', 'Steve','Adam');

-- IN --
select * from employee where Name in ('James', 'Steve', 'Henry');
select * from employee where ID in (5,8);

-- OR -- 
select * from employee where ID=4 or Name='Justin' or Salary=40000; -- if any of the conditions are true 

-- between --
select * from employee where Salary between 20000 and 70000;

-- distinct --
select distinct country from employee;
select distinct salary from employee;

-- not equal to (<>) --
select * from employee where salary <> 20000;
select * from employee where salary <>10000;

-- AGGEGATE FUNCTION() -- -- AGGEGATE FUNCTION -- -- AGGEGATE FUNCTION -- -- AGGEGATE FUNCTION -- -- AGGEGATE FUNCTION -- -- AGGEGATE FUNCTION --

select * from employee;

-- min --
select min(Salary) from employee;
-- max --
select max(Salary) from employee;
-- max salary using limit keyword --
select salary from employee order by salary desc limit 1;
select salary from employee order by salary desc limit 3;
-- sum --
select sum(Salary) from employee;
-- avg --
select avg(salary) from employee;
-- count --
select count(salary) from employee;
select count(name) from employee;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- to get 10 % salary of each employee
-- Percentage Calculation : (figure*0.10) : [Its not the aggregate function]
select salary,(salary*0.10) as Ten_Percent_Of_Salary from employee;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- WILDCARDS --

select * from employee;

-- Like Operator (Used for Pattern Search in column) --
select * from employee where name like 'j%';
select  * from employee where name like 'a%';
select * from employee where name like 's%';
select * from employee where country like 'a%a';
select * from employee where name like '%n';
select * from employee where country like '%str%';
select * from employee where name like 'j%s';
select * from employee where name like 'a__%';

--- --- --- -- --- --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- ---
-- RDBMS Concepts --
--- --- --- -- --- --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- ---
select * from employee;

-- ORDER BY -- (Sort the data in ascending or descending order)

select * from employee order by salary ASC;
select * from employee order by salary desc;
select * from employee order by id asc;

-- GROUP BY -- 
-- (Whenever use GROUP BY statement we must have to use Aggragate Function (Count, Max, Min, Avg, Sum) in SELECT clause) --
-- (Whichever column have applied the GROUP BY clause that particular column must be the part of SELECT clause) --
select count(name), country from employee group by country;
select max(salary), country from employee group by country;


select * from employee;
-- * HAVING CLAUSE * --
-- (Without GROUP BY and AGGREGATE FUNCTION, we can not write HAVING Clause) --
-- (Always, HAVING CLAUSE should be followed by GROUP BY clause) --
select max(salary), country from employee group by country having max(salary) > 30000;
select max(salary), country from employee group by country having max(salary) > 60000;



