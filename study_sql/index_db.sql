-- for stydy sql <221022>

show databases;

use ex_db1;

show tables;

select * from t3;

select count(distinct id) from t1;
select count(*) from t1;
select * from t1;

-- -----------------------------------------------
CREATE SCHEMA IF NOT EXISTS `week9_index_db` DEFAULT CHARACTER SET utf8 ;
use week9_index_db;

CREATE TABLE EMPLOYEE
( Fname           VARCHAR(10)   NOT NULL,
  Minit           CHAR,
  Lname           VARCHAR(20)      NOT NULL,
  Ssn             CHAR(9)          NOT NULL,
  Bdate           DATE,
  Address         VARCHAR(30),
  Sex             CHAR(1),
  Salary          DECIMAL(5),
  Super_ssn       CHAR(9),
  Dno             INT               NOT NULL,
PRIMARY KEY   (Ssn));

select count(*) from employee;

show index from employee;


