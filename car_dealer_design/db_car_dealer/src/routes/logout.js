import cookieParser from "cookie-parser";
import express from "express";
import expressSession from 'express-session';
const router = express.Router();

// 쿠키 및 세션 설정
router.use(cookieParser());
router.use(expressSession({
    secret: 'dnyg_cardealer',
    resave: true,
    saveUninitialized: true,
}))

//로그아웃 시 쿠키가 사라짐 = login이 풀림
router.get('/', (req, res) => {
    if (req.cookies.user) {
        res.clearCookie('user')
        res.redirect("/");
    } else {
        res.redirect("/");
    }
})

//로그아웃 시 쿠키가 사라짐 = login이 풀림
router.post('/', (req, res) => {
    if (req.cookies.user) {
        res.clearCookie('user')
        res.redirect("/");
    } else {
        res.redirect("/");
    }
})

module.exports = router;