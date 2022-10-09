CREATE SCHEMA IF NOT EXISTS `ex_db1` DEFAULT CHARACTER SET utf8 ;
USE `ex_db1` ;

-- index 삭제
create index t1_id_index on t1(id);

-- index 삭제
drop index t1_id_index on t1;

create table t3(id int, addr varchar(20), index t3_id_index(id));

create table t3(id int, addr varchar(20), key t3_id_index(id));

desc t3;
