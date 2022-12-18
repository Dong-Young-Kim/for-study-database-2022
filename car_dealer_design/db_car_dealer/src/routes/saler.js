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
import { selectSql, insertSql, deleteSql, updateSql} from "../database/sql";

const router = express.Router();

router.get('/', async (req, res) => {
    if (req.cookies.user) {
        const userInfo = await selectSql.getLoginUser(req.cookies.user);
        if (userInfo.type === 'salesPerson'){ //관리자 로그인

            const all_vehicle = await selectSql.getVehicle();
            //const veh_model = await selectSql.getModel();
            const rsrv_vehicle = await selectSql.getAllRsrv();
            res.render('saler',{
                'userName': userInfo.name,
                'userType': userInfo.type,
                all_vehicle,
                rsrv_vehicle,
            });
        } else {
            res.redirect('/logout'); //user id 확인 불가
        }
    } else {
        res.render('login');
    }
});

router.post('/input', async (req, res) => {
    if (req.cookies.user) {
        const userInfo = await selectSql.getLoginUser(req.cookies.user);
        if (userInfo.type === 'salesPerson'){ //관리자 로그인
            console.log("post");
            res.redirect('/sal');
        } else {
            res.redirect('/logout'); //user id 확인 불가
        }
    } else {
        res.render('login');
    }
});

router.post('/sale', async (req, res) => {
    if (req.cookies.user) {
        const userInfo = await selectSql.getLoginUser(req.cookies.user);
        if (userInfo.type === 'salesPerson'){ //관리자 로그인
            console.log("post");
            res.redirect('/sal');
        } else {
            res.redirect('/logout'); //user id 확인 불가
        }
    } else {
        res.render('login');
    }
});

router.post('/salecancel', async (req, res) => {
    if (req.cookies.user) {
        const userInfo = await selectSql.getLoginUser(req.cookies.user);
        if (userInfo.type === 'salesPerson'){ //관리자 로그인
            console.log("post");
            res.redirect('/sal');
        } else {
            res.redirect('/logout'); //user id 확인 불가
        }
    } else {
        res.render('login');
    }
});


module.exports = router;