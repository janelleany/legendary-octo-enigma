const express = require('express');
const app = express();
const queries = require ('./json/queries');
const path = require('path');
const cors = require('cors');
const db = require('./queries');



app.use(cors());

app.get('/all', (request, response) => {
    getAll(request, response);
})


let getAll = (request, response) => {
    db.getAllQSTR()
    .then(all => response.json(all))
}


app.listen(3001, () => {
    console.log('this server is listening on port 3001')
})