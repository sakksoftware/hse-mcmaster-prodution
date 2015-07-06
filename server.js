// var statik = require('statik');
port = process.env.PORT || 3000
// statik(port);
// console.log("starting server on port ", port)

var koa = require('koa');
var app = koa();
var serve = require('koa-static');

app.use(serve('public'));

app.listen(process.env.PORT || 3000);
console.log("starting server on port ", port)