const express = require('express');
const app = express();
const path = require('path');
const cors = require('cors');
const db = require('./queries');
const bcrypt = require('bcrypt');
const saltRounds = 10;

const bodyParser = require('body-parser')


app.use(cors());
app.use(bodyParser());


app.post("/", function(request, response) {
    createAccount(request, response);
});


app.post("/login", function(request, response) {
    console.log(request.body);
    processLogin(request, response);
});


app.get('/all', (request, response) => {
    getAll(request, response);
})


let createAccount = (request, response) => {
    console.log(request.body);
    // let {email, password, username} = request.body;
    // bcrypt.hash(password, saltRounds)
    // .then(hash => {
    //     let credentials = {
    //         email: email,
    //         hash: hash,
    //         username: username
    //     };
    //     db.createAccountQSTR(credentials)
    // })
    // .then(credentials => response.json(credentials))
}


let processLogin = (request, response) => {
    db.processLoginQSTR()
    .then(credentials => response.json(credentials))
}


let getAll = (request, response) => {
    db.getAllQSTR()
    .then(all => response.json(all))
}




app.listen(3001, () => {
    console.log('this server is listening on port 3001')
})