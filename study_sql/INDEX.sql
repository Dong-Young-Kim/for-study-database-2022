CREATE SCHEMA IF NOT EXISTS `ex_db1` DEFAULT CHARACTER SET utf8 ;
USE `ex_db1` ;

-- t1, t2, t3 생성
create table t1(id int, name varchar(20));
create table t2(id int, title varchar(20));

insert into t1
values	(1, "one"),
		(2, "two"),
        (3, "three"),
        (NULL, "noname1"),
        (NULL, "noname2"),
        (NULL, NULL),
        (4, "four"),
        (5, "five");
        
insert into t2
values	(1, "one_2"),
		(2, "two_2"),
        (3, "three_2"),
        (NULL, "noname1_2");


desc t1;
desc t2;

select * from t1;
select * from t2;

select * from t1,t2;
-- -------------------------------------------------------------
-- join <퀴즈 1-1>
select	*
from	t1, t2
where	t1.id=t2.id;

select	*
from	t1 join t2
where	t1.id=t2.id;

-- natural join <퀴즈 1-2>
select	*
from	t1 natural join t2;

-- left join <퀴즈 1-3>
select	*
from	t1 left join t2
on	t1.id=t2.id;

-- left join <퀴즈 1-4>
select	*
from	t1 natural left join t2;

-- right join <퀴즈 1-5>
select	*
from	t1 right join t2
on		t1.id=t2.id;

-- right join <퀴즈 1-6>
select	*
from	t1 natural right join t2;

-- left join <퀴즈 1-7>
select	*
from	t1 left join t2
on		t1.id=t2.id
where	t1.id is not null;

-- left join <퀴즈 1-7>
select	*
from	t1 right join t2
on		t1.id=t2.id
where	t1.id is not null;

-- full join
(select	*
from	t1 natural left join t2)
union
(select	*
from	t1 natural right join t2);
-- -------------------------------------------------------------



-- in <퀴즈 2-1>
select	*
from 	t1
where 	id in(
	select 	id
    from	t2);
/*
t1의 id가 t2의 id 안에 있는지 확인
속성들이 1:1로 비교됨
t1의 table이 출력됨
*** null은 출력되지 않음 ***
joint와는 다르게 t2는 출력되지 않음
*/

-- not in <퀴즈2-2>
select	*
from	t1
where	id	not in(
	select	id
    from	t2);
/*
1. 1,2,3은 t2에 있으므로 출력되지 않음
2. 4,5는 t2 table에 null과 비교되어 출력되지 않음 (t2에 null이 없으면 4,5가 출력됨)
null이 한쪽에라도 있으면 비교되는 경우 unkouwn이 출력되어 false --> 출력x
*/

-- not in <퀴즈2-3>
select	*
from	t1
where	id	not in(
	select	id
    from	t2
    where id is not null);
/*
null을 항상 고려해야..
*** not in 철칙 : not in 뒤에 "is not null" 있어야
*/

-- exists <퀴즈2-4>
select	*
from	t1
where	exists (
	select	*
    from	t2);
-- t1이 몽땅 출력

-- exists <퀴즈2-5>
select	*
from	t1
where	exists (
	select id
    from	t2
    where	t1.id = t2.id);
/*
반드시 조건 포함
where 이 없으면 t1이 몽땅 출력됨
한쪽 table만 가져오므로 semi join
*/

-- not exists <퀴즈2-6>
select	*
from	t1
where	not exists (
	select	*
    from	t2
    where	t1.id = t2.id);
    
/*
1,2,3 -> t2에 존재하므로 출력되지 않음
4,5 -> t2에 존재하지 않으므로 출력됨
null -> 한쪽이 null이면 출력
*/
-- -------------------------------------------------------

-- index 삭제
create index t1_id_index on t1(id);

-- index 삭제
drop index t1_id_index on t1;

create table t3(id int, addr varchar(20), index t3_id_index(id));

create table t3(id int, addr varchar(20), key t3_id_index(id));

desc t3;
-- -------------------------------------------------------



