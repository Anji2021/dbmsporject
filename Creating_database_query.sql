CREATE DATABASE LYFT;
USE LYFT;


CREATE TABLE `customer` (
  `cus_id` int NOT NULL,
  `cus_fname` varchar(45) DEFAULT NULL,
  `cus_lname` varchar(45) DEFAULT NULL,
  `cus_email` varchar(50) DEFAULT NULL,
  `cus_phone` varchar(15) DEFAULT NULL,
  `cus_create_date` date DEFAULT NULL,
  `cus_last_upd` datetime DEFAULT NULL,
  `cus_active` tinyint(1) DEFAULT NULL,
  `cus_avg_rating` DECIMAL(10,2),
  PRIMARY KEY (`cus_id`)
);

CREATE TABLE `address` (
  `address_id` int PRIMARY KEY NOT NULL ,
  `street_name` varchar(50) DEFAULT NULL,
  `city_name` varchar(50) DEFAULT NULL,
  `zipcode` varchar(10) DEFAULT NULL
);

CREATE TABLE `payment_detail` (
  `payment_id` int NOT NULL,
  `payment_mode` varchar(25) DEFAULT NULL,
  `card_no` varchar(25) DEFAULT NULL,
  `cus_id` int DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `cus_id` (`cus_id`),
  CONSTRAINT `payment_detail_ibfk_1` FOREIGN KEY (`cus_id`) REFERENCES `customer` (`cus_id`)
);

-- remove driver rating
-- base_location should be an address_id
-- change phone no data type
CREATE TABLE `driver` (
  `driver_id` int NOT NULL,
  `driver_name` varchar(40) DEFAULT NULL,
  `driver_phone` varchar(15) DEFAULT NULL,
  `driver_base_loc` int,
  `driver_join_date` date DEFAULT NULL,
  `driver_birth_date` date DEFAULT NULL,
  `driver_email` varchar(40) DEFAULT NULL,
  `driver_avg_rating` DECIMAL(10,2),
  PRIMARY KEY (`driver_id`),
   CONSTRAINT `drive_history_ibfk_1` FOREIGN KEY (`driver_base_loc`)
        REFERENCES `address` (`address_id`)
);

CREATE TABLE `ride_history` (
    `ride_id` INT NOT NULL,
    `cus_id` INT DEFAULT NULL,
    `driver_id` INT DEFAULT NULL,
    `pickup_time` DATETIME DEFAULT NULL,
    `dropoff_time` DATETIME DEFAULT NULL,
    `pickup_address_id` INT DEFAULT NULL,
    `drop_address_id` INT DEFAULT NULL,
    `payment_id` INT DEFAULT NULL,
    `bill_amt` DECIMAL(10 , 2 ) DEFAULT NULL,
    `rating_id` int DEFAULT NULL,
    PRIMARY KEY (`ride_id`),
    KEY `cus_id` (`cus_id`),
    KEY `driver_id` (`driver_id`),
    KEY `payment_id` (`payment_id`),
    KEY `pickup_address_id` (`pickup_address_id`),
    KEY `drop_address_id` (`drop_address_id`),
    CONSTRAINT `ride_history_ibfk_1` FOREIGN KEY (`cus_id`)
        REFERENCES `customer` (`cus_id`),
    CONSTRAINT `ride_history_ibfk_2` FOREIGN KEY (`driver_id`)
        REFERENCES `driver` (`driver_id`),
    CONSTRAINT `ride_history_ibfk_3` FOREIGN KEY (`payment_id`)
        REFERENCES `payment_detail` (`payment_id`),
    CONSTRAINT `ride_history_ibfk_4` FOREIGN KEY (`pickup_address_id`)
        REFERENCES `address` (`address_id`),
    CONSTRAINT `ride_history_ibfk_5` FOREIGN KEY (`drop_address_id`) 
        REFERENCES `address` (`address_id`)
);

-- add customer id and driver id in
CREATE TABLE `rating` (
    `rating_id` INT PRIMARY KEY NOT NULL,
    `driver_rating` INT,
    `cus_rating` INT,
    `ride_id` INT NOT NULL,
    `cus_id` INT DEFAULT NULL,
    `driver_id` INT DEFAULT NULL,
    KEY `ride_id` (`ride_id`),
    KEY `cus_id` (`cus_id`),
    KEY `driver_id` (`driver_id`),
    CONSTRAINT `rating_fk1` FOREIGN KEY (`ride_id`)
        REFERENCES `ride_history` (`ride_id`),
    CONSTRAINT `rating_fk2` FOREIGN KEY (`cus_id`)
        REFERENCES `customer` (`cus_id`),
    CONSTRAINT `rating_fk3` FOREIGN KEY (`driver_id`)
        REFERENCES `driver` (`driver_id`)
);







