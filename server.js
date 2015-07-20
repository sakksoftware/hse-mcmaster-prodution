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
      this.body = 'You must login to view this content';
    } else {
      throw err;
    }
  }
});

app.use(auth({ name: 'hse', pass: 'withgreatpower' }));

app.use(serve('public'));

var port = process.env.PORT || 3000
app.listen(port);
console.log("starting server on port ", port)