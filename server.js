const express = require('express');
const app = express();


const queries = require ('./json/queries');

const path = require('path');

const cors = require('cors');

app.use(cors());

app.get('/all', (request, response) => {
    response.json(queries);
})



app.listen(3001, () => {
    console.log('this server is listening on port 3001')
})