# - (Hash Tag) for single line comment
/*
Multi line comments
*/
--  For execution use Cntrl+Shift+Enter -- OR -- Cntrl+Enter --

show databases;

use employees;

-- to see current date and time
select now(),curdate(),curtime();

SELECT * FROM employees;
select * from employees where year(hire_date)="1986";
select * from employees where year(birth_date)="1965";
select upper(first_name) from employees;

use world;
show tables;
select * from city;
select  * from country;
select * from countrylanguage;

-- create database -- 
create database SQL_KrishNaik;
show databases;

use SQL_KrishNaik;
show tables;

# Create customer_info table
create table customer_info(
id int auto_increment, -- ---------- auto_increment will automatically assign/update ids to rows/records
first_name varchar(25),
last_name varchar(25),
salary int,
primary key(id)
);

select * from customer_info;

## insert records in the table
insert into customer_info(first_name, last_name, salary)     -- no need to specify id bcoz auto_incremented
values
('John','Daniel',50000),
('Krish','Naik',60000),
('Darius','Bengali',70000),
('Chandan','Kumar',40000),
('Ankit','Sharma',null);

show tables;      -- this will show tables present in the database

-- drop table customer_info;  -- -------- This will delete table structure + data

insert into customer_info(id,first_name,last_name,salary,email) values (5,'Ankit','Sharma',55000,null);

-- To fetch the records of null --
select * from customer_info where email is null;


-- ----------- To add the dob column to customer_info table -- --------------
alter table customer_info add dob date; -- -->> date is a data type 
-- ------------ To rename or modify or change the column_name dob to year -- ----------
alter table customer_info modify dob year;

-- ------------ To delete the column dob -- --------------------------
alter table customer_info drop column dob;


### sql update statement use to update the null values in the table
update customer_info
set salary=50000
where id=5;

select * from customer_info;

-- To delete the records from the table --
delete from customer_info where id=5;

-- To add the email column to the existing table --
alter table customer_info add email varchar(50);

-- drop column email --
alter table customer_info drop column email;

-- to update emails in the table --
update customer_info set email='John.Daniel05@gmail.com' where id=(1);
update customer_info set email='Krish_Naik@rediffmail.com' where id=(2);
update customer_info set email='darius.Bengali1985@hotmail.com' where id=(3);
update customer_info set email='Chandan_Kumar20@gmail.com' where id=(4);

-- Update the salary of customer --
update customer_info set salary=(90000) where id=(3);

-- =========================================================================== --
-- Use of Functions
select last_name, substr(first_name,1,2) from customer_info;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- -- JOINS -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

create table student(
studentid int auto_increment,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int,
primary key(studentid)
);


desc student;
select* from student;

select distinct last_name from student;

insert into student values(1,'Krish','Naik',31),
(2,'Ram','Sharma',31),
(3,'Sam','Joe',31);

insert into student values(4,'Vicky','Shirsath',35),
(5,'Ishita','Shirsath',16);

update student
set first_name='Vivek'
where studentid=4;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

create table department(
studentid int auto_increment,
department_name varchar(25) not null,
foreign key(studentid) references student(studentid)
);

desc department;

insert into department values(1,'Computer Science'),
(2,'Electronics'),
(3,'Mechanical');


select* from student;
select * from department;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  
-- -- -- -- -- -- -- -- -- -- -- -- -- -- JOINS -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- -- -- -- -- INNER JOIN -- -- -- -- -- 

select student.first_name,student.last_name,student.age,department.department_name
from student inner join department
on student.studentid=department.studentid;

-- -- -- -- -- LEFT JOIN -- -- -- -- -- 
select student.first_name,student.last_name,student.age,department.department_name
from student left join department
on student.studentid=department.studentid;

-- -- -- -- -- RIGHT Join -- -- -- -- --
select student.first_name,student.last_name,student.age,department.department_name
from student right join department
on student.studentid=department.studentid;

-- -- -- -- -- FULL Join -- -- -- -- --

-- for FULL OUTER JOIN we need to choose both LEFT JOIN syntax & RIGHT JOIN syntax
-- then we need to combine them using UNION keyword

select student.studentid,student.first_name,student.last_name,student.age,department.department_name
from student left join department
on student.studentid=department.studentid
union
select student.studentid,student.first_name,student.last_name,student.age,department.department_name
from student right join department
on student.studentid=department.studentid;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  
-- -- -- -- -- -- -- -- -- -- -- -- -- -- VIEWS -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Views is a virtual table based on the result set of an SQL query.
-- We can not see that virtual table.
-- If we wish to share a query with someone else & he wants to execute the query
-- What will not work in views?
-- Updatable statements, aggregate fuctions, group by, having, union, left outer join,
-- right outer join, sub-queries. This will not work in Views.
-- Inner join will work in Views

create view student_info as
select first_name,last_name,age from student inner join department
using (studentid);

select * from student_info;

-- To drop view -- 
drop view student_info;

-- ================================================ --
-- =================== QUESTIONS ================== --

-- Q. Write SQL query to print all the details of employees
-- whose salary between 40000 to 70000
-- Also fetch employee name

select * from customer_info;
select * from customer_info where salary between 40000 and 70000;

-- To fetch the name also (Sub Query)--
select concat(first_name,'  ', last_name) as Employee_Name,Salary 
from customer_info where id in
(select id from customer_info where salary between 40000 and 70000);

-- Q. SQL query to show top n salary of employee
select * from customer_info order by salary desc limit 4;

-- Q. SQL query to determine 3rd highest salary
select salary from customer_info order by salary desc limit 2,1;    -- (n-1,1)
