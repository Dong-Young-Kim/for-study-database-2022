import mysql from 'mysql2';

const pool = mysql.createPool({
    host: 'localhost',
    port: 3306,
    user:'root',
    password:'',
    database:'inha_db',
});

const promisePool = pool.promise();

export const selectSql = { //다른 파일에서 사용하는 경우 앞에 export 명령어
    getBuilding: async () => {
        const sql = `select * from building`;
        const [result] = await promisePool.query(sql);

        return result;
    },

    getRoom: async () => {
        const sql = `select * from room`;
        const [result] = await promisePool.query(sql);

        return result
    },

    getDepartment: async () => {
        const sql = `select * from department`;
        const [result] = await promisePool.query(sql);

        return result
    },

    getClass: async () => {
        const sql = `select * from class`;
        const [result] = await promisePool.query(sql);

        return result
    },

    getStudent: async () => {
        const sql = `select * from student`;
        const [result] = await promisePool.query(sql);

        return result
    },

    getClub: async () => {
        const sql = `select * from club`;
        const [result] = await promisePool.query(sql);

        return result
    },

    getEmployee: async () => {
        const sql = `select * from employee`;
        const [result] = await promisePool.query(sql);

        return result
    },

}

export const insertSql = {

    setRoom: async (data) => {
        const sql = `insert into room values (
            "${data.Rid}", "${data.R_name}", "${data.Capacity}", "${data.Bid}"
        )`

        await promisePool.query(sql);
    }
};

export const updateSql = {

    updateStudent: async (data) => {
        console.log(data);
        const sql = `update student set 
            s_name = "${data.S_name}", 
            s_email = "${data.S_email}", 
            s_phonenumber = "${data.S_phonenumber}", 
            student_id = ${data.Student_id}, 
            major_did = ${data.Major_did}
            where sid=100008`;
        console.log(sql);
        await promisePool.query(sql);
    }
}