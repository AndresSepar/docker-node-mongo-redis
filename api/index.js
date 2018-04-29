const restify = require('restify');
const mongoose = require('mongoose');
const connect = require('mongo/connect');

const Todo = require('mongo/models/todo');

function list(req, res, next) {
  Todo.find()
    .exec()
    .then(todos => res.send(todos))
    .catch(err => res.send(err));
  next();
}

function add(req, res, next) {
  const todo = new Todo(req.body);
  todo.save()
    .then(() => res.status(201).end())
    .catch(err => res.status(400).end());
}

const server = restify.createServer();
server.get('/', list);
server.head('/', list);

server.post('/add', add);
server.head('/add', add);

server.listen(3000, function() {
  console.log('%s listening at %s', server.name, server.url);
});
