#View:- this is a view.. tried to create an invoice which includes customer name, driver name, ride_time, bill amount.
CREATE VIEW INVOICE AS
     SELECT ride_history.ride_id AS 'Ride Id', Date(ride_history.pickup_time) AS 'Date',
        CONCAT(customer.cus_fname, ' ', customer.cus_lname) As 'Customer Name',
        driver.driver_name As ' Driver Name' ,TIMEDIFF(dropoff_time, pickup_time) AS 'Ride duration',ride_history.bill_amt AS 'Total Bill'
    FROM ride_history
	Join customer
	On customer.cus_id = ride_history.cus_id
	Join driver
	On driver.driver_id = ride_history.driver_id;
        
		Select * from INVOICE;
      