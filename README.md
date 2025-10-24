# Supply-Chain-Mysql-project

# 🚚 Xpress Bees Delivery Performance Analysis

## 📄 Project Overview
This project focuses on analyzing delivery performance and logistics efficiency for **Xpress Bees**, a hypothetical courier and logistics company.  
Using **SQL**, key delivery KPIs were measured to assess **on-time performance, accuracy, cost efficiency, and first-attempt delivery success**.  
The analysis supports data-driven decision-making in **operations and supply chain optimization**.

---

## 🎯 Objectives
The main goal was to evaluate and improve the company’s operational performance through data analytics.  
Key objectives included:
1. Understanding delivery trends and time efficiency.
2. Measuring accuracy and first-attempt success rates.
3. Analyzing transportation costs across regions, carriers, and modes.
4. Providing actionable insights for process improvement.

---

## 🧩 Dataset Details
**Database Name:** `EXPRESS_BEES`  
**Table:** `Orders`

| Column Name | Data Type | Description |
|--------------|------------|-------------|
| Order_ID | VARCHAR(20) | Unique identifier for each order |
| Order_Date | DATE | Date when the order was placed |
| Shipped_Date | DATE | Date when the order was shipped |
| Delivery_Date | DATE | Actual delivery date |
| Customer_Region | VARCHAR(50) | Region where the order was delivered |
| Warehouse | VARCHAR(50) | Source warehouse |
| Product_Category | VARCHAR(50) | Type/category of product |
| Quantity | INT | Quantity of products ordered |
| Unit_Cost | DECIMAL(10,2) | Cost per unit of product |
| Transport_Mode | VARCHAR(50) | Mode of transport (Air, Road, etc.) |
| Carrier_Name | VARCHAR(50) | Name of logistics carrier |
| Order_Status | VARCHAR(20) | Current status (Delivered, Pending, etc.) |
| Delivery_Time | INT | Total delivery time (days) |
| Delivery_On_Time | VARCHAR(100) | 'Y' if delivered on or before time |
| Delay_Days | INT | Number of days delayed |
| Delivery_Accuracy | CHAR(1) | 'Y' if delivered correctly |
| Delivery_Attempts | INT | Number of delivery attempts made |

---

## 📊 KPIs (Key Performance Indicators)
The following KPIs were calculated to measure operational performance:

1. **On-Time Delivery %**  
   Measures how many orders were delivered on or before the promised date.

2. **Average Delivery Time**  
   Overall and region-wise average time from order to delivery.

3. **Delivery Accuracy %**  
   Percentage of orders successfully delivered to the correct customer without errors.

4. **First Attempt Success (FAS) %**  
   Percentage of deliveries completed successfully in the first attempt.

5. **Transportation Cost Efficiency**  
   Evaluates cost per shipment across region, carrier, and transport mode.

6. **Cost vs Performance Analysis**  
   Combines metrics such as cost, delay, and on-time performance for carrier evaluation.

---

## 🧠 SQL Insights
- Used **aggregate and conditional functions** (`SUM`, `AVG`, `COUNT`, `CASE WHEN`) to derive operational KPIs.  
- Leveraged **GROUP BY** for region, carrier, and transport-level breakdowns.  
- Measured **delivery efficiency and delay patterns** using `DATEDIFF()`.  
- Performed **cost-performance analysis** to compare operational cost and delivery speed.

---

