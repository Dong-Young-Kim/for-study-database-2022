// Copyright 2021 kms
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//     http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import cookieParser from "cookie-parser";
import express from "express";
import expressSession from 'express-session';
import { selectSql } from "../database/sql";

const router = express.Router();

// 쿠키 및 세션 설정
router.use(cookieParser());
router.use(expressSession({
    secret: 'dnyg_cardealer',
    resave: true,
    saveUninitialized: true,
}))

// 로그인 한 user는 login 쿠키 값, 로그인 한 user가 아니면 login.hbs로
router.get('/', async (req, res) => {
    if (req.cookies.user) {
        const userInfo = await selectSql.getLoginUser(req.cookies.user);
        //console.log(userInfo.name)
        if(userInfo.type === 'salesPerson'){ //관리자 로그인
            res.redirect('/sal');
        } else if (userInfo.type === 'customer'){ //구매자 로그인
            res.redirect('/cus');
        } else {
            res.redirect('/logout'); //user id 확인 불가
        }
    } else {
        res.render('login');
    }
});

router.post('/', async (req, res) => {
    const vars = req.body;
    const users = await selectSql.getUsers();
    let whoAmI = '';
    let checkLogin = false;

    // map -> for loop | user[i] 에 대해서 차례로 접근
    users.map((user) => {
        if (String(vars.id) === String(user.id) && String(vars.password) === String(user.password)) {
            checkLogin = true;
            whoAmI = user.uid; //user의 id가 cookie값으로 
        }
    })
    console.log("login status: " + checkLogin)

    if (checkLogin) { // true 이면 쿠키 부여
        res.cookie('user', whoAmI, {
            expires: new Date(Date.now() + 3600000), // ms 단위 (3600000: 1시간 유효)
            httpOnly: true
        })
        console.log(`longin sucess (user = ${whoAmI})`)
        res.redirect('/');
    } else {
        console.log(`login falied (input id = ${vars.id})`)
        res.redirect('/');
    }
})

module.exports = router;