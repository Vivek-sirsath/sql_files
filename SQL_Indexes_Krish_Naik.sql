-- MY SQL INDEXES --
/*
CREATE INDEX statement in SQL is used to create indexes in tables.
The indexes are used to retrieve data from the database more quickly than others.
The usercan not see the indexes, and they are just used to speed up queries/ searches.

NOTE: Updating a table with the indexes takes lot of time than updating a table without indexes.
It is because indexes also need an update.
So, only create indexes on those columns that will be frequently searched against.

# For Querying it is faster
# For INSERT, UPDATE and ALTER , this process will become very slower.
*/
create database SQL_Indexes_Krish_Naik;
use SQL_Indexes_Krish_Naik;

create table student(
id int not null,
first_name varchar(25),
last_name varchar(25),
age int
);

desc student;
-- To create the index --
create index index_age on student(age);
desc student;
-- To drop the index --
alter table student drop index index_age;
desc student;
