show databases;

use ex_db1;

-- default is reapeatable-read
show variables like '%isolation%';

show variables;
show variables like '%safe_updates%';

select * from t1;
desc t1;

-- update/delete where id not key
set sql_safe_updates=1;

start transaction;
commit;

insert into t1
values (6, 'six');

update t1
set name='yuk'
where t1.id = 6;

delete from t1
where id=6;