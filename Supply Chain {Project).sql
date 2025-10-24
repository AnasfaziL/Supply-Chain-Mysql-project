CREATE DATABASE EXPRESS_BEES;



CREATE TABLE Orders (
  Order_ID VARCHAR(20),
  Order_Date DATE,
  Shipped_Date DATE,
  Delivery_Date DATE,
  Customer_Region VARCHAR(50),
  Warehouse VARCHAR(50),
  Product_Category VARCHAR(50),
  Quantity INT,
  Unit_Cost DECIMAL(10,2),
  Transport_Mode VARCHAR(50),
  Carrier_Name VARCHAR(50),
  Order_Status VARCHAR(20),
  Delivery_Time INT,
  Delivery_On_Time VARCHAR(100),
  Delay_Days INT,
  Delivery_Accuracy CHAR(1),
  Delivery_Attempts INT
);

Select *
from Orders;





-- Xpress Bees Project--

-- Exploratoy data Analysis --
-- Explore the raw data and basic counts.
-- KPI 1 – Percentage of orders delivered on time.
-- KPI 2 – Average delivery time overall and per region.
-- KPI 3 – Delivery accuracy percentage.
-- KPI 4 – First Attempt Success % overall, by region, and by carrier/transport mode.
-- KPI 5 – Transportation cost efficiency by region, mode, and carrier.
-- KPI 6 – Combined cost vs performance analysis (cost, speed, delay, on-time %) by carrier and transport mode.


-- View all orders
SELECT *
FROM Orders;

-- Check all delivered orders
SELECT Order_Status
FROM Orders
WHERE Order_Status = 'Delivered';

-- Count of delivered orders
SELECT COUNT(Order_Status) AS Total_Delivered
FROM Orders
WHERE Order_Status = 'Delivered';

-- KPI 1 – On-Time Delivery %
SELECT 
    ROUND(100.0 * SUM(
    CASE WHEN Delivery_On_Time = 'Y' THEN 1 ELSE 0 END
    ) / COUNT(*), 2) AS Delivery_On_Time_Percentage
FROM Orders
WHERE Order_Status = 'Delivered';

-- KPI 2 – Average Delivery Time

-- Overall Average Delivery Time
SELECT ROUND(AVG(DATEDIFF(Delivery_Date, Order_Date)), 2) AS Avg_Delivery_Time
FROM Orders
WHERE Order_Status = 'Delivered';

-- Average Delivery Time per Region
SELECT 
    Customer_Region, 
    ROUND(AVG(DATEDIFF(Delivery_Date, Order_Date)), 2) AS Avg_Delivery_Time
FROM Orders
WHERE Order_Status = 'Delivered'
GROUP BY Customer_Region;


-- KPI 3 – Delivery Accuracy %
SELECT 
    ROUND(100.0 * SUM(CASE WHEN Delivery_Accuracy = 'Y' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Delivery_Accuracy_Percentage
FROM Orders
WHERE Order_Status = 'Delivered';

-- KPI 4 – First Attempt Success % (FAS)


-- Overall First Attempt Success
SELECT 
    ROUND(100.0 * SUM(CASE WHEN Delivery_Attempts = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS FAS
FROM Orders
WHERE Order_Status = 'Delivered';

-- FAS by Region
SELECT 
    Customer_Region, 
    ROUND(100.0 * SUM(CASE WHEN Delivery_Attempts = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS FAS
FROM Orders
WHERE Order_Status = 'Delivered'
GROUP BY Customer_Region
ORDER BY FAS DESC;

-- FAS by Region + Transport Mode + Carrier
-- Fas (First Attempt Success)
SELECT 
    Customer_Region, 
    Transport_Mode, 
    Carrier_Name,
    ROUND(100.0 * SUM(CASE WHEN Delivery_Attempts = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS FAS
FROM Orders
WHERE Order_Status = 'Delivered'
GROUP BY Customer_Region, Transport_Mode, Carrier_Name
ORDER BY FAS ASC;

-- KPI 5 – Transportation Cost Efficiency

SELECT 
    Customer_Region,
    Transport_Mode,
    Carrier_Name,
    ROUND(AVG(Unit_Cost * Quantity), 2) AS Transportation_Cost_per_Unit
FROM Orders
WHERE Order_Status = 'Delivered'
GROUP BY Customer_Region, Transport_Mode, Carrier_Name
ORDER BY Transportation_Cost_per_Unit DESC, Transport_Mode, Carrier_Name;

-- KPI 6 – Cost vs Performance Analysis

SELECT 
    Carrier_Name,
    Transport_Mode,
    ROUND(AVG(Quantity * Unit_Cost), 2) AS Transportation_Cost,
    ROUND(AVG(Delivery_Time), 2) AS Delivery_Speed,
    ROUND(AVG(Delay_Days), 2) AS Delay,
    ROUND(100.0 * SUM(CASE WHEN Delivery_On_Time = 'Y' THEN 1 ELSE 0 END) / COUNT(*), 2) AS OnTime_Percentage
FROM Orders
WHERE Order_Status = 'Delivered'
GROUP BY Carrier_Name, Transport_Mode
ORDER BY Transportation_Cost DESC;












































Select (order_status)
from Orders
where order_status = "Delivered"
;

Select Count(order_status)
from Orders
where order_status = "Delivered"
;

-- KPI- 1
-- Total Percentage of Orders Delivered on Time
Select 
	100*sum(
			Case When Delivery_On_Time= "Y" THEN 1 ELSE 0
				END
            )/COUNT(*) as Delivery_On_Time_Percentage
from Orders
where Order_status = "Delivered";


-- KPI 2
-- Average time taken from order to delivery



-- Avgerage time taken to deliver per region 
-- West and North region needs attention 

Select Round(avg(datediff(Delivery_Date,Order_Date)),2) as Delivery_Time, Customer_Region
from Orders 
where order_status='Delivered'
group by Customer_Region;



-- KPI 3
-- Delivery Accuracy % 
-- (How many Deliveries successfully made)


Select 
	ROUND(100.0*SUM( CASE WHEN
						Delivery_Accuracy = 'Y' THEN 1 ELSE 0 END)/COUNT(*),2) as Delivery_accuracy_Percentage
      From Orders
      Where Order_status ='Delivered';


-- KPI - 4
-- Delivery Attempts / First Attempt Success


-- Orders Delivered in  First Attempt

Select Count(Delivery_Attempts) as DFA
from Orders
where Delivery_Attempts = 1 AND 
Order_status ='Delivered';
 
 
-- First Attempt Success %
select 
 ROUND(100.0*sum( CASE WHEN
			DElivery_Accuracy="Y" THEN 1 ELSE 0 
            END)/COUNT(*),2) as FAS
From orders
where Order_Status= "Delivered";



-- First Attempt Success % 
-- BY Region

select 
 ROUND(100.0*sum( CASE WHEN
			DElivery_Accuracy="Y" THEN 1 ELSE 0 
            END)/COUNT(*),2) as FAS, Customer_Region
From orders
where Order_Status= "Delivered"
group by Customer_Region 
Order by FAS DESC;
--  (WEST) region needs critical attention 

-- First Attempt Success % 
-- BY Transport Customer_Region , Transport_Mode & Carrier_Name


select 
 ROUND(100.0*sum( CASE WHEN
			DElivery_Attempts="1" THEN 1 ELSE 0 
            END)/COUNT(*),2) as FAS, Customer_Region , Transport_Mode, Carrier_Name
From orders
where Order_Status= "Delivered"
group by Customer_Region ,Transport_Mode, Carrier_Name
Order by FAS ASC;

-- By analyzing it shows South Region Carrier "Delivery" is not performing well by Road Transport
-- Reasons: delivery failures or poor route planning.



-- KPI Transportation Cost Efficiency

Select 
		ROUND(AVG(Unit_Cost*Quantity),2) as Transportation_Cost_per_Unit,
        Customer_Region , Transport_Mode, Carrier_Name
From orders
where order_status="Delivered"
group by Customer_Region , Transport_Mode, Carrier_Name
Order by Transportation_Cost_per_Unit DESC, Transport_Mode, Carrier_Name;

-- BLUE DART is charging the most per unit cost for Transportation
Select *
From ORders;

-- KPI 6
-- Cost vs. Performance Analysis

Select 
	   Carrier_Name,
	  ROUND(AVG(Quantity*Unit_Cost),2) as Transportation_Cost,
       ROUND(AVG(Delivery_Time),2) as Delivery_speed,
      ROUND(AVG(Delay_days),2) as delay,
     
      Transport_Mode,
      ROUND(100.0*SUM(CASE WHEN Delivery_on_Time="Y" THEN 1 ELSE 0 END)/COUNT(*),2) as OnTime_Percentage
From Orders
where order_status ='Delivered'
group by Carrier_Name, Transport_Mode 
Order by Transportation_Cost desc;



      
