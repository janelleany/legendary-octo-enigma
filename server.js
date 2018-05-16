const express = require('express');
const app = express();

// const urlOfServer = 'https://cryptic-harbor-57322.herokuapp.com/';

const PORT = process.env.PORT || 5000


const queries = require ('./json/queries');

const path = require('path');

const cors = require('cors');

app.use(cors());

app.get('/all', (request, response) => {
    response.json(queries);
})

app.listen(PORT, () => console.log(`this server is listening on ${ PORT }`))
