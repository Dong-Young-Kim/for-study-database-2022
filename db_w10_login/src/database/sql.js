import mysql from 'mysql2';

const pool = mysql.createPool({
    host: 'localhost',
    port: 3306,
    user:'root',
    password:'',
    database:'week10',
});

const promisePool = pool.promise();

export const selectSql = { //다른 파일에서 사용하는 경우 앞에 export 명령어
    getUsers: async () => {
        const [rows] = await promisePool.query('select * from user');
        return rows;
    },
    getDepartment: async () => {
        const [rows] = await promisePool.query('select * from department');
        return rows;
    },
}

export const deleteSql = {
    deleteDepartment: async (data) => {
        console.log("deleteSql.deleteDepartment:", data.Dnumber);
        const sql = 'delete from department where Dnumber=${data.Dnumber}'
        await promisePool.query(sql);
    },
};