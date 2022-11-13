import express from "express";
import { selectSql } from "../database/sql";

const router = express.Router();

router.get('/', (req, res) => {
    res.render('login');
});

router.post('/', async (req, res) => {
    const vars = req.body;
    const users = await selectSql.getUsers();
    let whoAmI = '';
    let checkLogin = false;
    users.map((user)=> {
        //console.log(user.s_password);
        if(vars.id == user.student_id && vars.password == user.s_password){
            console.log('login success!');
            console.log(user.student_id);
            console.log(typeof(user.student_id));
            checkLogin = true;

            if(vars.id == '10000000'){
                whoAmI = 'admin';
            } else {
                whoAmI = 'user';
            }
        }
    })
    if(checkLogin && whoAmI === 'admin'){
        res.redirect('/delete');
    } else if(checkLogin && whoAmI === 'user'){
        res.redirect('/select');
    } else {
        console.log('login failed!');
        res.send("<script>alert('로그인에 실패하였습니다.'); location.href='/';</script>");
    }
})

module.exports = router;