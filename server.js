var statik = require('statik');
port = process.env.PORT || 3000
statik(port);
console.log("starting server on port ", port)