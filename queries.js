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
    return db.query('SELECT * FROM queries;')
}

module.exports = {
    getAllQSTR
}

// const uuid = require('uuid-v4');


// SELECT
//  customer_id,
//  COUNT (customer_id)
// FROM
//  payment
// GROUP BY
//  customer_id
// HAVING
//  COUNT (customer_id) > 40;