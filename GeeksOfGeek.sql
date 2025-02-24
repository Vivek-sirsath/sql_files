create database geeksofgeek;
-- Instead of CREATE DATABASE we can use CREATE SCHEMA also.
-- Both commands will do the same work.
-- SCHEMA is the logical representation of database.
-- We can also use check before creating database, 
-- CREATE DATABASE IF NOT EXISTS databaseName


use geeksofgeek;
show tables;

create table Student(
roll_no int not null,
name varchar(20),
address varchar(20),
phone varchar(10),
age int
);
select * from student;

desc student;

insert into Student(roll_no, name , address, phone, age) values(1, 'Ishita', 'Jalgaon', '9422233526', 16);
insert into Student(roll_no, name , address, phone, age) values(2, 'Deepika', 'Erandol', '7020598214', 18);
insert into Student(roll_no, name , address, phone, age) values(3, 'Vivek', 'Kalyan', '9420236526', 17);
insert into Student(roll_no, name , address, phone, age) values(4, 'Mayur', 'Hyderabad', '9028719513', 20);
insert into Student(roll_no, name , address, phone, age) values(5, 'Vandana', 'Amalner', '8830361592', 18);
insert into Student(roll_no, name , address, phone, age) values(6, 'Rajendra', 'Dharangaon', '8080932162', 20);
insert into Student(roll_no, name , address, phone, age) values(7, 'Vihaan', 'Kharghar', '9930454518', 17);
insert into Student(roll_no, name , address, phone, age) values(8, 'Yosha', 'Vikhroli', '9970208506', 16);

# To turn the safe update mode off 
SET SQL_SAFE_UPDATES=0;

# To turn the safe update mode on
SET SQL_SAFE_UPDATES=1;

delete from student where roll_no='1';
truncate table student;

-- If we forget to assign primary key to the column
alter table student
add primary key(roll_no);

desc student;
-- drop table student;

create table StudentCourse(
course_id int,
roll_no int not null,
foreign key(roll_no) references student(roll_no)
);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`geeksofgeek`.`studentcourse`, CONSTRAINT `studentcourse_ibfk_1` FOREIGN KEY (`roll_no`) REFERENCES `student` (`roll_no`))
-- Such error comes when we're trying to put values into the child table that are not available in the referencing (parent) table
-- Temporarily disable referential constraints (set FOREIGN_KEY_CHECKS to 0) is useful when you need to re-create the tables and load data in any parent-child order.
set foreign_key_checks=0;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
set foreign_key_checks=1;

Insert into StudentCourse(course_id, roll_no) values(1,1);
Insert into StudentCourse(course_id, roll_no) values(2,2);
Insert into StudentCourse(course_id, roll_no) values(2,3);
Insert into StudentCourse(course_id, roll_no) values(3,4);
Insert into StudentCourse(course_id, roll_no) values(1,5);
Insert into StudentCourse(course_id, roll_no) values(4,9);
Insert into StudentCourse(course_id, roll_no) values(5,10);
Insert into StudentCourse(course_id, roll_no) values(4,11);

select * from StudentCourse;

desc StudentCourse;

select distinct course_id from StudentCourse;

desc studentcourse;

alter table studentcourse
add foreign key(roll_no) references student(roll_no);

-- drop table studentcourse;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --  INNER JOIN -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
select student.name,student.address,student.age,student.roll_no,studentcourse.course_id
from student inner join studentcourse
on student.roll_no=studentcourse.roll_no;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --  LEFT JOIN -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
select student.roll_no,student.name,student.address,studentcourse.course_id
from student left join studentcourse
on student.roll_no=studentcourse.roll_no;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --  RIGHT JOIN -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
select student.name,student.roll_no,student.address,studentcourse.course_id
from student right join studentcourse
on student.roll_no=studentcourse.roll_no;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --  Full outer JOIN -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
