## 2025 Sales & Logistics Performance Analysis

## Project Overview
This project provides a comprehensive analysis of sales and logistics data for the year 2025. It focuses on fleet utilization, distributor efficiency, and product distribution volume. The analysis is performed using SQL to extract actionable insights from raw delivery and sales records.

## Key Insights Tracked
* **Fleet Performance:** Identifying vehicles with the highest trip counts and total quantity transported.
* **Logistics Efficiency:** Calculating average tonnage and load per trip for various distribution points.
* **Market Analysis:** Analyzing the highest-performing distributors and monthly distribution trends for specific products like KEG and UDV.
* **Vehicle Utilization:** Tracking the most frequently used vehicles across different routes.

## Dataset Description
[cite_start]The core dataset (`sales.csv`) contains the following attributes:
- `trip_date`: Date of the delivery.
- `vehicle_id`: Unique identifier for the delivery vehicle.
- `tonnage`: Capacity or weight of the load.
- `product`: Type of product distributed (e.g., KEG, UDV).
- `distributor`: The receiving entity for the order.
- `quantity` & `amount`: Volume and financial value of the trip.

## How to Use
1.  **Data Setup:** Import the `sales.csv` file into your SQL environment (MySQL, PostgreSQL, etc.).
2.  **Run Analysis:** Execute the queries provided in `2025 Sales.sql` to generate the performance reports.

## Technologies Used
* SQL (MySQL Workbench)
* Data Analysis & Logistics Optimization
