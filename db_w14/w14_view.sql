-- view

use inha_db;

select * from student;

create view 	login 
as select 		student_id, s_password
from 			student;

show tables;
desc login;
select * from login;

select * from class;

-- 일부 데이터만 공개 하는 경우, db에 익숙하지 않은 경우 사용
create view IT 
as select 	cid, cname, s_name as studentName, 
			concat(substring(s_email, 1, 1), reapeat('*', char_length(substring_index(s_email, "0", 1)-1)), right(s_email, 10)) as studentEmail
from class C inner join student
on C.did, S.major_did;

-- 편의 측면에서 사용

-- view 자체에서도 내용을 수정할 수 있음
-- 단 집계함수 없어야, group by 없어야, ...

-- 트랜잭션
