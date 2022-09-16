create warehouse test_warehouse;

create database if not exists SQL_TASK ;
use SQL_TASK;

-- TASK1--

create table shopping_history(
   product varchar(100) not null,
   quantity integer not null,
   unit_price integer not null
);

insert into shopping_history values('milk',3,10),
('bread',7,3),
('chocolate',6,30),
('cookie',2,20),
('maggie',4,30),
('coffee',2,30),
('chocolate',6,30),
('bread',5,2),
('coffee',2,30),
('maggie',4,30);

select * from shopping_history;


select product,sum(quantity*unit_price) as total_price from shopping_history
group by product
order by product;



--------------------------------TASK 2----------------------------------

create table phones(
  name varchar(30) not null unique,
  phone_number integer not null unique
);

create table calls(
  id integer not null,
  caller integer not null,
  callee integer not null,
  duration integer not null,
  unique(id)
);


insert into phones values ( 'Jack',1234),
( 'Lena',3333),
( 'Mark',9999),
( 'Anna',7582),
( 'John',6356),
( 'Addison',4315),
( 'Kate',8003),
( 'Ginny',9831),
( 'Ike',9091),
( 'April',6501);

select * from phones;

insert into calls values ( 25,1234,7582,8),
( 7,9999,7582,1),
( 18,9999,3333,4),
( 2,7582,333,3),
( 3,3333,1234,1),
( 21,3333,1234,1),
( 65,8003,9831,7),
( 100,9831,8003,3),
( 145,4315,9831,18);

select * from calls;


select p.name as name from phones p
left join calls c
on p.phone_number=c.caller
or
p.phone_number = c.callee
group by name
having sum(duration)>=10
;



--------------------------------TASK 3----------------------------------

create table transactions(
  amount integer not null,
  tran_date date not null
);

insert into transactions values (1000,'2020-01-06'),
(-10,'2020-01-14'),
(-75,'2020-01-20'),
(-5,'2020-01-25'),
(-4,'2020-01-29'),
(2000,'2020-03-10'),
(-75,'2020-03-12'),
(-20,'2020-03-15'),
(40,'2020-03-15'),
(-50,'2020-03-17'),
(200,'2020-10-10'),
(-200,'2020-10-10');

select * from transactions;
