import express from 'express';
import logger from 'morgan';
import path from 'path';

import homeRouter from './routes/home';
import updateRouter from './routes/update';
import selectRouter from './routes/select';

const PORT = 3000; // 설정한 port로 브라우저 연결

const app = express();

app.use(express.static(path.join(__dirname, '/src')));
app.use(express.urlencoded({extended: false}))
app.use(express.json()); //인코딩한 내용을 json 형식으로 가져옴 {"id":"song"}의 형식

app.set('views', path.join(__dirname, 'views')); //./과 동일 의미
app.set('view engine', 'hbs'); //엔진, 그대로 지킬 것

app.use(logger('dev')); //인

app.use('/', homeRouter);
app.use('/update', updateRouter);
app.use('/select', selectRouter);

app.listen(PORT, ()=> {
    console.log(`Server is running at http://localhost:${PORT}`)
});