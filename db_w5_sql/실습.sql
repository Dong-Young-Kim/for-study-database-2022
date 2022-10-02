USE `week5_company_db` ;

-- week5 실습

-- 기본 테이블 조회
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM project;
SELECT * FROM WORKS_ON;

-- 성이 ‘Borg’인 사원(들)의 전체 이름과 생년월일(Bdate)과 주소(Address)를 검색하라.
select	Fname, Lname, Bdate, Address
from	employee
where	Lname='Borg';

-- 릴레이션 EMPLOYEE와 DEPARTMENT의 카티션 곱을 검색하라.
select	*
from	employee, department;

-- 모든 사원들의 사번(SSN)과 그들이 속한 소속 부서(DNAME)들을 모두 검색하라.
select	Ssn, Dname
from	employee, department
where	Dno=Dnumber;

-- ᄋ‘Headquarters’ 부서에서 근무하는 모든 사원의 이름(Fname, Lname)과 주소(Address)를 검색하라.
select	Fname, Lname, Address
from	employee, department
where	Dname='Headquarters';

-- ‘Administration’부서에서 일하는 사원들의 성(Lname)과 이름(Fname), 그리고 관리자를 시작한 날(mgr_start_date)을 검색하라.
select	Lname, Fname, Mgr_start_date
from	employee, department
where	dno=dnumber and
		Dname='Administration';
    
-- [***]각 사원에 대해 사원의 이름(Fname)과 성(Lname), 직속 상사의 이름 (Fname)과 성(Lname)을 검색하라.
select	e.Fname as emp_Fname, e.Lname as emp_Lname, 
		s.Fname as super_Fname, s.Lname as super_Lname
from	employee as s, employee as e
where	e.Super_ssn = s.Ssn;
-- (e employee, s.super_ssn)

-- ‘Houston’에 위치한 모든 프로젝트에 대해서 프로젝트 번호(Pnumber), 담 당 부서 번호(Dnum), 부서 관리자의 성(Lname), 주소(Address), 생년월일 (Bdate)을 검색하라.
SELECT	Pnumber, Dnumber, Lname, Address, Bdate
FROM 	EMPLOYEE, PROJECT, DEPARTMENT
WHERE	Dnum=Dnumber and Mgr_ssn=Ssn and plocation='Houston';
-- DNUM=DNUMBER --> 프로젝트와 담당부서를 조인, MGR_SSN-SSN --> 부서와 담당자를 조인

-- 일반 사원이든 관리자이든 간에 성(Lname)이 'Smith'인 사원이 수행하는 프로젝트 번호(Pnumber)의 리스트를 검색하라. 
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

-- 주소에 'Houston TX‘가 포함되는 모든 사원(Fname, Lanme)을 검색하라.
select	Fname, Lname, Address
from	employee
where	Address like '%Houston TX%';

-- 1960년대 태어난 모든 사원의 전체 이름(Fname, Lname)을 검색하라.
select	Fname, Lname, Bdate
from	employee
where	Bdate like '196_-__-__';		




