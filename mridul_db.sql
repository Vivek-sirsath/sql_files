use mridul_db;

create table orders(
o_id int,
orderprice int,
custName varchar(20)
);

desc orders;

select * from orders;

insert into orders(o_id,orderprice,custName) values (1,1200,"john");
insert into orders(o_id,orderprice,custName) values (2,1500,"brown");
insert into orders(o_id,orderprice,custName) values (3,300,"john");
insert into orders(o_id,orderprice,custName) values (4,200,"taylor");
insert into orders(o_id,orderprice,custName) values (5,1000,"john");
insert into orders(o_id,orderprice,custName) values (6,1200,"maria");
insert into orders(o_id,orderprice,custName) values (6,2000,"thomas");
insert into orders(o_id,orderprice,custName) values (8,4000,"abcdef");
insert into orders(o_id,orderprice,custName) values (9,5000,"kate");

select * from orders;

-- using group by -- find the sum of orders from each customer -- 
select custName,sum(orderprice) from orders group by custName;

-- find if any of the customer has total order more than 2000 --
select custName, sum(orderprice) from orders group by custName having sum(orderprice)>2000;
select custName, sum(orderprice) from orders group by custName having avg(orderprice)>=4000;
select custName, sum(orderprice) from orders group by custName having avg(orderprice)<=3000;

-- add column location to the orders table --
alter table orders add location varchar(25);

-- to delete the column from table --
alter table orders drop location;

-- to change the name of a column --
select custName as customer_name from orders;

 -- between operator --
 select * from orders where orderprice between 1000 and 1500;

-- in operator --
select custName, orderprice from orders where custName in('john','maria');
select custName, orderprice from orders where orderprice in(1200,5000);  -- john, maria, kate

-- if we wish to change the orderprice of taylor fromm 200 to 3500 -- 
SET SQL_SAFE_UPDATES=0;
update orders set orderprice = 3500 WHERE custName = 'taylor';

-- ==================================================================================== --
-- =================================  CONSTRAINTS  ==================================== --
-- ==================================================================================== --

create table persons(
id int not null unique,
personname varchar(25),
location varchar(25),
age int,
check (age>=18)
);

desc persons;

-- insert into persons(id,personname,location,age) values (1,'Vivek','Jamner',12);  -- Error Code: 3819. Check constraint 'persons_chk_1' is violated. Bcoz, 12 < 18
insert into persons(id,personname,location,age) values (1,'Vivek','Jamner',35);

select * from persons;

-- ================================================================================ --
-- Primary Key --
# A table can have only one primary key. (unique + not null)
# Primary Keys must contain UNIQUE values, and cannot contain null values
# Foreign Key - Is to make relationship between two or more than two tables
# one table contains primary key and other contains foreign key
# A common column in both the tables (common column should have same datype)
# Primary Key (parent table), Foreign Key (child table)

create table orders2(
order_id int primary key,
ordernumber int,
location varchar (25)
);

create table persons2(
order_id int,
personid int,
personname varchar(25),
foreign key(order_id) references orders2(order_id)
);

-- Insert values in orders2 table --

insert into orders2(order_id,ordernumber,location) values (10,123456,"pune");
insert into orders2(order_id,ordernumber,location) values (20,456789,"mumbai");
insert into orders2(order_id,ordernumber,location) values (30,789123,"jalgaon");

select * from orders2;

-- Insert values in persons2 table --

insert into persons2(order_id,personid,personname) values (10,111,"vivek");
insert into persons2(order_id,personid,personname) values (20,333,"deepika");
insert into persons2(order_id,personid,personname) values (30,999,"ishita");

select * from persons2;
-- =======================================================================================
-- to change column name in persons2 table--
alter table persons2 change column personname firstname varchar(25);

alter table persons2 add column lastname varchar(25);

update persons2 set lastname = "shirsath" where order_id = 10;
update persons2 set lastname = "shirsath" where order_id = 20;
update persons2 set lastname = "shirsath" where order_id = 30;
-- ========================================================================================
alter table orders2 add column address varchar(25);

update orders2 set address = 'shivaji nagar' where order_id = 10;
update orders2 set address = 'ayodhya nagar' where order_id = 20;
update orders2 set address = 'ring road' where order_id = 30;

select * from orders2;

desc orders2;

alter table orders2 add column mobile_number varchar(10);
alter table orders2 drop column mobile_number;

update orders2 set mobile_number = '9422233526' where order_id = 10;
update orders2 set mobile_number = '7020598214' where order_id = 20;
update orders2 set mobile_number = '9422233525' where order_id = 30;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --  INNER JOIN -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

select * from orders2;
select * from persons2;

select orders2.ordernumber, orders2.location,orders2.mobile_number,orders2.address,persons2.firstname,persons2.lastname,orders2.order_id
from orders2 inner join persons2
on orders2.order_id = persons2.order_id;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --  LEFT JOIN -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

select orders2.ordernumber, orders2.location,orders2.mobile_number,orders2.address,persons2.firstname,persons2.personid,orders2.order_id
from orders2 left join persons2
on orders2.order_id = persons2.order_id;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --  RIGHT JOIN -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

select orders2.ordernumber, orders2.location,orders2.mobile_number,orders2.address,persons2.firstname,persons2.personid,orders2.order_id
from orders2 right join persons2
on orders2.order_id = persons2.order_id;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --  FULL OUTER JOIN -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

select orders2.ordernumber, orders2.location,orders2.mobile_number,orders2.address,persons2.firstname,persons2.personid,orders2.order_id
from orders2 left join persons2
on orders2.order_id = persons2.order_id
union
select orders2.ordernumber, orders2.location,orders2.mobile_number,orders2.address,persons2.firstname,persons2.personid,orders2.order_id
from orders2 right join persons2
on orders2.order_id = persons2.order_id;

-- MridulDB added to github repository --
