const express = require('express');
const app = express();
require('dotenv').config();

// const urlOfServer = 'https://cryptic-harbor-57322.herokuapp.com/';

const PORT = process.env.PORT || 5000

// const path = require('path');
const cors = require('cors');
const bodyParser = require('body-parser');

const bcrypt = require('bcrypt');
const saltRounds = 10;

const jwt = require('jsonwebtoken');
const SIGNATURE = process.env.SIGNATURE;

const db = require('./queries');

//middleware
app.use(cors());
app.use(bodyParser());

//ROUTER FUNCTIONS
//route: POST to '/users' to create user account
app.post('/users', function(request, response) {
    createAccount(request, response);
});


//route: POST to '/token' to login user
app.post('/token', (request, response) => {
    processLogin(request, response);
});


//route: GET to '/pieces' to return all pieces
app.get('/pieces', (request, response) => {
    getAll(request, response);
});


//route: GET to '/pieces/:id' to return a particular piece
app.get('/pieces/:id', (request, response) => {
  getOne(request, response);
});


//route: POST to '/pieces/' to create a new piece
app.post('/pieces/', (request, response) => {
  createPiece(request, response);
});


// router callback functions for database queries & other controls
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
  authorizeRequest(request.headers.authorization);
  if (decoded) {
    db.getAllQSTR()
    .then(all => response.json(all))
    .catch(error => response.status(404).send("File not found. Maybe try again?"));
  } else {
    response.status(401).send("Unauthorized User")
  }
}


let getOne = (request, response) => {
  authorizeRequest(request.headers.authorization);
  if (decoded) {
    db.getOneQSTR(request.params.id)
    .then(one => response.json(one))
  } else {
    response.status(401).send("Unauthorized User")
  }
}


let createToken = (user) => {
  let token = jwt.sign({ id: user.id }, SIGNATURE, { expiresIn: '7d' });
  return token;
}


let authorizeRequest = (token) => {
  let decoded = null;
  try {
    decoded = jwt.verify(token, SIGNATURE);
  } 
  catch (e) {}
  return decoded;
}


let createPiece = (request, response) => {
  authorizeRequest(request.headers.authorization);
  if (decoded) {
    let specs = request.body;
    db.createPieceQSTR(specs)
    .then(newPiece => {
      response.json(newPiece);
    })
    .catch(error => response.status(400).send("Bad Request. Check piece's specifications."));
  } else {
    response.status(401).send("Unauthorized User");
  }
}


app.listen(PORT, () => console.log(`this server is listening on ${ PORT }`));