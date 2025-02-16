-- Replace empty strings in the Quantity column with NULL
UPDATE restaurant_data_temp
SET Quantity = NULL
WHERE Quantity = '' OR Quantity IS NULL;

-- Replace invalid or empty strings in the Customer_Age column with NULL
UPDATE restaurant_data_temp
SET Customer_Age = NULL 
WHERE Customer_Age = '' OR Customer_Age IS NULL; 

-- Replace empty strings in Wait_Time_Mins column with NULL
UPDATE restaurant_data_temp
SET Wait_Time_Mins = NULL 
WHERE Wait_Time_Mins = '' OR Wait_Time_Mins IS NULL;

-- Get an overview of the NULLS
SELECT * 
FROM restaurant_data
WHERE Quantity IS NULL
	OR Customer_Age IS NULL
    OR Wait_Time_Mins IS NULL
    OR Date IS NULL
    OR Item_Name IS NULL;

SELECT 
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS Null_Quantity,
    SUM(CASE WHEN Customer_Age IS NULL THEN 1 ELSE 0 END) AS Null_Customer_Age,
    SUM(CASE WHEN Wait_Time_Mins IS NULL THEN 1 ELSE 0 END) AS Null_Wait_Time,
    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Null_Payment_Method,
    SUM(CASE WHEN Customer_Gender IS NULL THEN 1 ELSE 0 END) AS Null_Customer_Gender
FROM restaurant_data;

-- Count how many NULLS in Quantity column
SELECT COUNT(*) AS Missing_Quantities
FROM restaurant_data
WHERE Quantity IS NULL;

-- Calculate the Median Quantity to replace NULLS
SELECT COUNT(*) AS Total_Rows 
FROM restaurant_data
WHERE Quantity IS NOT NULL;

SELECT Quantity
FROM restaurant_data
WHERE Quantity IS NOT NULL
ORDER BY Quantity
LIMIT 1 OFFSET 3912; 

-- Replace NULLS in Quantity with Median Quantity (3)
UPDATE restaurant_data
SET Quantity = 3
WHERE Quantity IS NULL;

-- Replace NULLS in Customer_Age with median age
WITH AgeOrdered AS (
    SELECT Customer_Age, 
           ROW_NUMBER() OVER (ORDER BY Customer_Age) AS row_num,
           COUNT(*) OVER () AS total_rows
    FROM restaurant_data
    WHERE Customer_Age IS NOT NULL
)
SELECT Customer_Age 
FROM AgeOrdered
WHERE row_num = FLOOR((total_rows - 1) / 2) + 1;

UPDATE restaurant_data
SET Customer_Age = 41
WHERE Customer_Age IS NULL;

-- Replace NULL values in Wait_Time_Mins with average wait time
SELECT ROUND(AVG(Wait_Time_Mins), 0) AS Avg_Wait_Time
FROM restaurant_data
WHERE Wait_Time_Mins IS NOT NULL;

UPDATE restaurant_data
SET Wait_Time_Mins = 16
WHERE Wait_Time_Mins IS NULL;

-- Replace missing values in Item_Name with "Unknown Item"
UPDATE restaurant_data
SET Item_Name = "Unknown Item"
WHERE Item_Name = '' OR Item_Name IS NULL;

-- Standardize Categorical Data
UPDATE restaurant_data
SET Customer_Gender = 'Prefer not to answer'
WHERE Customer_Gender = 'unknown';

-- Fix Incorrect Total_Sales values
UPDATE restaurant_data
SET Total_Sales = Quantity * Price
WHERE Total_Sales <> (Quantity * Price);

-- Detect Duplicates in Order_ID
SELECT Order_ID, COUNT(*) AS Duplicate_Count
FROM restaurant_data
GROUP BY Order_ID
HAVING COUNT(*) > 1;

-- Add a Unique row_id Column
ALTER TABLE restaurant_data
ADD COLUMN row_id INT 
AUTO_INCREMENT 
PRIMARY KEY; 

-- Delete Duplicate Order_IDs Keeping 1 Copy
DELETE t1
FROM restaurant_data t1
JOIN restaurant_data t2
ON t1.Order_ID = t2.Order_ID
AND t1.row_id > t2.row_id;

-- Data Quality Checks: Check for NULLs
SELECT 
    SUM(CASE WHEN Item_Name = '' OR Item_Name IS NULL THEN 1 ELSE 0 END) AS Null_Item_Name,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS Null_Quantity,
    SUM(CASE WHEN Price IS NULL THEN 1 ELSE 0 END) AS Null_Price,
    SUM(CASE WHEN Customer_Age IS NULL THEN 1 ELSE 0 END) AS Null_Customer_Age,
    SUM(CASE WHEN Wait_Time_Mins IS NULL THEN 1 ELSE 0 END) AS Null_Wait_Time
FROM restaurant_data;

-- Check for Duplicates
SELECT Order_ID, COUNT(*) 
FROM restaurant_data
GROUP BY Order_ID
HAVING COUNT(*) > 1;

-- Check for Negative or 0 Prices
SELECT * FROM restaurant_data WHERE Price <= 0;













