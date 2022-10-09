import express from "express";
import bodyParser from "body-parser";
import path from 'path';
import sql from './sql';

const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

app.get("/", async(req, res)=>{
    //res.sendFile(path.join(__dirname+'/index.html'));
    await sql.insertClub();
    const employee = await sql.getClub();
    
    res.json({"Club": employee})
});

// app.get("/", (req, res)=>{
//     res.sendFile(path.join(__dirname+'/index.html'));
// });

app.listen(3000, ()=>{
    console.log("server is running on port 3000.");
})
