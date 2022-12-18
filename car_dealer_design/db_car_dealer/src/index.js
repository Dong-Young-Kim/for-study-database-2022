// Copyright 2022 kms
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
import logger from "morgan";
import path from "path";
import liveReload from 'livereload';
import connectLiveReload from 'connect-livereload';

import loginRouter from "./routes/login";
import logoutRouter from './routes/logout';
import customerRouter from "./routes/customer";
import adminRouter from "./routes/saler";

const PORT = 3000;
const IPADDR = 'localhost'

//아래는 템플릿으로 고정적으로 이렇게 사용
const liveReloadServer = liveReload.createServer();
liveReloadServer.server.once("connection", () => {
  setTimeout(() => {
    liveReloadServer.refresh('/');
  }, 100)
});

const app = express();

app.use(connectLiveReload());

app.use(express.urlencoded({ extended: false }));
app.use(express.json());

app.set("views", path.join(__dirname, "views"));
app.set("view engine", "hbs");
app.use(express.static(path.join(__dirname, 'public'))) //hbs에게 css파일 경로 알려주기 위해서

app.use(logger("dev"));

app.use("/", loginRouter); //로그인 시
app.use("/logout", logoutRouter); //로그아웃 시
app.use("/cus", customerRouter); //구매,예약 웹페이지로 이동
app.use("/sal", adminRouter); //차량 관리 웹페이지로 이동

app.listen(PORT, IPADDR, () => {
  console.log(`car dealing management service listening at http://${IPADDR}:${PORT}`);
});
