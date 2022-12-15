import cookieParser from "cookie-parser";
import express from "express";
import expressSession from 'express-session';
const router = express.Router();

// 쿠키와 세션은 아래와 같이 사용(일단은 쿠키만 사용)
router.use(cookieParser());
router.use(expressSession({
    secret: 'dilab',
    resave: true,
    saveUninitialized: true,
}))

//로그아웃 시 쿠키가 사라짐 = login이 풀림
router.get('/logout', (req, res) => {
    if (req.cookies.user) {
        res.clearCookie('user')
        res.redirect("/");
    } else {
        res.redirect("/");
    }
})

module.exports = router;