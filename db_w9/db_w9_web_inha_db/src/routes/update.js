import express from 'express';
import {selectSql, updateSql} from '../database/sql';

const router = express.Router();

router.get('/student', async (_req, res) => {
    const stu_res = await selectSql.getStudent();
    res.render('updateStudent', {
        title: '학생 테이블 갱신',
        stu_res,
    });
});
router.post('/student', async (req, res) => {
    const vars = req.body;
    const data = {
        //Sid: vars.sid,
        S_name: vars.s_name,
        S_email: vars.s_email,
        S_phonenumber: vars.s_phonenumber,
        Student_id: vars.student_id,
        Major_did: vars.major_did,
    }
    await updateSql.updateStudent(data);

    res.redirect('/update/student');
})

module.exports = router;