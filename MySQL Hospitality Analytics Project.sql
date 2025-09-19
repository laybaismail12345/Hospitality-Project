show databases;

CREATE database exercise_1;
 
use  exercise_1;
 

show tables;

select * from fact_bookings;
Select * from fact_aggregated_bookings;
Select * from dim_date;
Select * from dim_hotels;
Select * from dim_rooms;

                                   
DELIMITER $$

CREATE FUNCTION format_num(num BIGINT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    RETURN (
        CASE
            WHEN num >= 1000000000 THEN CONCAT(ROUND(num / 1000000000, 2), 'B')
            WHEN num >= 1000000 THEN CONCAT(ROUND(num / 1000000, 2), 'M')
            WHEN num >= 1000 THEN CONCAT(ROUND(num / 1000, 2), 'K')
            ELSE CAST(num AS CHAR)
        END
    );
END$$

DELIMITER ;


                                    ##### Q-1 Total Revenue
select format_num(sum(revenue_generated)) as Total_Revenue from fact_bookings; 

                                    ##### Q-2 Occupancy Rate
Select num_percent(sum(successful_bookings)/ sum(capacity)*100) as Occupancy_rate from fact_aggregated_bookings;						

								    ##### Q-3 Cancellation Rate
Select num_percent(sum( case when booking_status = 'cancelled' then 1 else 0 end )*100 / count(booking_status))
as Cancellation_Rate from fact_bookings;		

								    ##### Q-4 Total Bookings
                                    
Select format_num(count( Booking_status))as Total_Bookings from fact_bookings;

						            ##### Q-5 Utilized Capacity (A measure of how effectively the available room capacity is being used.

Select dim_date.`week no` ,num_percent(sum( successful_bookings ) / sum( Capacity ) * 100) as Utilized_Capacity from fact_aggregated_bookings
left join dim_date on fact_aggregated_bookings.check_in_date = dim_date.date
group by dim_date.`week no`
order by dim_date.`week no`asc;
                  
				    ##### Q-6 Trend Analysis (Observing and evaluating how key metrics like revenue and occupancy change over time.                          
SELECT DISTINCT check_in_date FROM fact_aggregated_bookings;
SELECT DISTINCT check_in_date_new FROM fact_bookings;

ALTER TABLE fact_bookings
ADD COLUMN check_in_date_new DATE;

ALTER TABLE fact_bookings 
MODIFY COLUMN check_in_date_new VARCHAR(20);

SET SQL_SAFE_UPDATES = 0;

UPDATE fact_bookings
SET check_in_date_new = 
    date_format(check_in_date, '%d-%b-%y');

SET SQL_SAFE_UPDATES = 1;

select * from fact_bookings;
Select * from fact_aggregated_bookings;
describe fact_aggregated_bookings;

Select week(B.check_in_date), format_num(Sum(B.revenue_generated)) as Total_Revenue, num_percent(sum( successful_bookings ) / sum( Capacity ) * 100)  as Occupancy
from fact_bookings B
join fact_aggregated_bookings A 
On B.check_in_date_new = A.check_in_date
and B.property_id = A.property_id
group by week(B.check_in_date)
order by week(B.check_in_date);



                    ##### Q-7 Weekday & Weekend Revenue and Booking

Select D.day_type, format_num(sum(B.revenue_generated)) as Total_Revenue , count(B.booking_status) as Total_Bookings
from fact_bookings B
join dim_date D
On B.check_in_date_new = D.date
Group by D.day_type;
  
                    ##### Q-8 Revenue by City & Hotel (Breakdown of total revenue generated, segmented by hotel location and property.)
describe dim_hotels;
Select * from dim_hotels;
select * from fact_bookings;

Select H.City, H.property_name, format_num(sum(B.revenue_generated)) as Total_Revenue
from fact_bookings B
join dim_hotels H 
On B.property_id = H.property_id 
group by H.City,H.Property_name
order by H.City , Total_Revenue desc;

                       ##### Q-9 Class Wise Revenue (Revenue segmented by room category (e.g., standard, deluxe, suite).)
Select * from dim_rooms;   
select * from fact_bookings;
                    
Select  R.room_class , format_num(Sum(B.revenue_generated)) as Total_Revenue 
from  fact_bookings B
join dim_rooms R 
On B.room_category = R.room_id
Group by R.room_class;           
 
                       ###### Q-10 Checked Out / Cancel / No Show (Status-based categorization of bookings, indicating guest behavior or booking outcome.)
                     
Select booking_status , Count(booking_status) from fact_bookings
group by booking_status;                 

                        ##### Q-11 Weekly Trend – Key Metrics (Weekly insights into key performance indicators such as revenue, bookings, and occupancy.)
describe fact_bookings;
                        
select * from fact_bookings;
Select * from fact_aggregated_bookings;
Select * from dim_date;

Select D.`week no`, format_num(sum(B.revenue_generated)) as Total_Revenue, format_num(count(B.booking_status))
As Total_Bookings, num_percent(sum(A.successful_bookings)/ sum(A.capacity) *100) As Occupancy 
from fact_bookings B 
join fact_aggregated_bookings A  On B.property_id = A.property_id
and  B.check_in_date_new = A.check_in_date
join dim_date D On A.check_in_date = D.date
Group by D.`week no`
Order by D.`week no` asc;



