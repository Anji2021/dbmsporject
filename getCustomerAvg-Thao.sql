
-- 2nd run
DELIMITER $$
CREATE PROCEDURE Calculate_avg2(id int, out idout int, out avg_rate decimal(10,2))
begin
select c.cus_id, avg(r.cus_rating)
	from rating r
	inner join customer c on c.cus_id = r.cus_id
	group by c.cus_id
	having c.cus_id = id;
set @idout = c.cus_id, @avg_rate = avg(r.cus_rating);
select @idout, @avg_rate;
end $$
DELIMITER ;

-- call calculate_avg2(8, @cust_id, @rate);

CREATE 
    TRIGGER  update_cus_avg2
 AFTER INSERT ON rating FOR EACH ROW 
    CALL  calculate_avg2 (new.cus_id , @tempid , @tempavg);
UPDATE customer c 
SET 
    c.cus_avg_rating = @tempavg
WHERE
    c.cus_id = @tempid;
    



 drop procedure calculate_avg2;

drop trigger update_cus_avg2;





