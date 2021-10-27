
#Stored procedure for finding number of drivers in a particular location
DELIMITER //
CREATE PROCEDURE Calculate_count(id int)
begin
select d.driver_base_loc as 'Address ID', concat(a.street_name, ' ', a.city_name, ' ', a.zipcode) as 'Address' ,count(d.driver_id) as 'Number of drivers'
from driver d
left join address a on d.driver_base_loc = a.address_id
where driver_base_loc = id
group by d.driver_base_loc;
END // 
DELIMITER ;

call Calculate_count(101);

Describe customer;
Select * from customer;
