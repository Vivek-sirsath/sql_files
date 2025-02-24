create database sql_crack_it;
-- Instead of CREATE DATABASE we can use CREATE SCHEMA also.
-- Both commands will do the same work.
-- SCHEMA is the logical representation of database.
-- We can also use check before creating database, 
-- CREATE DATABASE IF NOT EXISTS databaseName


show databases;
use sql_crack_it;
show tables;

create table employee(
employee_id int,
name varchar(25),
salary int
);

select * from employee;

insert into employee(employee_id, name, salary) values(100, 'Jennifer', 4400);
insert into employee(employee_id, name, salary) values(100, 'Jennifer', 4400);
insert into employee(employee_id, name, salary) values(101, 'Michael', 13000);
insert into employee(employee_id, name, salary) values(101, 'Michael', 13000);
insert into employee(employee_id, name, salary) values(101, 'Michael', 13000);
insert into employee(employee_id, name, salary) values(102, 'Pat', 6000);
insert into employee(employee_id, name, salary) values(102, 'Pat', 6000);
insert into employee(employee_id, name, salary) values(103, 'Den', 11000);

-- Using GROUP BY function -- 
select employee_id, name, salary from employee group by employee_id;
select employee_id, name, salary from employee group by employee_id, name, salary;

-- distinct --
select distinct name from employee;
select distinct employee_id from employee;
select distinct * from employee;


-- max Salary --
select max(salary) from employee;
select name, max(salary) from employee;

-- 2nd max salary --
select max(salary) from employee where salary < (select max(salary) from employee);

-- 3rd highest salary --
select max(salary) from employee where salary < (select max(salary) from employee where salary < (select max(salary) from employee));

select * from employee;

select sum(salary) from employee;
select min(salary) from employee;
