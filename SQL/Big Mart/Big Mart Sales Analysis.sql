/* Table big_mart */
select * from big_mart;

/* [ SQL Analysis on Big Mart Sales Dataset. ]*/

/* 1) WRITE a sql query to show all Item_Identifier. */
Select Item_Identifier from big_mart;

/* 2) WRITE a sql query to show count of total Item_Identifier. */
Select count(Item_Identifier) from big_mart;

/* 3) WRITE a sql query to show maximum Item Weight. */
SELECT Item_Identifier, Item_Weight
FROM big_mart
WHERE Item_Weight = (SELECT MAX(Item_Weight) FROM big_mart);

/* 4) WRITE a query to show minimun Item Weight. */
SELECT Item_Identifier, Item_Weight
FROM big_mart
WHERE Item_Weight = (SELECT MIN(Item_Weight) FROM big_mart);

/* 5) WRITE a query to show average Item_Weight. */
SELECT AVG(Item_Weight) AS Average_Item_Weight
FROM big_mart;

/* 6) WRITE a query to show count OF Item_Fat_Content WHERE Item_Fat_Content IS Low Fat. */
Select count(Item_Fat_Content) from big_mart where Item_Fat_Content = 'Low Fat';

/* 7) WRITE a query to show count OF Item_Fat_Content WHERE Item_Fat_Content IS Regular. */
Select count(Item_Fat_Content) from big_mart where Item_Fat_Content = 'Regular';

/* 8) WRITE a query TO show maximum Item_MRP. */
Select max(Item_MRP) from big_mart;

/* 9) WRITE a query TO show minimum Item_MRP. */
Select min(Item_MRP) from big_mart;

/* 10) WRITE a query to show Item_Identifier , Item_Fat_Content,Item_Type,Item_MRP and Item_MRP IS greater than 200. */
Select Item_Identifier , Item_Fat_Content , Item_Type , Item_MRP from big_mart
where Item_MRP > 200;

/* 11) WRITE a query to show maximum Item_MRP WHERE Item_Fat_Content IS Low Fat. */
Select max(Item_MRP) from big_mart where Item_Fat_Content = 'Low Fat';

/* 12) WRITE a query to show minimum Item_MRP AND Item_Fat_Content IS Low Fat. */
Select min(Item_MRP) from big_mart where Item_Fat_Content = 'Low Fat';

/* 13) WRITE a query to show ALL DATA WHERE item MRP IS BETWEEN 50 TO 100. */
Select * from big_mart where Item_MRP between 50 and 100;

/* 14) WRITE a query to show ALL UNIQUE value Item_Fat_Content. */
Select distinct(Item_Fat_Content) from big_mart;

/* 15) WRITE a query to show ALL UNIQUE value Item_Type. */
Select distinct(Item_Type) from big_mart;

/* 16) WRITE a query to show ALL DATA IN descending ORDER BY Item MRP. */
Select * from big_mart order by Item_MRP desc;

/*# 17) WRITE a query to show ALL DATA IN ascending ORDER BY Item_Outlet_Sales. */
Select * from big_mart order by Item_Outlet_Sales asc;

/* 18) WRITE a query to show ALL DATA IN ascending BY Item_Type. */
Select * from big_mart order by Item_Type asc;

/* 19) WRITE a query to show DATA OF item_type dairy & Meat. */
Select * from big_mart where Item_Type in ('Dairy','Meat');

/* 20) WRITE a query to show ALL UNIQUE value OF Outlet_Size. */
Select distinct(Outlet_Size) from big_mart;

/* 21) WRITE a query to show ALL UNIQUE value OF Outlet_Location_Type. */
Select distinct(Outlet_Location_Type) from big_mart;

/* 22) WRITE a query to show ALL UNIQUE value OF Outlet_Type. */
Select distinct(Outlet_Type) from big_mart;

/* 23) WRITE a query to show count NO. OF item BY Item_Type AND ordered it IN descending. */
Select Item_Type ,count(Item_Identifier) as No_of_item 
from big_mart 
group by Item_Type 
order by No_of_item desc;

/* 24) WRITE a query to show count NO. OF item BY Outlet_Size AND ordered it IN ascending. */
Select Outlet_Size , count(Item_Identifier) as No_of_item
from big_mart
group by Outlet_Size 
order by No_of_item asc;

/* 25) WRITE a query TO  show  count NO. OF item BY Outlet_Establishment_Year AND ordered it IN ascening. */

SELECT Outlet_Establishment_Year, COUNT(Item_Identifier) AS No_of_item
FROM big_mart
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year ASC;

/* 26) WRITE a query to show count NO. OF item BY Outlet_Type AND ordered it IN descending. */

Select Outlet_Type , count(Item_Identifier) as No_of_item
from big_mart
group by Outlet_Type 
order by No_of_item desc ;

/* 27) WRITE a query to show count of item BY Outlet_Location_Type AND ordered it IN descending. */

Select Outlet_Location_Type , count(Item_Identifier) as No_of_item
from big_mart
group by Outlet_Location_Type 
order by No_of_item desc ;

/* 28) WRITE a query to show maximum MRP BY Item_Type. */

Select Item_Type ,max(Item_MRP) as Max_MRP 
from big_mart 
group by Item_Type ;

/* 29) WRITE a query to show minimum MRP BY Item_Type. */

Select Item_Type ,min(Item_MRP) as Min_MRP 
from big_mart 
group by Item_Type ;

/* 30) WRITE a query to show minimum MRP BY Outlet_Establishment_Year AND ordered it IN descending. */

Select Outlet_Establishment_Year ,min(Item_MRP) as Min_MRP
from big_mart
group by Outlet_Establishment_Year 
order by Min_MRP desc ;

/* 31) WRITE a query to show maximum MRP BY Outlet_Establishment_Year AND ordered IN descending. */

Select Outlet_Establishment_Year ,max(Item_MRP) as Max_MRP
from big_mart
group by Outlet_Establishment_Year 
order by Max_MRP desc ;

/* 32) WRITE a query to show average MRP BY Outlet_Size AND ordered IN descending. */

Select Outlet_Size , avg(Item_MRP) as AVG_MRP 
from big_mart
group by Outlet_Size 
order by AVG_MRP desc ;

/* 33) WRITE a query to show average MRP BY Outlet_Size AND ordered IN ascending. */

Select Outlet_Size , avg(Item_MRP) as AVG_MRP 
from big_mart
group by Outlet_Size
order by AVG_MRP ASC ;

/* 34) WRITE a query to show Maximum MRP BY Outlet_Type AND ordered IN ascending. */

Select Outlet_Type  , MAX(Item_MRP) as AVG_MRP 
from big_mart
group by Outlet_Type 
order by AVG_MRP asc ;

/* 35) WRITE a query to show maximum Item_Weight BY Item_Type AND ordered IN descending. */

Select Item_Type , max(Item_Weight) as MAX_Weight 
from big_mart
group by Item_Type 
order by MAX_Weight desc ;

/* 36) WRITE a query to show maximum Item_Weight BY Outlet_Establishment_Year AND ordered IN ascending. */

Select Outlet_Establishment_Year , max(Item_Weight) as MAX_Weight
from big_mart
group by Outlet_Establishment_Year 
order by MAX_Weight asc ;

/* 37) WRITE a query to show minimum Item_Weight BY Outlet_Type AND ordered IN descending. */

Select Outlet_Type  , min(Item_Weight) as MIN_Weight
from big_mart
group by Outlet_Type 
order by MIN_Weight desc;

/* 38) WRITE a query to show average Item_Weight BY Outlet_Location_Type ORDER BY descending. */

Select Outlet_Location_Type , avg(Item_Weight) as AVG_Weight
from big_mart 
group by Outlet_Location_Type 
order by AVG_Weight desc;

/* 39) WRITE a query to show maximum Item_Outlet_Sales BY Item_Type. */

Select Item_Type , max(Item_Outlet_Sales) as MAX_Outlet_sales 
from big_mart
group by Item_Type;

/* 40) WRITE a query to show minimum Item_Outlet_Sales BY Item_Type. */

Select Item_Type , min(Item_Outlet_Sales) as MIN_Outlet_sales 
from big_mart
group by Item_Type;

/* 41) WRITE a query to show minimum Item_Outlet_Sales BY Outlet_Establishment_Year ORDER BY descending. */

Select Outlet_Establishment_Year , min(Item_Outlet_Sales) as MIN_Outlet_sales
from big_mart
group by Outlet_Establishment_Year
order by MIN_Outlet_sales desc;

/* 42) WRITE a query to show maximum Item_Outlet_Sales BY Outlet_Establishment_Year ordered BY descending. */

Select Outlet_Establishment_Year , max(Item_Outlet_Sales) as MAX_Outlet_sales
from big_mart
group by Outlet_Establishment_Year 
order by MAX_Outlet_sales desc;

/* 43) WRITE a query to show average Item_Outlet_Sales BY Outlet_Size AND ORDER it descending. */

Select Outlet_Size , avg(Item_Outlet_Sales) as AVG_Outlet_sales
from big_mart
group by Outlet_Size 
order by AVG_Outlet_sales desc ;

/* 44) WRITE a query to show average Item_Outlet_Sales BY Outlet_Size. */

Select Outlet_Size , avg(Item_Outlet_Sales) as AVG_Outlet_sales
from big_mart
group by Outlet_Size;

/* 45) WRITE a query to show average Item_Outlet_Sales BY Outlet_Type AND ordered IN ascending. */

Select Outlet_Type , avg(Item_Outlet_Sales) as AVG_Outlet_sales
from big_mart
group by Outlet_Type
order by AVG_Outlet_sales asc ;

/* 46) WRITE a query to show maximum Item_Outlet_Sales BY Outlet_Type AND ordered IN ascending. */

Select Outlet_Type , max(Item_Outlet_Sales) as MAX_Outlet_sales
from big_mart
group by Outlet_Type 
order by MAX_Outlet_sales asc ;

/* 47) WRITE a query to show total Item_Outlet_Sales BY Outlet_Establishment_Year AND ORDER it descending. */

Select Outlet_Establishment_Year , sum(Item_Outlet_Sales) as total_Outlet_sales 
from big_mart
group by Outlet_Establishment_Year 
order by total_Outlet_sales desc;

/* 48) WRITE a query to show total Item_Outlet_Sales BY Item_Type AND ORDER it descending. */

Select Item_Type , sum(Item_Outlet_Sales) as total_Outlet_sales
from big_mart
group by Item_Type 
order by total_Outlet_sales desc;

/* 49) WRITE a query to show total Item_Outlet_Sales BY Outlet_Location_Type AND ORDER it descending. */

Select Outlet_Location_Type , sum(Item_Outlet_Sales) as total_Outlet_sales
from big_mart
group by Outlet_Location_Type  
order by total_Outlet_sales desc;

/* 50) WRITE a query to show total Item_Outlet_Sales BY Item_Fat_Content AND ORDER it descending. */

Select Item_Fat_Content , sum(Item_Outlet_Sales) as total_Outlet_sales
from big_mart
group by Item_Fat_Content 
order by total_Outlet_sales desc;

/* 51) WRITE a query to show maximum Item_Visibility BY Item_Type AND ORDER it descending. */

Select Item_Type , max(Item_Visibility) as MAX_Visibility 
from big_mart
group by Item_Type 
order by MAX_Visibility desc ;

/* 52) WRITE a query to show Minimum Item_Visibility BY Item_Type AND ORDER it descending. */

Select Item_Type , min(Item_Visibility) as MIN_Visibility
from big_mart
group by Item_Type 
order by MIN_Visibility desc ;

/* 53) WRITE a query to show total Item_Outlet_Sales BY Item_Type but ONLY WHERE Outlet_Location_Type IS Tier 1. */

SELECT Item_Type, SUM(Item_Outlet_Sales) AS Total_Outlet_Sales
FROM big_mart
WHERE Outlet_Location_Type = 'Tier 1'
GROUP BY Item_Type
ORDER BY Total_Outlet_Sales DESC;

/* 54) WRITE a query to show total Item_Outlet_Sales BY Item_Type WHERE Item_Fat_Content IS ONLY Low Fat & LF. */

SELECT Item_Type, Item_Fat_Content, SUM(Item_Outlet_Sales) AS Total_Outlet_Sales
FROM big_mart
WHERE Item_Fat_Content IN ('Low Fat', 'LF')
GROUP BY Item_Type, Item_Fat_Content
ORDER BY Total_Outlet_Sales DESC;