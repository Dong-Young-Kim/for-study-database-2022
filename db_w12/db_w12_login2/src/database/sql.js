import mysql from "mysql2";

// 데이터베이스 연결
const pool = mysql.createPool(
  process.env.JAWSDB_URL ?? {
    host: 'localhost',
    user: 'root',
    database: 'inha_db',
    password: '',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
  }
);

// async / await 사용
const promisePool = pool.promise();

// selec query
export const selectSql = {
  getUsers: async () => {
    const [rows] = await promisePool.query(`select * from student`);

    return rows
  },
  
  getClass: async () => {
    const [rows] = await promisePool.query('select * from student, class, sign_up where student_sid=sid and class_cid=cid');
    return rows;
}
}