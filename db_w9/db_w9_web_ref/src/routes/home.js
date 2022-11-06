import express from 'express';
import {insertSql} from '../database/sql';

const router = express.Router();

router.get('/', (_req, res) => { //값을 넘길때 get(서버에서 값을 가져올떄), post(리턴 값)
    res.render('home'); //요청한 것에 대한 응답, home.hbs파일을 그래도 넘겨줌
})

router.post('/', (req, res) => {//값을 post로 던지는 경우 동작
    const vars = req.body;
    const var_length = Object.keys(req.body).length;

    if (var_length > 4) { //naive하게 변수 길이로 구분
        const data = { //html home에서 넘어온 값들
            Fname: vars.fname,
            Minit: vars.minit,
            Lname: vars.lname,
            Ssn: vars.ssn,
            Bdate: vars.bdate,
            Address: vars.address,
            Sex: vars.sex,
            Salary: vars.salary,
            Super_ssn: vars.superssn,
            Dno: vars.dno,
        };
        insertSql.setEmployee(data);
    } else {
        const data = {
            Dname: vars.dname,
            Dnumber: vars.dnumber,
            Mgr_ssn: vars.mgrssn,
            Mgr_start_date: vars.mgrstartdate,
        };
        insertSql.setDepartment(data);
    }
    res.redirect('/');
})

module.exports = router;