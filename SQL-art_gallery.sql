show databases;
create database Art_Gallery;
use Art_Gallery;
show tables;
create table paintings
(
id int primary key,
name varchar(20),
artist_id int,
listed_price float
);
desc paintings;
select * from paintings;
insert into paintings value
(11,'Miracle',1,300.00),
(12,'Sunshine',1,700.00),
(13,'Pretty women',2,2800.00),
(14,'Handsome man',2,2300.000),
(15,'Barbie',3,250.00),
(16,'Cool painting',3,5000.00),
(17,'Black square #1000',3,50.00),
(18,'Mountains',4,1300.00);

create table sales
(
id int primary key,
Date date,
painting_id int,
artist_id int,
collector_id int,
sales_price float
);
desc sales;
select * from sales;
insert into sales value
(1001,'2021-11-01',13,2,104,2500.00),
(1002,'2021-11-10',14,2,102,2300.00),
(1003,'2021-11-10',11,1,102,300.00),
(1004,'2021-11-15',16,3,103,4000.00),
(1005,'2021-11-22',15,3,103,200.00),
(1006,'2021-11-22',17,3,103,50.00);

create table artists
(
id int,
first_name char(10),
last_name char(10)
);
desc artists;
select * from artists;
insert into artists value
(1,'Thomas','Black'),
(2,'Kate','Smith'),
(3,'Natali','Wein'),
(4,'Francesco','Benelli');

create table collectors
(
id int,
first_name char(10),
last_name char(10)
);
desc collectors;
select * from collectors;
insert into collectors value
(101,'Brandon','Cooper'),
(102,'Laura','Fisher'),
(103,'Christina','Buffet'),
(104,'Steve','Stevenson');

-- Display paintings that are priced higher than the average. 
select avg(listed_price)from paintings;
select * from paintings where listed_price>(select avg(listed_price)from paintings);

-- Display all collectors who purchased paintings from our gallery. 
select * from collectors where collectors_id exists(select distinct(collectors_id) from sales);
select id, first_name from collectors, sales where collectors.id=sales.collectors_id;

-- Display total amount of sales for each artist who has sold at least one painting in our gallery. 
select first_name, sum(sales_price) as 'Total amount of sales' from artists,sales where first_name in(select distinct first_name from artists)group by first_name;

-- Display total number of paintings purchased through our gallery. 
select count(painting_id)as 'Total no of paintings' from sales;

-- show the first names and the last names of the artists who had zero sales with our gallery.
select first_name,last_name from artists 
where artist_id 
NOT IN(select distinct(artist_id) from sales);
