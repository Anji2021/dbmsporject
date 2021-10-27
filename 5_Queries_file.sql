Use lyft;

describe driver;
#Query 1:- Counting how many customers are active right now?
select count(*) as "Active Users"
from customer
where cus_active = 1;

#Query 2:- How many drivers are working with lyft for more than 3 years?
select driver_name, driver_join_date
from driver
where  year(driver_join_date)<"2018";

#Query 3A:- Finding out top 5 drivers with highest average rating.
select driver_id, driver_name, driver_avg_rating
from driver
order by driver_avg_rating desc
limit 3;

#Query 3B:- Finding the 3 highest rated customers.
select cus_id, CONCAT(cus_fname ,' ', cus_lname) AS 'Customer Name', cus_avg_rating
from customer
order by cus_avg_rating desc
limit 3;


#Query 4:- Finding out total number of rides for each driver.
SELECT 
    driver.driver_id,
    driver.driver_name,
    COUNT(ride_history.ride_id) AS 'Total no of Rides'
FROM
    driver
        RIGHT JOIN
    ride_history ON driver.driver_id = ride_history.driver_id
GROUP BY driver_id;

#Query 5:- Finding out which city has the highest number of ride bookings.

select address.city_name, count(address_id) AS 'Number_of_rides'
from address
join ride_history
on address.address_id = ride_history.pickup_address_id
Group by address.city_name
order by count(address_id) desc;