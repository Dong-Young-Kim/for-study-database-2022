import mysql from 'mysql2';

const pool = mysql.createPool({
    host: 'localhost',
    port:'3306',
    user:'root',
    password:'',
    database:'inha_db'
})

const promisePool = pool.promise();

const sql = {
    getClub: async () => {
        const results = await promisePool.query(`
        select * from club
        `)

        return results;
    },
    insertClub: async () => {
        const results = await promisePool.query(`
        insert into club values (NULL, 'database club')
        `)
    },
};

export default sql;