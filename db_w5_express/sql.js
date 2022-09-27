import mysql from 'mysql2';

const pool = mysql.createPool({
    host: 'localhost',
    port:'3306',
    user:'root',
    password:'',
    database:'week5_company_db'
})

const promisePool = pool.promise();

const sql = {
    getEmployee: async () => {
        const results = await promisePool.query(`
        select * from employee
        `)

        return results;
    },
};

export default sql;