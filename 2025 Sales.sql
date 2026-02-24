SELECT * FROM sales_analysis.sales;

select sum(quantity)
from sales;
	#--fleet performance & utilization
#1.Vehicle that completed the most trips
	select vehicle_id, count(quantity) as Trips
    from sales
    group by vehicle_id
    order by Trips desc
    limit 1;

#2.Vehicle that transported the highest quantity of products
	select vehicle_id, sum(quantity) as Total_Quantity
    from sales_analysis.sales
    group by vehicle_id
    order by Total_Quantity desc
    limit 1;
  
	#--destination&route insights
#3.Distributor that has the highest number of orders
	select distributor, count(quantity) as Orders
    from sales
    group by distributor
    order by Orders desc
    limit 1;
    
#4.Distributor with the most volume
	select distributor, sum(quantity) as Total_Volume
    from sales
    group by distributor
    order by Total_Volume desc
    limit 1;
    
#5.Distributors that has the highest number of orders per product
    select distributor,
	SUM(CASE WHEN product = 'keg' THEN 1 ELSE 0 END) AS Keg_Orders,
    SUM(CASE WHEN product = 'udv' THEN 1 ELSE 0 END) AS UDV_Orders,
    COUNT(*) AS Total_Orders
   from sales
    where product IN ('keg', 'udv')
	group by distributor ;


	#--vehicle efficiency and load balancing
#6.Average tonnage per trip for each vehicle
	select vehicle_id, avg(tonnage) as Avg_Tonnage
    from sales
    group by vehicle_id
    order by Avg_Tonnage;
    
#7.Total number of vehicles categorised with tonnage
	select tonnage, count(distinct vehicle_id) as Total_Vehicles
    from sales
    where tonnage in ('7','13')
	group by tonnage;
    
#8.Categorise vehicle tonnage
 select vehicle_id, tonnage,
    CASE 
        WHEN TONNAGE LIKE '%7%' THEN 'Light Duty'
        WHEN TONNAGE LIKE '%13%' THEN 'Heavy Duty'
        ELSE 'Other'
    END AS Vehicle_Category
FROM sales;

#9.Which vehicles were used for keg & udv product deliveries
	select vehicle_id,
    MAX(CASE WHEN product = 'keg' THEN vehicle_id END) AS keg_vehicle,
    MAX(CASE WHEN product = 'udv' THEN vehicle_id END) AS udv_vehicle
	from sales
    where product IN ('keg', 'udv')
	group by vehicle_id
	order by vehicle_id DESC;
	
#--time-base analysis
#10.number of trips each vehicle delivered for specific product
	select vehicle_id,
    COUNT(CASE WHEN product = 'keg' THEN 1 END) AS keg_trips,
    COUNT(CASE WHEN product = 'udv' THEN 1 END) AS udv_trips,
	COUNT(*) AS Total_trips
	from sales
	where product IN ('keg', 'udv')
	group by vehicle_id
    order by Total_trips desc;
    
#11.Trips per day to track peak logistics activity
 select trip_date,count(*)  as Total_Trips
 from sales
 group by trip_date
 order by total_trips desc;
 
#12.vehicles used in multiple trips on the same day stating the product
 select vehicle_id, product,trip_date, count(*) as Trips_PerDay
 from sales
 group by vehicle_id,product,trip_date
 having count(*)>1;

#13.Top 5 destinations receiving the highest quantity of products
	select distributor, product, sum(quantity) as Total_Quantity
	from sales
	where product IN ('keg', 'udv')
	group by distributor, product
	order by Total_Quantity desc
	Limit 5;

#14.Monthly distribution trend of deliveries
	select date_format(trip_date,'%b') AS Month, count(distinct vehicle_id) as Trucks,
    Count(CASE WHEN product = 'keg' THEN 1 END) AS keg_orders,
    Count(CASE WHEN product = 'udv' THEN 1 END) AS udv_orders,
    Count(*) AS Total_Deliveries
	from sales
	group by date_format(trip_date,'%b')
	order by Total_Deliveries DESC;

#15.Top 5 vehicles that had the highest daily quantity delivered
	select vehicle_id, trip_date,distributor, product, Max(Quantity) AS Highest_Quantity
	from sales
	where product in  ('keg','udv') 
	group by vehicle_id, trip_date,distributor,product
	order by Highest_Quantity DESC
	Limit 5;
    
#16.Count of deliveries per product type
	select product, count(*) as Delivery_Count
	from sales
	group by product;

#17.Identify vehicles frequently used for deliveries (trip count > 5)
	select vehicle_id,
	SUM(CASE WHEN product = 'keg' THEN 1 ELSE 0 END) AS Keg_Trips,
	SUM(CASE WHEN product = 'udv' THEN 1 ELSE 0 END) AS UDV_Trips,
	COUNT(*) AS Total_Trips
	from sales
	group by vehicle_id
	having Total_Trips > 5
	order by  Total_Trips DESC;

#18.the busiest day (highest number of deliveries)
	select trip_date, count(*) As Highest_Deliveries
	from sales
	group by trip_date
	order by Highest_Deliveries DESC
	Limit 1;

#19.vehicle that had the most varied delivery destinations
	select vehicle_id, count( distinct distributor) as Unique_Distributor
	from sales
	group by vehicle_id
	order by Unique_Distributor DESC
	Limit 1;
    
#20.The optimal vehicle for large product deliveries (≥700 quantity)
	select vehicle_id,distributor, count(*) as Large_Deliveries
	from sales
	where quantity >= 700
	group by distributor,vehicle_id
	order by Large_deliveries Desc;

#21.Yearly product distribution volume trend 
	select year(Trip_Date) as Year, product,sum(quantity) as Total_Distribution
	from sales
	group by year,product
	order by YEAR ;

#22.Monthly product distribution volume trend 
	select date_format(trip_date,'%b') as Month, product,sum(quantity) as Total_Distribution
	from sales
	group by date_format(trip_date,'%b'),product
	order by month;

#23.Total Orders per Distribution Point
	select distributor, 
	SUM(CASE WHEN product = 'keg' THEN 1 ELSE 0 END) AS Keg_Orders,
	SUM(CASE WHEN product = 'udv' THEN 1 ELSE 0 END) AS UDV_Orders,
	count(*) as Total_Orders
	from sales
	group by distributor
	order by Total_Orders DESC;
    
#24.total quantities per distribution point
	select distributor,
	SUM(CASE WHEN product = 'keg' THEN quantity ELSE 0 END) AS KEG_Quantities,
	SUM(CASE WHEN product = 'udv' THEN quantity ELSE 0 END) AS UDV_Quantities,
	Sum(quantity) as Total_Quantities
	from sales
	group by distributor
	order by Total_Quantities DESC;
    
 
 #25.Average Load per Trip for Each Distribution Point
	select distributor, 
	SUM(CASE WHEN product = 'keg' THEN quantity ELSE 0 END) AS KEG_Quantities,
	SUM(CASE WHEN product = 'udv' THEN quantity ELSE 0 END) AS UDV_Quantities,
	Round(Avg(quantity),2) as Avg_LoadTrip
	from sales
	group by distributor
	order by Avg_LoadTrip DESC;

 
 #26.Most Frequently Used Vehicles for Each Distribution Point
	select distributor, vehicle_id,
	SUM(CASE WHEN product = 'keg' THEN 1 ELSE 0 END) AS Keg_Trips,
	SUM(CASE WHEN product = 'udv' THEN 1 ELSE 0 END) AS UDV_Trips,
	count(*) as No_Trips
	from sales
	group by distributor, vehicle_id
	order by No_Trips Desc;




    
    