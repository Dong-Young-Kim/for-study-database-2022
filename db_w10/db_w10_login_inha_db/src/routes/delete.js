import express from "express";
import { selectSql, deleteSql } from "../database/sql";

const router = express.Router();

//기존의 입력 값 불러오기
router.get('/', async(req, res) =>{
    const sign_up = await selectSql.getClass();

    res.render('delete', {
        title: "삭제 기능",
        sign_up
    })
});

//삭제 버튼을 눌렀을경우 update query를 실행하며 조회 페이지로 이동
router.post('/', async (req,res) => {
    console.log('delete router:', req.body.delBtn);

    const [sid_, cid_] = (req.body.delBtn).split(' ');

    const data = {
        sid: sid_,
        cid: cid_
    };
    // console.log(data.cid);
    // console.log(data.sid);

    await deleteSql.deleteSignUp(data);

    res.redirect('/delete');
});

module.exports = router;