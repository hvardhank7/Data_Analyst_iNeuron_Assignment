use task;
create table factbook(
id int ,
`code` varchar(20),
Country varchar(60)	,
Total_area int,
Area_land int,
Area_water int,
Population int,
population_growth decimal(38,2),
birth_rate decimal(38,2),
death_rate decimal(38,2),
migration_rate decimal(38,2)
);
desc factbook;
drop table factbook;

LOAD DATA INFILE
'E:/iNeuron/Assignment/SQL/Factbook/Factbook1.csv'
INTO TABLE factbook
FIELDS TERMINATED BY ','
ENCLOSED BY ""
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


select * from factbook;

---Which country has the highest population?---
select Country from factbook where Population=(select max(Population) from factbook);

---Which country has the least number of people?---
select Country from factbook where Population=(select min(Population) from factbook);

---Which country is witnessing the highest population growth?---
select Country from factbook where population_growth=(select max(population_growth) from factbook);

---Which is the most densely populated country in the world?---
SELECT Country, Population, Total_area
FROM factbook
WHERE Population > (SELECT Round(AVG(Population),0) FROM factbook)
AND Total_area < (SELECT Round(AVG(Total_area),0) FROM factbook)
ORDER BY Population DESC LIMIT 1;

