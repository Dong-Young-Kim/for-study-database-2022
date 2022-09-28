USE `week5_company_db` ;

-- week5 실습
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM project;
SELECT * FROM WORKS_ON;


select	Fname, Lname, Bdate, Address
from	employee
where	Lname='Borg';

select	*
from	employee, department;

select	Ssn, Dname
from	employee, department
where	Dno=Dnumber;

select	Fname, Lname, Address
from	employee, department
where	Dname='Headquarters';

select	Lname, Fname, Mgr_start_date
from	employee, department
where	dno=dnumber and
		Dname='administration';
    
select	e.Fname as emp_Fname, e.Lname as emp_Lname, 
		s.Fname as super_Fname, s.Lname as super_Lname
from	employee as s, employee as e
where	e.Super_ssn = s.Ssn;
-- e employee, s.super_ssn

SELECT	Pnumber, Dnumber, Lname, Address, Bdate
FROM 	EMPLOYEE, PROJECT, DEPARTMENT
WHERE	Dnum=Dnumber and Mgr_ssn=Ssn and plocation='Houston';

-- 일반 사원이든 관리자이든 간에 
-- 성(Lname)이 'Smith'인 사원이 수행하는 프로젝트 번호(Pnumber)의 리스트를 검색하라. 
-- (hint : union)
(-- 관리자
SELECT	DISTINCT PNUMBER
FROM	EMPLOYEE, DEPARTMENT, PROJECT
WHERE	DNUM=DNUMBER AND MGR_SSN=SSN AND Lname='Smith'
) union (-- 일반 사원
SELECT	DISTINCT PNUMBER
FROM 	PROJECT, WORKS_ON, EMPLOYEE
WHERE	SSN=ESSN AND PNUMBER=PNO AND Lname='Smith'
);

select	Fname, Lname, Address
from	employee
where	Address like '%Houston TX%';
        
select	Fname, Lname, Bdate
from	employee
where	Bdate like '196_-__-__';		




