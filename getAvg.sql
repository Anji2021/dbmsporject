-- create temp tables
CREATE TABLE temp_cus_avg
(
  id INT(11) NOT NULL AUTO_INCREMENT,
  cus_id int,
  cus_tempAvg decimal(10,2),
  primary key (id),
  CONSTRAINT tempCus_fk FOREIGN KEY (cus_id)
        REFERENCES customer (cus_id)
);


CREATE TABLE temp_driver_avg
(
  id INT(11) NOT NULL AUTO_INCREMENT,
  driver_id int,
  driver_tempAvg decimal(10,2),
  primary key (id),
  CONSTRAINT tempDriv_fk FOREIGN KEY (driver_id)
        REFERENCES driver (driver_id)
);
insert into temp_cus_avg(id) values (1);
insert into temp_driver_avg(id) values (1);
describe rating;

-- stored procedure to calculate customer average ratings
DELIMITER $$
CREATE PROCEDURE calculate_cus_avg(id int)
begin
delete from temp_cus_avg;
insert into temp_cus_avg (cus_id, cus_tempavg)  values (
id, 
(select avg(r.cus_rating)
	from rating r where r.cus_id = id)
);
UPDATE customer c
        INNER JOIN
    temp_cus_avg t ON c.cus_id = t.cus_id 
SET 
    c.cus_avg_rating = t.cus_tempAvg
WHERE
    c.cus_id = id;
end $$
DELIMITER ;

-- stored procedure to calculate driver average ratings
DELIMITER $$
CREATE PROCEDURE calculate_driver_avg(id int)
begin
delete from temp_driver_avg;
insert into temp_driver_avg (driver_id, driver_tempavg)  values (
id, 
(select avg(r.driver_rating)
	from rating r where r.driver_id = id)
);
UPDATE driver d
        INNER JOIN
    temp_driver_avg t ON d.driver_id = t.driver_id 
SET 
    d.driver_avg_rating = t.driver_tempAvg
WHERE
    d.driver_id = id;
end $$
DELIMITER ;

-- trigger for both
DELIMITER $$
CREATE 
    TRIGGER update_avg_rating
 after INSERT ON rating FOR EACH ROW 
 begin
	call calculate_cus_avg(new.cus_id)  ;
    call calculate_driver_avg(new.driver_id);
    end $$
    DELIMITER ;
    
    
    
   
    
    