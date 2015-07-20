// var statik = require('statik');
port = process.env.PORT || 3000
// statik(port);
// console.log("starting server on port ", port)

var koa = require('koa');
var app = koa();
var serve = require('koa-static');
var auth = require('koa-basic-auth');

app.use(function *(next){
  try {
    yield next;
  } catch (err) {
    if (401 == err.status) {
      this.status = 401;
      this.set('WWW-Authenticate', 'Basic');
      this.body = 'cant haz that';
    } else {
      throw err;
    }
  }
});

app.use(auth({ name: 'hse', pass: 'withgreatpower' }));

app.use(serve('public'));

app.listen(process.env.PORT || 3000);
console.log("starting server on port ", port)