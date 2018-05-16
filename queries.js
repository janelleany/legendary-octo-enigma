const pg = require('pg-promise')();
require('dotenv').config();

const {DB_HOST, DB_PORT, DB_NAME, DB_USER, DB_PASSWORD} = process.env;
console.log(DB_PORT);
const dbconfig = {
    host: `${DB_HOST}`,
    port: `${DB_PORT}`,
    database: `${DB_NAME}`,
    user: `${DB_USER}`,
    password: `${DB_PASSWORD}`
};

const db = pg(dbconfig);

let getAllQSTR = () => {
    let qstr = 'SELECT * FROM pieces;'
    return db.query(qstr);
}

let createAccountQSTR = (credentials) => {
    let qstr = 
    `INSERT INTO ${credentials.type} (email, alias, hash)
    VALUES
    ('${credentials.email}', '${credentials.alias}', '${credentials.hash}');`;
    return db.query(qstr);
}


let findRecordQSTR = (table, attribute, input) => {
  let qstr = 
  `SELECT * FROM ${table} WHERE ${attribute} = '${input}';`
  return db.query(qstr);
}

let getOneQSTR = (input) => {
    let qstr = 
    `SELECT * FROM pieces WHERE id = '${input}';`
    return db.one(qstr);
  }

let findUserQSTR = (input) => {
  let qstr = 
  `SELECT * FROM tattooers WHERE email = '${input}' 
  UNION
  SELECT * FROM collectors WHERE email = '${input}';`;
  return db.one(qstr);
}

module.exports = {
    getAllQSTR,
    createAccountQSTR,
    findUserQSTR,
    getOneQSTR
}




// SELECT
//  customer_id,
//  COUNT (customer_id)
// FROM
//  payment
// GROUP BY
//  customer_id
// HAVING
//  COUNT (customer_id) > 40;