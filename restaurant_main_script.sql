CREATE DATABASE restaurant_data_analysis;
USE restaurant_data_analysis;

CREATE TABLE restaurant_data (
    Date DATE,
    Order_ID VARCHAR(255),
    Item_Name VARCHAR(255),
    Category VARCHAR(255),
    Quantity INT NULL,
    Price DECIMAL(10,2),
    Total_Sales DECIMAL(10,2),
    Payment_Method VARCHAR(255),
    Customer_ID VARCHAR(255),
    Customer_Age INT NULL,
    Customer_Gender VARCHAR(255),
    Visit_Type VARCHAR(255),
    Order_Time TIME,
    Wait_Time_Mins INT NULL,
    Day_of_the_Week VARCHAR(255),
    Meal_Period VARCHAR(255),
    Day_Type VARCHAR(255)
);

-- Create a temporary table to store raw data
CREATE TABLE restaurant_data_temp (
    Date VARCHAR(255),
    Order_ID VARCHAR(255),
    Item_Name VARCHAR(255),
    Category VARCHAR(255),
    Quantity VARCHAR(255),
    Price DECIMAL(10,2),
    Total_Sales DECIMAL(10,2),
    Payment_Method VARCHAR(255),
    Customer_ID VARCHAR(255),
    Customer_Age VARCHAR(255),
    Customer_Gender VARCHAR(255),
    Visit_Type VARCHAR(255),
    Order_Time VARCHAR(255),
    Wait_Time_Mins VARCHAR(255),
    Day_of_the_Week VARCHAR(255),
    Meal_Period VARCHAR(255),
    Day_Type VARCHAR(255)
);

-- Transfer cleaned data from the temporary table to the main table
INSERT INTO restaurant_data (
	Date, Order_ID, Item_Name, Category, Quantity, Price, Total_Sales, Payment_Method,
    Customer_ID, Customer_Age, Customer_Gender, Visit_Type, Order_Time, Wait_Time_Mins,
    Day_of_the_Week, Meal_Period, Day_Type 
)
SELECT
	STR_TO_DATE(Date, '%Y-%m-%d'), -- Convert date strings to DATE format
    Order_ID,
    Item_Name,
    Category,
    CAST(Quantity AS SIGNED), -- Convert cleaned strings to INT 
    Price,
    Total_Sales,
    Payment_Method,
    Customer_ID,
    CAST(Customer_Age AS SIGNED), -- Convert cleaned strings to INT 
    Customer_Gender,
    Visit_Type,
    STR_TO_DATE(Order_Time, '%H:%i:%s'), -- Convert time strings to TIME format
    CAST(Wait_Time_Mins AS SIGNED), -- Convert cleaned strings to INT 
    Day_of_the_Week,
    Meal_Period,
    Day_Type
FROM restaurant_data_temp;
    




