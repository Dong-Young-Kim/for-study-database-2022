
USE `car_dealer` ;


show variables like '%isolation%';


start transaction;


commit;

select * from user;

show tables;

select * from user;

select * from user, salesperson, customer where uid = ssn or uid = sid;

select uid, name from user, salesperson where uid = sid
union
select uid, name from user, customer where uid = ssn;

select uid, name, sid from user, salesperson where uid = sid and uid=10001
      union
      select uid, name, ssn from user, customer where uid = ssn and uid=10001;
      
      
select name, count(vin), min(price) from model left join vehicle on model.mid = vehicle.mid group by name;

select * from model;
select * from vehicle;

delete from vehicle where vin > 10000;

create view stockModel as select name, count(vin) as stock, min(price) as min_price from model left join vehicle on model.mid = vehicle.mid group by name;

select * from stockModel;

drop view stockModel;

show tables;

select vin, name, price, ssn from vehicle, model where vehicle.mid = model.mid ;
select vin, name, model.mid, price, ssn as rsrv_cusomer from vehicle, model where vehicle.mid = model.mid ;

INSERT INTO `car_dealer`.`Vehicle` (`Vin`, `Mid`, `Price`, `Ssn`) VALUES (100000, 10001, 18200, NULL);

CREATE VIEW stockModel AS 
SELECT NAME, COUNT(Vin) AS STOCK, MIN(PRICE) AS MIN_PRICE 
FROM MODEL LEFT JOIN VEHICLE ON MODEL.MID = VEHICLE.MID 
WHERE VEHICLE.Ssn IS NULL 
GROUP BY NAME;

update vehicle
set ssn = 10005
where vin = (select vin from model, vehicle where vehicle.mid = model.mid and model.name='FH16' and ssn is null order by price limit 1);
