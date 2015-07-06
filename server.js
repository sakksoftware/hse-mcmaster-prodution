// var statik = require('statik');
port = process.env.PORT || 3000
// statik(port);
// console.log("starting server on port ", port)

var koa = require('koa');
var app = koa();

app.use(function *(){
  this.body = 'Hello World';
});

app.listen(process.env.PORT || 3000);
console.log("starting server on port ", port)