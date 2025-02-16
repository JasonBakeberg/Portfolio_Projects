SELECT 
	COUNT(*) AS Total_Orders,
	COUNT(DISTINCT Order_ID) AS Unique_Orders,
	COUNT(DISTINCT Customer_ID) AS Unique_Customers,
	SUM(Total_Sales) AS Total_Revenue,
	AVG(Total_Sales) AS Avg_Order_Value
FROM restaurant_data;

-- Top 10 Best Selling Items
SELECT 
	Item_Name,
    SUM(Quantity) AS Total_Quantity_Sold,
    SUM(Total_Sales) AS Total_Revenue
FROM restaurant_data
GROUP BY Item_Name
ORDER BY Total_Quantity_Sold DESC
LIMIT 10;

-- Revenue Breakdown by Category
SELECT 
	Category, 
	SUM(Total_Sales) AS Total_Revenue
FROM restaurant_data
GROUP BY Category
ORDER BY Total_Revenue DESC;

-- Monthly Sales Trends
SELECT 
	DATE_FORMAT(Date, '%Y-%m') AS Month,
    SUM(Total_Sales) AS Monthly_Revenue
FROM restaurant_data
GROUP BY Month
ORDER BY Monthly_Revenue DESC;

-- Top Customers
SELECT 
	Customer_ID,
	SUM(Total_Sales) AS Total_Spending,
    COUNT(Order_ID) AS Total_Orders
FROM restaurant_data
GROUP BY Customer_ID
ORDER BY Total_Spending DESC
LIMIT 10;

-- Age Group Analysis
SELECT
	CASE
		WHEN Customer_Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Customer_Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Customer_Age BETWEEN 36 AND 50 THEN '36-50'
        ELSE '50+'
	END AS Age_Group,
    COUNT(DISTINCT Customer_ID) AS Customers,
    COUNT(Order_ID) AS Orders,
    SUM(Total_Sales) AS Total_Spending,
    AVG(Total_Sales) AS Avg_Spending_Per_Order
FROM restaurant_data
GROUP BY Age_Group;

-- Order Method (Dine-In, Delivery, Takeout) Analysis
SELECT
	Visit_Type,
    COUNT(Order_ID) AS Total_Orders,
    SUM(Total_Sales) AS Total_Revenue
FROM restaurant_data
GROUP BY Visit_Type
ORDER BY Total_Revenue DESC;

-- Average Wait Time by Meal Period
SELECT 
	Meal_Period,
    AVG(Wait_Time_Mins) AS Avg_Wait_Time
FROM restaurant_data
GROUP BY Meal_Period
ORDER BY Avg_Wait_Time DESC;

-- Busiest Days of the Week
SELECT 
	Day_of_the_Week,
    COUNT(Order_ID) AS Total_Orders,
    SUM(Total_Sales) AS Total_Revenue
FROM restaurant_data
GROUP BY Day_of_the_Week
ORDER BY Total_Orders DESC;

-- Peak Order Hours
SELECT 
	HOUR(Order_Time) AS Order_Hour,
    COUNT(Order_ID) AS Total_Orders
FROM restaurant_data
GROUP BY Order_Hour
ORDER BY Total_Orders DESC;
	




