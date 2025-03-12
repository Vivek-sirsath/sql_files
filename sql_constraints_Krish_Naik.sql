create database sql_constraints_Krish_Naik;
use sql_constraints_Krish_Naik;

/*SQL Constraints:
SQL Constraints are used to specify any rules for the records in a table.
Constraints can be used to limit the type of data that can go into the table.
It ensures the accuracy and reliability of the records in the table, and 
If there any violation between the constraint and the record action,
the action is aborted. 
Constraints can be column level OR table level.
Column level constraints apply to a column, and table level constraints 
apply to the whole table.

1. Not Null
2. Unique
3. Primary Key
4. Foreign Key
5. check
6. default
7. Index
*/

-- -------------- Not Null Constraint --------------- --

create table student(
id int not null,
first_name varchar(25),
last_name varchar(25),
age int
);

desc student;

alter table student modify first_name varchar(25) not null;
alter table student modify last_name varchar(25) not null;
alter table student modify age int not null;

drop table student;

-- ----------------------------- Unique Constraint -------------------------------

create table person(
id int not null,
first_name varchar(25),
last_name varchar(25),
age int not null,
unique(id,first_name)
);

desc person;

--  insert values into person --

insert into person(id,first_name, last_name,age) values (1,'Vivek','Shirsath',35);
insert into person(id,first_name, last_name,age) values (2, 'Vivek', 'Patil', 31);

select * from person;

-- To add Unique key to table person ---
alter table person add unique(first_name);
#### This will prevent from repeating/adding same first_names

desc person;

-- To delete the unique constraint -- 
alter table person drop index first_name;

-- ------------------------------------------------------
drop table person;
-- -------------------------------------------------------

-- ----------------------------- Primary Key Constraint -------------------------------
alter table person drop index id;
-- To add Primary Key Constraint -- 
alter table person add primary key(id);
-- ----------------------------------------------------------------------------------------
drop table person; -- delete previously created person table
-- ==========================================================================================
-- ----------------------------- Check Constraint -------------------------------
create table person(
id int not null,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int,
salary int,
primary key(id),
check(salary<50000)
);

desc person;

insert into person values(1,'Vivek','Shirsath',35,40000);
select * from person;
insert into person values(2,'Ishita','Shirsath',6,55000);
-- Error Code: 3819. Check constraint 'person_chk_1' is violated.
-- ==========================================================================================

-- ---------------------------------Default Constraint -------------------------------------
-- By using Default constraint we can set default values in the table
use sql_constraints_Krish_Naik;
drop table person;

create table person(
id int not null,
first_name varchar(25) not null,
last_name varchar(25) not null,
city_name varchar(25) not null default('Pune')
);

desc person;

 insert into person(id, first_name,last_name,city_name) values (1, 'Ishita', 'Shirsath', 'Jamner');
 insert into person(id, first_name,last_name) values (2, 'Vivek', 'Shirsath'); -- This way works

-- ----------------------------------------------------------------------------------------
# Below queries will not work for default constraint
insert into person values (1, 'Ishita', 'Shirsath', 'Jamner');
insert into person values (2, 'Vivek', 'Shirsath'); -- This way Doesn't work
-- 19:19:19	insert into person values (2, 'Vivek', 'Shirsath')	Error Code: 1136. Column count doesn't match value count at row 1
-- ----------------------------------------------------------------------------------------

select * from person;

SET SQL_SAFE_UPDATES=0;
set sql_safe_updates=1;

delete from  person where id=2;

-- To delete default constraint -- 
alter table person alter city_name drop default;
-- To add the default constraint --
alter table person alter city_name set DEFAULT 'Pune';

drop table person;