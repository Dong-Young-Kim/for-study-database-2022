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
    const [rows] = await promisePool.query(`select (numOfPartticipants - count(*)) as remain, cid, cname, professor, numOfPartticipants, rid, did 
                                                    from class left join sign_up on cid = class_cid
                                                    group by cid;`);
    return rows;
  },

  getLoginUser: async (data) => {
    const [rows] = await promisePool.query(`select * from student where sid=${data};`);
    return rows;
  },

  getSignUp: async (data) => {
    //console.log(data);                                                  
    const [rows] = await promisePool.query(`select * from student, class, sign_up 
    where student_sid=sid and class_cid=cid 
          and sid=${data}`);
    return rows;
  }
}

export const insertSql = {
  insertSignUp: async (data) => {
    
    console.log("deleteSql.deleteDepartment:", data.cid, data.sid);
    const sql = `insert into sign_up value (${data.cid}, ${data.sid})`

    await promisePool.query(sql);

  }
}

export const deleteSql = {
  deleteSignUp: async (data) => {
      console.log("deleteSql.deleteDepartment:", data.sid, data.cid);
      const sql = `delete from sign_up where student_sid=${data.sid} and class_cid=${data.cid}`

      await promisePool.query(sql);
  },
};