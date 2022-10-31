import mysql from 'mysql2';

const pool = mysql.createPool({
    host: 'localhost',
    port: 3306,
    user:'root',
    password:'',
    database:'week9',
});

const promisePool = pool.promise();

export const selectSql = { //다른 파일에서 사용하는 경우 앞에 export 명령어
    getEmployee: async () => {
        const sql = `select * from employee`;
        const [result] = await promisePool.query(sql);

        return result;
    },

    getDepartment: async () => {
        const sql = `select * from department`;
        const [result] = await promisePool.query(sql);

        return result
    }
}

export const insertSql = {
    setEmployee: async (data) => {
        const sql = `insert into employee values (
            "${data.Fname}", "${data.Minit}", "${data.Lname}", "${data.Ssn}", "${data.Bdate}",
            "${data.Address}", "${data.Sex}", "${data.Salary}", "${data.Super_ssn}", "${data.Dno}"
        )`

        await promisePool.query(sql);
    },

    setDepartment: async (data) => {
        const sql = `insert into department values (
            "${data.Dname}", "${data.Dnumber}", "${data.Mgr_ssn}", "${data.Mgr_start_date}"
        )`

        await promisePool.query(sql);
    }
};

export const updateSql = {
    updateEmployee: async () => {
        const sql = `update employee set salary = 500 where Minit = "F"`;
        await promisePool.query(sql);
    },

    updateDepartment: async (data) => {
        console.log(data);
        const sql = `update department set dname = "${data.Dname}" where Dnumber=5`;
        console.log(sql);
        await promisePool.query(sql);
    }
}