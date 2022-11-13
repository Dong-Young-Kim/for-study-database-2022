import mysql from 'mysql2';

const pool = mysql.createPool(
        process.env.JAWSDB_URL ?? {
        host: 'localhost',
        port: 3306,
        user:'root',
        password:'',
        database:'inha_db',
    }
);

const promisePool = pool.promise();

export const selectSql = { //다른 파일에서 사용하는 경우 앞에 export 명령어
    getUsers: async () => { // 로그인 시 사용할 user정보
        const [rows] = await promisePool.query(`select * from student`);
        return rows;
    },
    getStudent: async () => {
        const [rows] = await promisePool.query(`select * from student, department where major_did=did`);
        return rows;
    },
    getClass: async () => {
        const [rows] = await promisePool.query('select * from student, class, sign_up where student_sid=sid and class_cid=cid');
        return rows;
    }
}

export const deleteSql = {
    deleteSignUp: async (data) => {
        console.log("deleteSql.deleteDepartment:", data.sid, data.cid);
        const sql = `delete from sign_up where student_sid=${data.sid} and class_cid=${data.cid}`

        await promisePool.query(sql);
    },
};