import mysql from "mysql2"

//db 연결
const pool = mysql.createPool(
    process.env.JAWSDB_URL ??{
        host: 'localhost',
        user:'root',
        password:'',
        database:'inha_db',
        waitForConnections: true,
        connectionLimit: 10,
        queueLimit: 0
    }
);

//async /await 사용
const promisePool = pool.promise();

//select query

export const selectSql = {
    getEmployee
}