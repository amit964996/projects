# Creating the Database
Create database BizLive_Project;

use BizLive_Project;


# Creating the Business_information table
CREATE TABLE `Business_info` (
	`Business_id` VARCHAR(13) NOT NULL, 
	`Business_Name` VARCHAR(121) NOT NULL, 
	`Contact_person` VARCHAR(106), 
	`Local_Address` VARCHAR(90), 
	`City` VARCHAR(13) NOT NULL, 
	`Pincode` VARCHAR(30) NOT NULL, 
	`State` VARCHAR(50) NOT NULL, 
	`GST_Number` VARCHAR(16) NOT NULL,
    primary key (Business_id)
);

# Loading the file
load data infile
"D:\Business_info.csv"
into table Business_info
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;


# Checking for the data 
select * from Business_info;

Select City,State,count(*) as num
from Business_info
Group by City,State;

# Checking and correcting the city and state values 
# Updating the Business_info Table City column with proper State name
update Business_info
SET State =
 CASE 
    WHEN City IN ('Akola', 'Amravati', 'Aurangabad', 'Bhandara', 'Chandrapur','Gadchiroli', 'Gondia', 'Nagpur', 'Wardha', 'Yavatmal') THEN 'Maharashtra'
    WHEN City IN ('Bhopal', 'Indore', 'Ujjain',"Chindwada",'Chhindwara','Betul') THEN 'Madhya Pradesh'
    WHEN City IN ('Bilaspur', 'Raipur', 'Korba') THEN 'Chhattisgarh' -- Add entries for other states if applicable
    WHEN City IN ('Nanded', 'Nashik', 'Pune', 'Solapur', 'Kolhapur', 'Sangli', 'Satara') THEN 'Maharashtra'  -- Add Nashik and Solapur
    WHEN City = 'Kochi' THEN 'Kerala'
    WHEN City IN ('Visakhapatnam', 'Vizianagaram') THEN 'Andhra Pradesh'
    WHEN City = 'Shegaon' THEN 'Maharashtra'
    WHEN City = 'Murtizapur' THEN 'Maharashtra'
    WHEN City = 'Sagar' THEN 'Madhya Pradesh'
    WHEN City = 'Butibori' THEN 'Maharashtra'
    WHEN City IN ('Mumbai', 'Navi Mumbai', 'Thane') THEN 'Maharashtra'
    WHEN City = 'Basti' THEN 'Uttar Pradesh'
    WHEN City = 'Nagthana' THEN 'Maharashtra'
    WHEN City = 'Khamgaon' THEN 'Maharashtra'
    WHEN City IN ('Delhi', 'Panipat') THEN 'Delhi'  -- Assuming these belong to Delhi NCR
    WHEN City = 'Ramtek' THEN 'Maharashtra'
    WHEN City = 'Hoshangabad' THEN 'Madhya Pradesh'
    WHEN City = 'Kanhan' THEN 'Maharashtra'
    WHEN City = 'Warthi' THEN 'Maharashtra'
    WHEN City = 'Kalmeshwar' THEN 'Maharashtra'
    WHEN City = 'Jodhpur' THEN 'Rajasthan'
    WHEN City = 'Kamptee' THEN 'Maharashtra'
    WHEN City = 'Saoner' THEN 'Maharashtra'
    WHEN City = 'Badnera' THEN 'Maharashtra'
    WHEN City = 'Samudrapur' THEN 'Maharashtra'
    WHEN City = 'Umrer' THEN 'Maharashtra'
    WHEN City IN ('Ichalkaranji', 'Satara') THEN 'Maharashtra'  -- Assuming Ichalkaranji belongs to Satara district
    When City in ('Ahmednagar','Beed','Pandurana','Chikhaldara','Paratwada','Sangamner','Ganeshpur','Katol','Karanja','Old Jalna')Then 'Maharashtra'
	When City = "Chattisgarh" Then 'Chattisgarh'
	When City = "Surat" Then "Gujrat"
	When City in ('Gwalior') Then "Madhya Pradesh"
	When City = "Jammu" Then "Jammu and Kashmir"
	When City = "Khokurala" Then "Rajasthan"
    When City = "Bela" Then "Maharashtra"
    ELSE 'No Data'
    End;
    
    
    # Creating the second table Meeting_Data
    
    CREATE TABLE `Meeting_Data` (
	`Business_id` VARCHAR(13) NOT NULL, 
	`Telecaller_name` VARCHAR(16) NOT NULL, 
	`BDM_name` VARCHAR(21) NOT NULL, 
	`Calling_Date` VARCHAR(20) NOT NULL, 
	`Meeting_Date` VARCHAR(20) NOT NULL, 
	`Meeting_Time` VARCHAR(15) NOT NULL, 
	`Meeting_Status` VARCHAR(12) NOT NULL,
    foreign key(Business_id) references Business_info(Business_id)
);

# Turning off the foreign key

Set foreign_key_Checks=0;

# Loading the file
load data infile
"D:\Meeting_Data1.1.csv"
into table Meeting_Data
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

# Turning on the foreign key

Set foreign_key_Checks=1;

select * from Meeting_Data;

# Converting the  Calling_date, Meeting_date and Meeting_time column to their respective formate


# (1) For Calling_Date column 

 UPDATE `Meeting_Data`
SET `Calling_Date` = STR_TO_DATE(`Calling_Date`, '%d-%m-%Y');

# (2) For Meeting_Date column

UPDATE `Meeting_Data`
SET `Meeting_Date` = STR_TO_DATE(`Meeting_Date`, '%d-%m-%Y');

# (3) For Meeting_Time column

ALTER TABLE `Meeting_Data`
MODIFY COLUMN `Meeting_Time` TIME NOT NULL;


# (4) Converting the Calling_Date into date data type

ALTER TABLE `Meeting_Data`
modify column `Calling_Date` Date not null;

# (5) Converting the Meeting_Date into date data type

ALTER TABLE `Meeting_Data`
modify column `Meeting_Date` Date not null;

 
select Meeting_Status,count(*) as c
from Meeting_Data
group by Meeting_Status
order by c desc;

update Meeting_Data
set Meeting_Status =
CASE
	When Meeting_Status in ("Confirm"," Confirm") Then "Confirm"
    When Meeting_Status in ("Call And Go","Call and Go") Then "Call And Go"
    else "No Data"
    end;


# Creating the Business_Category Table

CREATE TABLE `Business_Category_Table` (
	`Business_id` VARCHAR(13) NOT NULL, 
	`Business_Category` VARCHAR(115) NOT NULL, 
	`Category_type` VARCHAR(55) NOT NULL, 
	`Map` VARCHAR(11) NOT NULL, 
	`Product_proposal` VARCHAR(42) NOT NULL, 
	`New_Product` VARCHAR(43) NOT NULL,
    foreign key(Business_id) references Business_info(Business_id)
);

# Turning off the foreign key

Set foreign_key_Checks=0;

# Loading the file

load data infile
"D:\Business_Category_Table11.csv"
into table Business_Category_Table
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from business_category_table;

# Turning on the foreign key

Set foreign_key_Checks=1;

# Creating the Business_Sales Table
CREATE TABLE `Business_Sales` (
	`Business_id` VARCHAR(13) NOT NULL, 
	`Login_Date` VARCHAR(10) NOT NULL, 
	`Sales_Amount` DECIMAL(38, 0) NOT NULL, 
	`Advanced_Amount` DECIMAL(38, 0) NOT NULL, 
	`GST_Amount` DECIMAL(38, 2) NOT NULL, 
	`Payment_mode` VARCHAR(12) NOT NULL,
    foreign key(business_id) references Business_info(Business_id)
);

# Turning off the foreign key
Set foreign_key_Checks=0;

load data infile
"D:\Business_Sales1.1.csv"
into table Business_Sales
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select *from business_sales;

# Turning on the foreign key
Set FOREIGN_KEY_CHECKS = 1;

# Converting the Login_date column in proper date format

UPDATE `Business_Sales`
SET `Login_Date` = STR_TO_DATE(`Login_Date`, '%d-%m-%Y');

# converting the data type into date format

alter table `Business_Sales`
modify column `Login_Date` Date not null;



# Adding Expense Column in Business_Sales table

Alter table Business_Sales
Add column Expense DECIMAL(38,2);

# After Creating the Expense Column Storing the value in it which is 70% of Sales_Amount

update Business_Sales
Set Expense = 0.7*Sales_Amount;

# Creating the profit column in Business_Sales table

Alter Table Business_Sales
Add column Profit Decimal(38,2); 

# After Creating the Profit column storing the value in it which is 30% of Sales_Amount

update Business_Sales
Set Profit = 0.3*Sales_Amount;


# Retreiving the Business_Sales Data

select * from Business_Sales;


