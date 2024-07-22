create database diwali;

use diwali;

create table diwali_shopping(
	`User_ID` DECIMAL(38, 0) NOT NULL, 
	`Cust_name` VARCHAR(13) NOT NULL, 
	`Product_ID` VARCHAR(9) NOT NULL, 
	`Gender` VARCHAR(1) NOT NULL, 
	`Age Group` VARCHAR(5) NOT NULL, 
	`Age` DECIMAL(38, 0) NOT NULL, 
	`Marital_Status` BOOL NOT NULL, 
	`State` VARCHAR(16) NOT NULL, 
	`Zone` VARCHAR(8) NOT NULL, 
	`Occupation` VARCHAR(15) NOT NULL, 
	`Product_Category` VARCHAR(21) NOT NULL, 
	`Orders` DECIMAL(38, 0) NOT NULL, 
	`Amount` DECIMAL(38, 0) NOT NULL
);

load data infile
'D:/diwali.csv'
into table diwali_shopping
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from diwali_shopping;

#--1.Count the number of orders per customer

select cust_name, count(orders) as total_orders from diwali_shopping group by cust_name;

#--2.Calculate the total amount spent by each customer

select cust_name, sum(amount) as total_amount from diwali_shopping group by cust_name;

#--3.Select customers with age greater than 30

select cust_name, age from diwali_shopping where age >30;

#--4.Select distinct product categories

select distinct Product_Category from diwali_shopping;

#--5.Select customers from a specific state

select cust_name, state from diwali_shopping where state = "delhi";

select cust_name, state from diwali_shopping where state = "rajasthan";

#--6.Find the maximum amount spent on a single order

select max(amount) as max_amount from diwali_shopping;

#--7.Find the total amount spent by each customer in each product category

select cust_name, Product_Category, sum(amount) as total_amount from diwali_shopping 
group by cust_name, Product_Category;

#--8.Find the average amount spent per order in each age group

select `Age Group`, avg(amount) as avg_amount from diwali_shopping 
group by `age group`;

#--9.Identify the top 5 customers who spent the most overall

select cust_name, sum(amount) as total_amount from diwali_shopping
group by cust_name
order by total_amount desc
limit 5;

#--10.Calculate the total amount spent by customers in each state and sort them in descending order

select state, sum(amount) as total_amount from diwali_shopping
group by state
order by total_amount desc;

#--11.Find the number of orders made by customers in each occupation within each age group

select `age group`, occupation, count(orders) as total_orders from diwali_shopping
group by `age group`, occupation;

#--12.Calculate the average amount spent per order for married vs. unmarried customers

select Marital_Status, avg(amount) as `amount spent per order` from diwali_shopping
group by Marital_Status;

#--13.Identify the top 3 product categories with the highest total sales

select Product_Category, sum(amount) as total_sales from diwali_shopping
group by Product_Category
order by total_sales desc
limit 3;

#--14.Find the total number of orders and the average amount per order for each zone

select zone, count(orders) as total_orders, avg(amount) as `average amount per order`
from diwali_shopping
group by zone;

#--15.Calculate the total amount spent by each gender in each age group

select gender, `age group`, sum(amount) as total_amount from diwali_shopping
group by gender, `age group`;

#--16.Identify customers who have made orders in all available product categories

SELECT Cust_name 
FROM diwali_shopping
GROUP BY Cust_name 
HAVING COUNT(DISTINCT Product_Category) = (SELECT COUNT(DISTINCT Product_Category) FROM diwali_shopping);


#--17.Identify the most common occupation among customers

select occupation, count(*) as most_common_occupation from diwali_shopping
group by occupation
order by most_common_occupation desc
limit 1;

