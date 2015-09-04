var express = require('express');
var app = express();
var path = require('path');
var basicAuth = require('basic-auth-connect');

app.use(basicAuth('hse', 'withgreatpower'));

app.use(express.static('public'));

app.get('/one-page-summary.aspx', function(req, res) {
  id = req.url.match(/one-page-summary\.aspx\?A=([0-9]+)&T=/)[1];
  console.log('redirecting to ' + '/articles/' + id)
  res.redirect('/articles/' + id);
});

app.get('*', function(req, res) {
  res.sendFile(path.join(__dirname,'public/index.html'));
});

var port = process.env.PORT || 3000
app.listen(port);
console.log("starting server on port ", port)
