create database sql_constraints_Krish_Naik;
use sql_constraints_Krish_Naik;

/*SQL Constraints:
SQL Constraints are used to specify any rules for the records in a table.
Constraints can be used to limit the type of data that can go into the table.
It ensures the accuracy and reliability of the records in the table, and 
If there any violation between the constraint andthe record action,
the action is aborted. 
Constraints can be column level OR table level.
Column level constraints apply to a column, and table level constraints 
apply to thr whole table.

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

-- -------------- Unique Constraint --------------- --

create table person(
id int not null,
first_name varchar(25),
last_name varchar(25),
age int not null,
unique(id)
);

desc person;

--  insert values into person --

insert into person values (1,'Vivek','Shirsath',35);
select * from person;

-- To add Unique key to table person ---
alter table person add unique(first_name);
#### This will prevent from repeating/adding same first_names

-- To delete the added unique constraint -- 
alter table person drop index first_name;

-- ------------------------------------------------------
drop table person;
-- -------------------------------------------------------

-- -------------- Primary Key Constraint --------------- --
alter table person drop index id;
-- To add Primary Key Constraint -- 
alter table person add primary key(id);
-- ----------------------------------------------------------------------------------------
drop table person; -- delete previously created person table


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

-- ====================================================================================

-- ------- Default Constraint -------------------------------
-- By using Default constraint we can set default values in the table

drop table person;

create table person(
id int not null,
first_name varchar(25) not null,
last_name varchar(25) not null,
city_name varchar(25) not null default 'Pune'
);

desc person;

-- To delete default constraint -- 
alter table person alter city_name drop default;
-- To add the default constraint --
alter table person alter city_name set DEFAULT 'Pune';