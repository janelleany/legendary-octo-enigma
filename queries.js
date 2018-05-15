const pg = require('pg-promise')();

const dbconfig = {
    host: 'localhost',
    port: 5432,
    database: 'inkkarma',
    user: 'jra',
    password: 'sweettuba'
}

const db = pg(dbconfig);

let getAllQSTR = () => {
    let qstr = 'SELECT * FROM queries;'
    return db.query(qstr)
}

let createAccountQSTR = () => {
    let qstr = ''
    return db.query(qstr)
}

let processLoginQSTR = () => {
    let qstr = ''
    return db.query(qstr)
}


module.exports = {
    getAllQSTR
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