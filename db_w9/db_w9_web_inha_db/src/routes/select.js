import express from 'express';
import {selectSql} from '../database/sql';

const router = express.Router();

router.get('/', async (_req, res) => {
    const building = await selectSql.getBuilding();
    const room = await selectSql.getRoom();
    const department = await selectSql.getDepartment();
    const class_ = await selectSql.getClass();
    const student = await selectSql.getStudent();
    const club = await selectSql.getClub();
    const employee = await selectSql.getEmployee();

    
    res.render('select', {
        title1: '건물 테이블',
        title2: '교실 테이블',
        title3: '학과 테이블',
        title4: '수업 테이블',
        title5: '학생 테이블',
        title6: '클럽 테이블',
        title7: '직원 테이블',
        building,
        room,
        department,
        class_,
        student,
        club,
        employee
    })
})

module.exports = router;