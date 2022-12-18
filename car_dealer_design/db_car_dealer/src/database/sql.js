import mysql from "mysql2";

// 데이터베이스 연결
const pool = mysql.createPool(
  process.env.JAWSDB_URL ?? {
    host: 'localhost',
    user: 'root',
    database: 'car_dealer',
    password: '',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
  }
);

// async / await 사용
const promisePool = pool.promise();

// select query
export const selectSql = {
  getUsers: async () => {
    const [rows] = await promisePool.query(`select * from User`);
    return rows
  },

  getLoginUser: async (data) => {
    const [rows] = await promisePool.query(`
      select uid, name from user, salesperson where uid = sid and uid=${data}
      union
      select uid, name from user, customer where uid = ssn and uid=${data};
    `);
    var loginUserInfo = rows[0];
    if(loginUserInfo.uid >= 20000 && loginUserInfo.uid < 30000) {loginUserInfo.type = 'salesPerson';}
    else if (loginUserInfo.uid >= 10000 && loginUserInfo.uid < 20000) {loginUserInfo.type = 'customer';}
    return loginUserInfo;
  },

  getModel: async () => {
    const [rows] = await promisePool.query(`select * from stockModel;`); //using view
    return rows;
  },

  getRsrv: async (data) => {
    const [rows] = await promisePool.query(`select vin, name, price, ssn from vehicle, model where vehicle.mid = model.mid and ssn = ${data};`);
    return rows;
  },

  getAllRsrv: async () => {
    const [rows] = await promisePool.query(`select vin, name, price, ssn from vehicle, model where vehicle.mid = model.mid and ssn is not null;`);
    return rows;
  },

  getVehicle: async () => {
    const [rows] = await promisePool.query(`select vin, name, model.mid, price, ssn as rsrv_cusomer from vehicle, model where vehicle.mid = model.mid order by vin;`);
    return rows;
  },

}

export const insertSql = {
  insertVehicle: async (data) => {
    const sql = `insert into vehicle value (${data.vin}, ${data.mid}, ${data.price}, NULL)`
    await promisePool.query(sql);
  },
  insertSale: async (data) => {
    const sql = `insert into sale value (${data.vin}, ${data.ssn}, ${data.sid}, NULL, 'saled')`
    await promisePool.query(sql);
  }
}

export const deleteSql = {
  deleteVehicle: async (data) => {
      const sql = `delete from vehicle where vin=${data.vin}`
      await promisePool.query(sql);
  },
};

export const updateSql = {
  newRsrv: async (data) => {
      const sql = `
      update vehicle
      set ssn = 10005
      where vehicle.vin = (select vin from model, vehicle 
                          where vehicle.mid = model.mid and model.name='FH16' and ssn is null 
                          order by price 
                          limit 1);`

      await promisePool.query(sql);
  },
};