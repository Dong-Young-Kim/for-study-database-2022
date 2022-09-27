USE `week5_company_db` ;

-- week5 실습
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM project;


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


(select	distinct pnumber
from	employee, project, department
where	Lname='Smith' and
		project.Dnum=dnumber and
		mgr_ssn=ssn)
union
(select	distinct pnumber
from 	project, employee, department
where	Lname='Smith' and
		dnum=dnumber);

select	Fname, Lname, Address
from	employee
where	Address like '%Houston TX%';
        
select	Fname, Lname, Bdate
from	employee
where	Bdate like '196_-__-__';		




