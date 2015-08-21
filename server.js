var express = require('express');
var app = express();
var path = require('path');
var basicAuth = require('basic-auth-connect');

app.use(basicAuth('hse', 'withgreatpower'));

app.use(express.static('public'));
app.get('*', function(req, res) {
  res.sendFile(path.join(__dirname,'public/index.html'));
});

var port = process.env.PORT || 3000
app.listen(port);
console.log("starting server on port ", port)
