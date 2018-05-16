const express = require('express');
const app = express();
require('dotenv').config();

const {SERVER_PORT, STRING} = process.env;

const path = require('path');
const cors = require('cors');
const bodyParser = require('body-parser');

const bcrypt = require('bcrypt');
const saltRounds = 10;

const jwt = require('jsonwebtoken');
const string = process.env.STRING;

const db = require('./queries');

app.use(cors());
app.use(bodyParser());


app.post("/", function(request, response) {
    createAccount(request, response);
});


app.post("/login", (request, response) => {
    processLogin(request, response);
});


app.get('/all', (request, response) => {
    getAll(request, response);
});

app.get('/all/:id', (request, response) => {
  getOne(request, response);
});

let createAccount = (request, response) => {
  let {email, password, alias, type} = request.body;
  bcrypt.hash(password, saltRounds)
    .then(hash => {
      let credentials = {
        email: email,
        alias: alias,
        hash: hash,
        type: type
      }
      return credentials;
    })
    .then(credentials => {
      db.createAccountQSTR(credentials);
      return credentials;
    })
    .then(credentials => {
      console.log(credentials);
      response.json(credentials);
    });
}


let processLogin = (request, response) => {
  let {email, password} = request.body;
  db.findUserQSTR(email)
  .then(user => {
    return user;
  })
  .catch(error => {response.status(401).send("User not found")})
  .then(user => {
    let {hash} = user;
    bcrypt.compare(password, hash)
    .then(isValid => {
      if (isValid) {
        let token = createToken(user);
        user.token = token;
        response.json(user);
      } else {
        response.send("Invalid password. Maybe try again?");
      }
    })
    .catch(error => {response.status(400).send("Didn't catch that. Maybe try again?")})
  });
}


let getAll = (request, response) => {
  //run authorize. pass into it request.headers.
    db.getAllQSTR()
    .then(all => response.json(all))
}

let getOne = (request, response) => {
  db.getOneQSTR(request.params.id)
  .then(one => {
    response.json(one);
  });
}


let createToken = (user) => {
  let token = jwt.sign({ id: user.id }, STRING, { expiresIn: "7d" });
  return token;
}

let authorize = (token, string) => {
  let decoded = false;
  try {
    decoded = jwt.verify(token, string);
  } catch (e) {
    decoded = false;
  }
  return decoded;
}



app.listen(SERVER_PORT, () => {
    console.log(`this server is listening on port ${SERVER_PORT}`)
});