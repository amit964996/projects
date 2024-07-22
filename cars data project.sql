create database cars;

use cars;

create table car_data(
	`ID` DECIMAL(38, 0) NOT NULL, 
	`Brand` VARCHAR(13) NOT NULL, 
	`Model` VARCHAR(15) NOT NULL, 
	`Year` DECIMAL(38, 0) NOT NULL, 
	`Color` VARCHAR(6) NOT NULL, 
	`Mileage` DECIMAL(38, 0) NOT NULL, 
	`Price` DECIMAL(38, 0) NOT NULL, 
	`Condition` VARCHAR(4) NOT NULL
);

load data infile
'D:\car_data.csv'
into table car_data
fields terminated by ','
lines terminated by '\n'
ignore 1 rows;

select * from car_data;

select * from car_data where color = "white";

#Q.1--Count of Records by Brand

select brand, count(*) as total_count from car_data group by brand;

#Q.2--Average Price by Brand and Year

select brand, `year`, avg(price) as avg_price from car_data group by brand, `year`;

#Q.3--Most Common Color

select color, count(*) as colorcount from car_data group by color limit 1;

#Q.4--Total Mileage by Brand

select brand, sum(mileage) as total_mileage from car_data group by brand;

#Q.5--Average Price by Condition


select `condition`, avg(price) as avg_price from car_data group by `condition`;


#Q.6--Count of Records by Year and Color

select `year`, color, count(*) as total_count from car_data group by `year`, color;

#Q.7--Find the top 5 most expensive cars

select brand, model, `year`, color, mileage, price, `condition` from car_data
order by price desc limit 5;

#Q.8--Calculate the average mileage of cars by brand and condition

select brand, `condition`, avg(mileage) as avg_mileage from car_data group by brand, `condition`;

#Q.9--Identify the total number of cars per year and color

select `year`, color, count(*) as total_cars from car_data group by `year`, color;

#Q.10--Calculate the total price of all cars sold in each year

select `year`, sum(price) as total_price from car_data group by`year`;


#Q.11--Find the average price and mileage of cars for each year

select `year`, avg(price) as avg_price, avg(mileage) as avg_mileage from car_data group by `year`;


#Q.12--Calculate the average price  in different conditions

select `condition`, avg(price) as avg_price from car_data group by `condition`;


