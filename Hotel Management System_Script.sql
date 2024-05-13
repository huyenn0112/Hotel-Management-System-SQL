CREATE DATABASE Hotel_Management_System
GO
USE Hotel_Management_System
-- -----------------------------------------------------
-- Table addresses
-- -----------------------------------------------------
DROP TABLE IF EXISTS addresses ;
go
CREATE TABLE addresses(
  address_id INT NOT NULL,
  address_line1 VARCHAR(100) NULL,
  address_line2 VARCHAR(100) NULL,
  city VARCHAR(45) NULL,
  state VARCHAR(45) NULL,
  country VARCHAR(45) NULL,
  zipcode VARCHAR(8) NULL,
  PRIMARY KEY (address_id))
  GO
-- -----------------------------------------------------
-- Table hotel_chain
-- -----------------------------------------------------
DROP TABLE IF EXISTS hotel_chain ;

CREATE TABLE hotel_chain (
  hotel_chain_id INT NOT NULL,
  hotel_chain_name VARCHAR(45) NULL,
  hotel_chain_contact_number VARCHAR(12) NULL,
  hotel_chain_email_address VARCHAR(45) NULL,
  hotel_chain_website VARCHAR(45) NULL,
  hotel_chain_head_office_address_id INT NOT NULL,
  PRIMARY KEY (hotel_chain_id),
  CONSTRAINT fk_hotel_chains_addresses1
    FOREIGN KEY (hotel_chain_head_office_address_id)
    REFERENCES addresses (address_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
GO
-- -----------------------------------------------------
-- Table star_ratings
-- -----------------------------------------------------
DROP TABLE IF EXISTS star_ratings ;

CREATE TABLE star_ratings (
  star_rating INT NOT NULL,
  PRIMARY KEY (star_rating))
GO
-- -----------------------------------------------------
-- Table hotel
-- -----------------------------------------------------
DROP TABLE IF EXISTS hotel ;

CREATE TABLE  hotel (
  hotel_id INT NOT NULL,
  hotel_name VARCHAR(45) NULL,
  hotel_contact_number VARCHAR(12) NULL,
  hotel_email_address VARCHAR(45) NULL,
  hotel_website VARCHAR(45) NULL,
  hotel_description VARCHAR(100) NULL,
  hotel_floor_count INT NULL,
  hotel_room_capacity INT NULL,
  hotel_chain_id INT NULL,
  addresses_address_id INT NOT NULL,
  star_ratings_star_rating INT NOT NULL,
  check_in_time TIME NULL,
  check_out_time TIME NULL,
  PRIMARY KEY (hotel_id),
  CONSTRAINT fk_hotels_addresses1
    FOREIGN KEY (addresses_address_id)
    REFERENCES addresses (address_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_hotel_star_ratings1
    FOREIGN KEY (star_ratings_star_rating)
    REFERENCES star_ratings (star_rating)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
GO
-- -----------------------------------------------------
-- Table room_type
-- -----------------------------------------------------
DROP TABLE IF EXISTS room_type ;

CREATE TABLE  room_type (
  room_type_id INT NOT NULL,
  room_type_name VARCHAR(45) NULL,
  room_cost DECIMAL(10,2) NULL,
  room_type_description VARCHAR(100) NULL,
  smoke_friendly bit NULL,
  pet_friendly BIT NULL,
  PRIMARY KEY (room_type_id))
GO
-- -----------------------------------------------------
-- Table rooms
-- -----------------------------------------------------
DROP TABLE IF EXISTS rooms ;

CREATE TABLE rooms (
  room_id INT NOT NULL,
  room_number INT NULL,
  rooms_type_rooms_type_id INT NOT NULL,
  hotel_hotel_id INT NOT NULL,
  PRIMARY KEY (room_id),
  CONSTRAINT fk_rooms_rooms_type1
    FOREIGN KEY (rooms_type_rooms_type_id)
    REFERENCES room_type (room_type_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_rooms_hotel1
    FOREIGN KEY (hotel_hotel_id)
    REFERENCES hotel (hotel_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
GO
-- -----------------------------------------------------
-- Table guests
-- -----------------------------------------------------
DROP TABLE IF EXISTS guests ;

CREATE TABLE guests (
  guest_id INT NOT NULL,
  guest_first_name VARCHAR(45) NULL,
  guest_last_name VARCHAR(45) NULL,
  guest_contact_number VARCHAR(12) NULL,
  guest_email_address VARCHAR(45) NULL,
  guest_credit_card VARCHAR(45) NULL,
  addresses_address_id INT NOT NULL,
  PRIMARY KEY (guest_id),
  CONSTRAINT fk_guests_addresses1
    FOREIGN KEY (addresses_address_id)
    REFERENCES addresses (address_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
GO
-- -----------------------------------------------------
-- Table department
-- -----------------------------------------------------
DROP TABLE IF EXISTS department ;

CREATE TABLE department (
  department_id INT NOT NULL,
  department_name VARCHAR(45) NULL,
  department_description VARCHAR(100) NULL,
  PRIMARY KEY (department_id))
 GO
-- -----------------------------------------------------
-- Table employees
-- -----------------------------------------------------
 DROP TABLE IF EXISTS employees ;

CREATE TABLE employees (
  emp_id INT NOT NULL,
  emp_first_name VARCHAR(45) NULL,
  emp_last_name VARCHAR(45) NULL,
  emp_designation VARCHAR(45) NULL,
  emp_contact_number VARCHAR(12) NULL,
  emp_email_address VARCHAR(45) NULL,
  department_department_id INT NOT NULL,
  addresses_address_id INT NOT NULL,
  hotel_hotel_id INT NOT NULL,
  PRIMARY KEY (emp_id),
  CONSTRAINT fk_employees_services1
    FOREIGN KEY (department_department_id)
    REFERENCES department (department_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_employees_addresses1
    FOREIGN KEY (addresses_address_id)
    REFERENCES addresses (address_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_employees_hotel1
    FOREIGN KEY (hotel_hotel_id)
    REFERENCES hotel (hotel_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
GO
-- -----------------------------------------------------
-- Table bookings
-- -----------------------------------------------------
DROP TABLE IF EXISTS bookings ;

CREATE TABLE bookings (
  booking_id INT NOT NULL,
  booking_date DATETIME NULL,
  duration_of_stay VARCHAR(10) NULL,
  check_in_date DATETIME NULL,
  check_out_date DATETIME NULL,
  booking_payment_type VARCHAR(45) NULL,
  total_rooms_booked INT NULL,
  hotel_hotel_id INT NOT NULL,
  guests_guest_id INT NOT NULL,
  employees_emp_id INT NOT NULL,
  total_amount DECIMAL(10,2) NULL,
  PRIMARY KEY (booking_id),
  CONSTRAINT fk_bookings_hotel1
    FOREIGN KEY (hotel_hotel_id)
    REFERENCES hotel (hotel_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_bookings_guests1
    FOREIGN KEY (guests_guest_id)
    REFERENCES guests (guest_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_bookings_employees1
    FOREIGN KEY (employees_emp_id )
    REFERENCES employees (emp_id )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
GO
-- -----------------------------------------------------
-- Table hotel_chain_has_hotel
-- -----------------------------------------------------
DROP TABLE IF EXISTS hotel_chain_has_hotel ;

CREATE TABLE hotel_chain_has_hotel (
  hotel_chains_hotel_chain_id INT NOT NULL,
  
  hotels_hotel_id INT NOT NULL,
  CONSTRAINT fk_hotel_chains_has_hotels_hotel_chains1
    FOREIGN KEY (hotel_chains_hotel_chain_id)
    REFERENCES hotel_chain (hotel_chain_id )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_hotel_chains_has_hotels_hotels1
    FOREIGN KEY (hotels_hotel_id)
    REFERENCES hotel (hotel_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
GO
-- -----------------------------------------------------
-- Table room_rate_discount
-- -----------------------------------------------------
DROP TABLE IF EXISTS room_rate_discount ;

CREATE TABLE room_rate_discount (
  discount_id INT NOT NULL,
  discount_rate DECIMAL(10,2) NULL,
  start_month Int NULL,
  end_month int NULL,
  room_type_room_type_id INT NOT NULL,
  PRIMARY KEY (discount_id),
  CONSTRAINT fk_room_rate_discount_room_type1
    FOREIGN KEY (room_type_room_type_id)
    REFERENCES room_type (room_type_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
GO
-- -----------------------------------------------------
-- Table rooms_booked
-- -----------------------------------------------------
DROP TABLE IF EXISTS rooms_booked ;

CREATE TABLE rooms_booked (
  rooms_booked_id INT NOT NULL,
  bookings_booking_id INT NOT NULL,
  rooms_room_id INT NOT NULL,
  PRIMARY KEY (rooms_booked_id),
  CONSTRAINT fk_rooms_booked_bookings1
    FOREIGN KEY (bookings_booking_id)
    REFERENCES bookings (booking_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_rooms_booked_rooms1
    FOREIGN KEY (rooms_room_id)
    REFERENCES rooms (room_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
GO
-- -----------------------------------------------------
-- Table hotel_services
-- -----------------------------------------------------
DROP TABLE IF EXISTS hotel_services ;

CREATE TABLE hotel_services (
  service_id INT NOT NULL,
  service_name VARCHAR(45) NULL,
  service_description VARCHAR(100) NULL,
  service_cost DECIMAL(10,2) NULL,
  hotel_hotel_id INT NOT NULL,
  PRIMARY KEY (service_id),
  CONSTRAINT fk_hotel_services_hotel1
    FOREIGN KEY (hotel_hotel_id)
    REFERENCES hotel (hotel_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
GO
-- -----------------------------------------------------
-- Table hotel_services_used_by_guests
-- -----------------------------------------------------
DROP TABLE IF EXISTS hotel_services_used_by_guests ;

CREATE TABLE hotel_services_used_by_guests (
  service_used_id INT NOT NULL,
  hotel_services_service_id INT NOT NULL,
  bookings_booking_id INT NOT NULL,
  PRIMARY KEY (service_used_id),
  CONSTRAINT fk_hotel_services_has_bookings_hotel_services1
    FOREIGN KEY (hotel_services_service_id)
    REFERENCES hotel_services (service_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_hotel_services_has_bookings_bookings1
    FOREIGN KEY (bookings_booking_id)
    REFERENCES bookings (booking_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
GO
-- -----------------------------------------------------
-- Insert Data
-- -----------------------------------------------------
INSERT INTO addresses(address_id, address_line1, address_line2, city, state, country, zipcode)
VALUES 
	 (1,49, 'Dave Street', 'Kitchener','ON','Canada','N2C 2P6'),
	 (2,64, 'Victoria Street', 'Kitchener','ON','Canada','N2C 2M6'),
	 (3,79, 'Connaught Street', 'London','ON','Canada','N2C 2K3'),
	 (4,45, 'Sweden St. Street', 'London','ON','Canada','N2A 0E4'),
	 (5,60, 'Lincoln Street', 'Guelph','ON','Canada','N2C 2E8'),
	 (6,20400, 'Phoenix', NULL,'AZ','USA','AZ85027'),
	 (7,8033, 'King George Boulevard', 'Surrey','BC','Canada','V3W 5B4'),
	 (8,1565, 'E South St', 'Globe','AZ','USA','85501'),
	 (9,32, ' Gandhi Road', 'Mumbai','Maharashtra','India','534076'),
	 (10,706, 'Idle rd', 'Saskatoon','SK','Bangladesh','S2L 562'),
	 (11,45, 'Vanier Park', 'Kitchener','ON','Canada','Sd3 d35'),
	 (12,41, 'Greenfield', 'London','ON','Canada','234 987'),
	 (13,89, 'Jacob Rd', 'Paris','ON','Canada','467 289'),
	 (14,85, 'Martin Street', 'Ottawa','BC','Canada','263 987'),
	 (15,78, 'Josseph St. Street', 'Guelph','BC','Canada','267 387'),
	 (16,156, 'James Road', NULL,'AZ','USA','263 762'),
	 (17,7598, 'Atomic Street', 'Ottawa','New York','USA','756 145'),
	 (18,5476, 'Saint Jake Rd', 'NULL','San Jose','USA','675 846'),
	 (19,7465, 'Thames Rd', 'NUll','Gujarat','India','145 895');
GO 
-- insert into star ratings table
INSERT INTO star_ratings(star_rating) 
VALUES
	(1),
	(2),
	(3),
	(4),
	(5);
GO 
INSERT INTO department(department_id, department_name, department_description)
VALUES
	(1,'Kitchen','cooking'),
	(2,'Cleaning','sweep and mop'),
	(3,'Front Staff','handle bookings and query resolution'),
	(4,'Management','handles customer and resolve complaints'),
	(5,'Commute','pick up and drop');
GO 
INSERT INTO room_type(room_type_id, room_type_name, room_cost, room_type_description, smoke_friendly, pet_friendly)
 VALUES 
	(1, 'Standard Room','103','1 King Bed 323-sq-foot (30-sq-meter) room with city views',0,1),
	(2, 'Standard Twin Room','123','Two Twin Bed 323-sq-foot (30-sq-meter) room with city views',1,1),
	(3, 'Executive Room','130','1 King Bed 323-sq-foot (30-sq-meter) room with city views',0,0),
	(4, 'Club Room','159','2 King Bed 323-sq-foot (30-sq-meter) room with city views',1,1);
GO 
INSERT INTO guests(guest_id, guest_first_name, guest_last_name, guest_contact_number, guest_email_address, guest_credit_card, addresses_address_id)
VALUES 
	(1,'Jane','Doe','132-456-8564','jane.doe@gmail.com',NULL,1),
	(2,'Jerry','Thachter','564-896-4752','jerry.ytsvg@gmail.com',NULL,2),
	(3,'Rihanna','Perry','745-986-7451','rih.vfdj89@gmail.com',NULL,3),
	(4,'Mathew','Jose','489-624-8633','mathew.jose@gmail.com',NULL,4),
	(5,'Jessica','Smith','487-956-8963','jess.smith@gmail.com',NULL,5);
GO 
INSERT INTO room_rate_discount(discount_id, discount_rate, start_month, end_month, room_type_room_type_id)
 VALUES
	(1,50,1,3,1),
	(2,15,6,8,1),
	(3,15,9,12,1),
	(4,0,4,6,1);
GO 
INSERT INTO hotel_chain(hotel_chain_id, hotel_chain_name, hotel_chain_contact_number, hotel_chain_email_address, hotel_chain_website, hotel_chain_head_office_address_id) 
VALUES
	(1,'Best Western Hotels','456-865-8956','bw123@gmail.com','https://www.bestwestern.com/',6),
	(2,'China Town Hotels','110-526-5647','chinatown123@gmail.com','https://www.chinatown.com/',16),
	(3,'Elite Hotels','546-874-6547','elite.tea213@gmail.com','https://www.elitendhe.com/',17),
	(4,'Cosmopolitan Hotels','852-741-9765','cosmo.hotels123@gmail.com','https://www.cosmopolitan.com/',18),
	(5,'Prestige Hotels','657-784-3647','prestige2453@gmail.com','https://www.prestige.com/',19);
GO 
INSERT INTO hotel(hotel_id, hotel_name, hotel_contact_number, hotel_email_address, hotel_website, hotel_description, hotel_floor_count, hotel_room_capacity, hotel_chain_id, addresses_address_id, star_ratings_star_rating, check_in_time, check_out_time)
	VALUES 
		(1,'King George Inn & Suites','604-502-9564','kgi123@gmail.com','https://www.kgi123.com/','A 2-mile drive from Besh Ba Gowah Archaeological Park.',5,45,1,7,4,'12:00:00','23:00:00'),
		(2,'Copper Hills Inn','547-964-9564','chinni123@gmail.com','https://www.chin23.com/','A 2-mile drive from Besh Ba Gowah Archaeological Park.',6,55,1,8,5,'12:00:00','23:00:00'),
		(3,'Sawmill Inn','547-964-3452','sawmill.inn@gmail.com','https://www.chin23.com/','A 3-mile drive from Fairview Park.',4,50,1,9,5,'12:00:00','23:00:00'),
		(4,'Northgate Inn','547-876-5422','northgate.inn@gmail.com','https://www.chin23.com/','A 4-mile drive from Conestoga Mall',3,40,1,10,5,'12:00:00','23:00:00');
GO 		
	
INSERT INTO rooms(room_id, room_number, rooms_type_rooms_type_id, hotel_hotel_id)
 VALUES 
	(1,1101,1,1),
	(2,1102,1,1),
	(3,1103,1,1),
	(4,1104,1,1),
	(5,1105,1,1),
	(6,1106,1,1),
	(7,1107,1,1),
	(8,1108,1,1),
	(9,1109,1,1),
	(10,1110,1,1),
	(11,1111,1,1),
	(12,1112,1,1),
	(13,1113,1,1),
	(14,1114,1,1),
	(15,1115,1,1),
	(16,1116,1,1),
	(17,1117,2,1),
	(18,1118,2,1),
	(19,1119,2,1),
	(20,1120,2,1),
	(21,1121,2,1),
	(22,1122,2,1),
	(23,1123,2,1),
	(24,1124,2,1),
	(25,1125,2,1),
	(26,1126,2,1),
	(27,1127,2,1),
	(28,1128,2,1),
	(29,1129,2,1),
	(30,1130,2,1),
	(31,1131,2,1),
	(32,1132,2,1),
	(33,1133,2,1),
	(34,1134,2,1),
	(35,1135,2,1);
GO 
INSERT INTO hotel_services(service_id, service_name, service_description, service_cost, hotel_hotel_id)
 VALUES
	(1,'24-hour Room Service','There will be 24-hour Room Service to take care of customers needs',20,1),
	(2,'Currency Exchange','Foreign Currency Exchange facility available',80,1),
	(3,'Laundry','Laundry/Dry Cleaning available same day',10,1),
	(4,'Entertainment Room','Book and watch movies',50,2),
	(5,'Swimming Pool','Pool access to all the guests',100,2),
	(6,'Gym','24 Hour Gym',140,2);
GO 
INSERT INTO employees(emp_id, emp_first_name, emp_last_name, emp_designation, emp_contact_number, emp_email_address, department_department_id, addresses_address_id, hotel_hotel_id)
 VALUES 
 (1,'Jen','Fen','Waiter','123-789-7896','jen.rds@gmail.com',1,11,1),
 (2,'Tom','Pitt','Manager','565-789-7896','tom.pit@gmail.com',3,12,1),
 (3,'David','Lawrence','Cashier','852-789-7896','david.lawr@gmail.com',2,13,1),
 (4,'Joseph','Aniston','Cook','765-789-7896','joseph.anis@gmail.com',2,14,1),
 (5,'Jeny','Patel','Manager','531-789-7896','jeny.patel@gmail.com',3,15,1);
GO 
INSERT INTO hotel_chain_has_hotel(hotel_chains_hotel_chain_id, hotels_hotel_id)
 VALUES
 (1,1),
 (1,2),
 (1,3),
 (1,4),
 (2,3),
 (2,4);
GO 
INSERT INTO bookings (booking_id, booking_date, duration_of_stay, check_in_date, check_out_date, booking_payment_type, total_rooms_booked, hotel_hotel_id, guests_guest_id, employees_emp_id, total_amount)
 VALUES
	('1', '2018-08-08 00:00:00', '5', '2018-08-10 12:00:00', '2018-08-15 23:00:00', 'cash', '1', '1', '1', '3', '290'),
	('2', '2018-06-08 00:00:00', '20', '2018-06-08 12:00:00', '2018-06-28 23:00:00', 'card', '1', '1', '2', '1', '2300'),
	('3', '2018-06-08 00:00:00', '10', '2018-06-08 12:00:00', '2018-06-18 23:00:00', 'card', '1', '1', '1', '3', '1100'),
	('4', '2018-06-08 00:00:00', '2', '2018-06-08 12:00:00', '2018-06-10 23:00:00', 'card', '1', '1', '4', '1', '290'),
	('5', '2018-06-08 00:00:00', '3', '2018-06-08 12:00:00', '2018-06-11 23:00:00', 'card', '1', '1', '2', '3', '350'),
	('6', '2018-06-08 00:00:00', '5', '2018-06-08 12:00:00', '2018-06-13 23:00:00', 'card', '1', '1', '3', '3', '570'),
	('7', '2018-08-13 00:00:00', '2', '2018-06-13 12:00:00', '2018-06-15 23:00:00', 'cash', '2', '1', '5', '4', '280'),
	('8', '2018-08-10 00:00:00', '3', '2018-08-11 12:00:00', '2018-08-13 23:00:00', 'card', '1', '1', '3', '3', '350'),
	('9', '2018-08-10 00:00:00', '5', '2018-08-12 12:00:00', '2018-08-16 23:00:00', 'card', '1', '1', '4', '3', '570'),
	('10', '2018-08-14 00:00:00', '2', '2018-08-15 12:00:00', '2018-08-17 23:00:00', 'cash', '2', '1', '5', '4', '280'),
	('11', '2018-08-14 00:00:00', '5', '2018-08-16 12:00:00', '2018-08-21 23:00:00', 'cash', '1', '1', '1', '3', '590'),
	('12', '2018-08-14 00:00:00', '20', '2018-08-17 12:00:00', '2018-09-07 23:00:00', 'card', '1', '1', '2', '1', '2300'),
	('13', '2018-08-14 00:00:00', '10', '2018-08-15 12:00:00', '2018-08-25 23:00:00', 'card', '1', '1', '1', '3', '1100'),
	('14', '2018-08-14 00:00:00', '2', '2018-08-16 12:00:00', '2018-08-18 23:00:00', 'card', '2', '1', '4', '1', '290'),
	('15', '2018-08-14 00:00:00', '3', '2018-08-17 12:00:00', '2018-08-20 23:00:00', 'card', '3', '1', '2', '3', '350');
GO
INSERT INTO rooms_booked (rooms_booked_id, bookings_booking_id, rooms_room_id) 
VALUES 
('1', '1', '1'),
('2', '2', '2'),
('3', '2', '3'),
('4', '2', '4'),
('5', '2', '5'),
('6', '2', '6'),
('7', '7', '7'),
('8', '7', '8'),
('9', '6', '9'),
('10','8','10'),
('11','9','11'),
('12','10','12'),
('13','10','13'),
('14', '11', '14'),
('15', '12', '15'),
('16', '13', '16'),
('17', '14', '17'),
('18', '14', '18'),
('19', '15', '19'),
('20', '15', '20'),
('21', '15', '21');
GO 
INSERT INTO hotel_services_used_by_guests (service_used_id, hotel_services_service_id, bookings_booking_id) 
VALUES ('1', '1', '2'),
 ('2', '2', '2'),
 ('3', '3', '2');
 GO
 -- -----------------------------------------------------
-- For revenue to exceed depreciation expense, the total amount >= 200
-- Trigger not to insert total amount < 200
-- -----------------------------------------------------
DROP TRIGGER dbo.check_total_amount
GO
CREATE TRIGGER check_total_amount
ON dbo.bookings
FOR INSERT
AS
BEGIN
 DECLARE @count INT = 0
 select @count = COUNT(*) FROM Inserted, dbo.bookings
 WHERE Inserted.total_amount < 200
 IF (@count > 0)
	BEGIN
		PRINT 'Cant insert tenant with total amount < 200'
		ROLLBACK TRAN
	 END 
END
-- Example-----
INSERT INTO bookings (booking_id, booking_date, duration_of_stay, check_in_date, check_out_date, booking_payment_type, total_rooms_booked, hotel_hotel_id, guests_guest_id, employees_emp_id, total_amount)
 VALUES
	('16', '2018-08-08 00:00:00', '5', '2018-08-10 12:00:00', '2018-08-15 23:00:00', 'cash', '1', '1', '1', '3', '190')
-- -----------------------------------------------------
-- Customers with total money > average total amount are VIP Customers
-- Trigger not to delete the VIP Customers
-- -----------------------------------------------------
GO
Create trigger  VIP_customer
ON dbo.bookings
FOR delete
AS
BEGIN
 DECLARE @count2 INT = 0
 select @count2 = COUNT(*) FROM Deleted
GROUP BY Deleted.total_amount
HAVING Deleted.total_amount > (SELECT AVG(total_amount)  FROM dbo.bookings)
 IF (@count2 > 0)
	BEGIN
		PRINT 'Cant delete VIP customer'
		ROLLBACK TRAN
	 END 
END
---- example for delete trigger---------------
GO
SELECT * FROM dbo.bookings
go
INSERT INTO bookings (booking_id, booking_date, duration_of_stay, check_in_date, check_out_date, booking_payment_type, total_rooms_booked, hotel_hotel_id, guests_guest_id, employees_emp_id, total_amount)
 VALUES
	('20', '2018-08-09 00:00:00', '5', '2018-08-9 12:00:00', '2018-08-16 23:00:00', 'cash', '1', '2', '3', '3', '220'),
	('21', '2018-08-08 00:00:00', '5', '2018-08-10 12:00:00', '2018-08-15 23:00:00', 'cash', '1', '1', '1', '3', '1000')
GO 
delete FROM dbo.bookings 
WHERE booking_id = 20
GO 
delete FROM dbo.bookings 
WHERE booking_id = 21
GO
 -- create view named hotel_employees to get details of all the employees
 GO 
CREATE VIEW hotel_employees AS
	SELECT emp_first_name AS 'First Name', emp_last_name AS 'Last Name', emp_email_address AS 'Email Address', emp_contact_number AS 'Contact Number', department_name AS 'Department'
	FROM employees
	JOIN department
	ON department.department_id = employees.department_department_id;
GO 
SELECT * FROM hotel_employees
-- create view named hotel_guests to get details of the guests
GO 
CREATE VIEW hotel_guests AS
SELECT guest_first_name AS 'First Name', guest_last_name AS 'Last Name', guest_email_address AS 'Email Address', guest_contact_number AS 'Contact Number',Country,state,Zipcode
FROM guests
JOIN addresses ON addresses.address_id = guests.addresses_address_id
WHERE guests.guest_id IN
		(SELECT distinct guests_guest_id 		-- get distinct guests
		FROM bookings
		WHERE hotel_hotel_id = 1);				-- for hotel(King George Inn & Suites) with id 1 
GO
SELECT * FROM hotel_guests
-----------------------------------------------------
GO
-- How many distinct guest have made bookings for a particular month?
	SELECT guest_first_name, guest_last_name,guest_contact_number
	FROM guests
	WHERE guest_id IN 
		( SELECT distinct guests_guest_id 		-- get distinct guests
		  FROM bookings
		  WHERE MONTH(check_in_date) = 8);		-- bookings for the month of August
	
-- How many total rooms, total room booked, available rooms are in a particular hotel for a given date?
	GO 
	SELECT hotel_room_capacity AS 'Total Rooms', SUM(total_rooms_booked) AS 'Total Rooms Booked' , hotel_room_capacity - SUM(total_rooms_booked) 	AS 'Available Rooms'	-- get available rooms
	FROM dbo.bookings JOIN hotel
    	ON hotel_hotel_id = hotel_id
	WHERE booking_date = '2018-08-14' AND hotel_hotel_id = 1	-- for given date and for hotel(King George Inn & Suites) with id 1 
	GROUP BY hotel_room_capacity

-- How many hotels are in a hotel chain?
	SELECT count(*) AS 'Total Hotels' 		-- count of total hotels
	FROM hotel_chain_has_hotel 
	WHERE hotel_chains_hotel_chain_id = 1;  -- for hotel chain 'best western hotels'
	
-- How many books has a customer made in one year?
	SELECT count(*) AS 'Total Bookings' 		-- count of total bookings 		
	FROM bookings
	WHERE YEAR(booking_date) = 2018 AND guests_guest_id = 1;		-- bookings in Year 2018 by guest Jane with id 1
	
-- How many rooms are booked in a particular hotel on a given date?
	SELECT SUM(total_rooms_booked) AS 'Total Rooms Booked' 		-- sum of total rooms
	FROM bookings
	WHERE booking_date = '2018-06-08' AND hotel_hotel_id = 1;	-- for date 6th August,2018; and for hotel(King George Inn & Suites) with id 1 

-- List all the unique countries hotels are located in.
	SELECT DISTINCT country					-- unique countries
	FROM addresses
	WHERE address_id IN 					-- compare to get addresses of hotels
		( SELECT  addresses_address_id		-- address id of hotels
		  FROM hotel);
	
	
-- How many rooms are available in a given hotel?
	SELECT hotel_room_capacity - SUM(total_rooms_booked) 	AS 'Available Rooms'	-- get available rooms
	FROM bookings JOIN hotel
    	ON hotel_hotel_id = hotel_id
	WHERE booking_date = '2018-06-08' AND hotel_hotel_id = 1	-- for given date and for hotel(King George Inn & Suites) with id 1 
	GROUP BY hotel_room_capacity

-- List all the hotels that have a URL available.
GO
	SELECT * FROM hotel
	WHERE hotel_website IS NOT NULL;	-- get the hotels whose URL is not null
GO 
-- List the rate for a room at a given time during the year.
	SELECT ROUND((room_cost - ((discount_rate * room_cost)/100)), 2) AS 'Room Rate' -- get room price on the basis od discount
	FROM room_rate_discount JOIN room_type		-- join rate discount table with room type
	ON room_type_room_type_id = room_type_id
    WHERE room_type_id 
	IN ( Select rooms_type_rooms_type_id from rooms where room_id = 1)	-- get room type id for room with id 1
    AND MONTH('2023-06-03') BETWEEN start_month AND end_month;		-- get discount rate for current month



		
