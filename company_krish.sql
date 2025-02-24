create database company_krish;
use company_krish;

show tables;

# Create table Employee
create table employee(
empid int not null primary key auto_increment,
first_name varchar(25),
last_name varchar(25),
salary int,
joining_date datetime,
department_name varchar(25)
);

## Check the schema
desc employee;

insert into employee values
(0001,'Ganesh','Sonawane',50000,'14-12-11 09.00.00','Production'),
(0002,'Kiran','Chaudhari',60000,'14-12-11 09.00.00','Production'),
(0003,'Harshal','Mistari',70000,'15-12-12 09.00.00','HR'),
(0004,'Anil','Patil',70000,'15-12-13 09.00.00','HR'),
(0005,'Vivek','Shirsath',50000,'17-10-21 09.00.00','Quality'),
(0006,'Dipak','Sarode',40000,'17-10-15 09.00.00','Quality');

select * from employee;

-- To add another employee to the table --
insert into employee values (0007,'Pankaj','Chaudhari',52000,'17-02-12 09.00.00','Production');

-- To update the salary of an employee --
update employee set salary='80000' where empid='0005';


# Create Bonus Table
create table bonus(
emp_ref_id int,
bonus_amt int,
bonus_date datetime,
foreign key(emp_ref_id) references employee(empid)
on delete cascade
);

desc bonus;

insert into bonus values 
(0001,5000,'16-03-12'),
(0001,5000,'16-03-14'),
(0002,5000,'16-03-13'),
(0003,5000,'17-03-15'),
(0001,5000,'18-03-17'),
(0004,3500,'16-03-19'),
(0005,7000,'16-03-20'),
(0001,8000,'20-03-21');

insert into bonus values
(0002,8500,'20-03-21');


select * from bonus;

-- To rename/change the column name from emp_ref_id to empid --
alter table bonus change column emp_ref_id empid int;

## Create designation table
create table designation(
empid int,
designation varchar(25),
designation_date datetime,
foreign key(empid) references employee(empid)
on delete cascade
);

desc designation;

-- To rename/change the column name from emp_ref_id to empid --
alter table designation change column emp_ref_id empid int;

# Insert values into designation 
insert into designation values
(0001,'Senior Developer','2016-02-17 00.00.00'),
(0002,'Executive','2016-06-11 00.00.00'),
(0003,'Senior Developer','2016-06-11 00.00.00'),
(0004,'Junior Tester','2016-06-11 00.00.00'),
(0005,'Manager','2018-01-15 00.00.00'),
(0006,'Junior Tester','2018-01-25 00.00.00'),
(0007,'Junior Tester','2019-05-22 00.00.00');

-- Now To change/update the designation from Junior Tester to Junior Developer of id=0007  --
update designation set designation = 'Junior Developer' where empid='0007';

select * from designation;
select * from bonus;
select * from employee;

-- Droping table designation to modify employee's designations properly --
drop table designation;

-- Q. Write SQL query to retrieve all details of the employees from HR department
select * from employee where department_name = 'HR';

-- Q. Write an SQL query to retrieve all details where first name from employee table which starts with 'V'
select * from employee where first_name like 'V%';

-- Q. Write an SQL query to print all the details of the employees whose salary between 10000 to 35000
-- -- Also fetch the employee name --
select concat(first_name, '  ', last_name) as employee_name,salary
from employee where empid in 
(select empid from employee where salary between 40000 and 60000);

-- Q. SQL query to retrieve the details of employees who have joined on a date Dec 2014 --
select * from employee where year(joining_date)=2014 and month(joining_date)=12;

-- Q. SQL query to fetch number of employees in every department --
select count(*) from employee group by department_name;

-- Q. Retrieve the details of the employees who works in Quality and HR department --
select * from employee where department_name='Quality';

-- Q. Retrieve the details of the employees who works in Production department --
select * from employee where department_name='Production';

-- Q. List out the department name having at least 3 employees --
select department_name, count(*) from employee group by department_name having count(*)>=3;

-- Q. Display all the employee details who got the max salary --
select * from employee where salary = (select max(salary) from employee);

-- Q. Write an SQL query to find the position of the alphabet (‘h’) in the first_name column 'Harshal' from employee table.
select instr(first_name,binary'h') from employee where first_name='Harshal';

-- Q. Write an SQL query that fetches the unique values of DEPARTMENT from employee table and prints its length.
select distinct department_name, length(department_name) as numberOfCharacters from employee;

-- Q. Write an SQL query to print details of the employee whose FIRST_NAME contains ‘a’.
select * from employee where first_name like '%a%';

-- Q. Write an SQL query to print details of the employee whose FIRST_NAME ends with ‘l’.
select * from employee where first_name like '%l';

-- Q. Write an SQL query to print details of the employee whose LAST_NAME contains ‘t’ at 4th position.
select * from employee where last_name like '___t%';

-- Q. Write an SQL query to fetch the no. of employees for each department in the descending order.
select department_name, count(empid) as No_of_Employees from employee group by department_name order by No_of_Employees desc;


select * from employee;

desc employee;
desc bonus;

-- -------------------------Joins Not Workable, Try Later ---------------------------
alter table bonus
add foreign key(empid) references employee(empid);
-- -----------------------------------------------------------------------







