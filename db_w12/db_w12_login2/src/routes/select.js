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

import express from "express";
// TODO
// sql import
import { selectSql, insertSql, deleteSql } from "../database/sql";

const router = express.Router();

router.get('/', async function (req, res) {
    // TODO
    // class 정보 불러오기
    const res_class = await selectSql.getClass();
    const signed_class = await selectSql.getSignUp(req.cookies.user);
    if (req.cookies.user) {
        const userName = await selectSql.getLoginUser(req.cookies.user);
        // TODO
        // 불러온 class 정보 같이 넘겨주기
        res.render('select', { 
            user: userName[0].s_name,
            res_class,
            signed_class
        });
    } else {
        res.render('/')
    }

});

//신청 버튼을 눌렀을경우 update query를 실행하며 조회 페이지로 이동
router.post('/', async (req,res) => {
    console.log('insert Value:', req.body.insertBtn);
    console.log('insert Value:', req.cookies.user);

    const data = {
        sid: req.cookies.user,
        cid: req.body.insertBtn
    };

    await insertSql.insertSignUp(data);

    res.redirect('/sugang');
});


module.exports = router;