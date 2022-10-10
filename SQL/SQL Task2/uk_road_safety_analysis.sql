/* Create Tables */
drop database test2;
create database test2;
use test2;
CREATE TABLE accident(
	accident_index VARCHAR(50),
    accident_severity integer
);

CREATE TABLE vehicles(
	accident_index VARCHAR(50),
    vehicle_code integer
);

/* First: for vehicle types, create new csv by extracting data from Vehicle Type sheet from Road-Accident-Safety-Data-Guide.xls */
CREATE TABLE vehicle_types(
	vehicle_code INT,
    vehicle_type VARCHAR(60)
);

LOAD DATA INFILE
'E:/iNeuron/Assignment/SQL/02.UK Road Safty Accidents 2015/datasets/Accidents_2015.csv'
INTO TABLE accident
FIELDS TERMINATED BY ','
ENCLOSED BY ""
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@col1, @dummy, @dummy, @dummy, @dummy, @dummy, @col2, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
SET accident_index=@col1, accident_severity=@col2;

select * from accident;

LOAD DATA INFILE 'E:/iNeuron/Assignment/SQL/02.UK Road Safty Accidents 2015/datasets/Vehicles_2015.csv'
INTO TABLE vehicles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@col1, @dummy, @col2, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
SET accident_index=@col1, vehicle_code=@col2;

select * from vehicles;

LOAD DATA INFILE 'E:/iNeuron/Assignment/SQL/UK Road Safty/vechile_code.csv'
INTO TABLE vehicle_types
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from vehicle_types;


#Evaluate Accident Severity and Total Accidents per Vehicle Type
select c.vehicle_type as Vehicle_Type,a.accident_severity as Severity,count(b.vehicle_code) as Total_Accident
from accident a
inner join vehicles b
on a.accident_index=b.accident_index
inner join vehicle_types c
on b.vehicle_code = c.vehicle_code
group by Vehicle_Type
order by Severity,Total_Accident;


#Calculate the Average Severity by vehicle type.
select c.vehicle_type as Vehicle_Type,round(avg(a.accident_severity),2) as Severity
from accident a
inner join vehicles b
on a.accident_index=b.accident_index
inner join vehicle_types c
on b.vehicle_code = c.vehicle_code
group by Vehicle_Type
order by Severity;

#Calculate the Average Severity and Total Accidents by Motorcycle.
select c.vehicle_type as Vehicle_Type,round(avg(a.accident_severity),2) as Severity,count(b.vehicle_code) as Total_Accident
from accident a
inner join vehicles b
on a.accident_index=b.accident_index
inner join vehicle_types c
on b.vehicle_code = c.vehicle_code
WHERE c.vehicle_type LIKE '%otorcycle%'
group by Vehicle_Type
order by Severity,Total_Accident;