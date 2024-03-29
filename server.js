var express = require('express');
var app = express();
var path = require('path');
var basicAuth = require('basic-auth-connect');
var crypto = require('crypto');
var rollbar = require('rollbar');
var compression = require('compression');
var logger = require('morgan');
var bodyParser = require('body-parser');
var nodeSlug = require('slug');
var fetch = require('node-fetch');

// duplicate logic in app/lib/util
function slug (str) {
  str = str.toLowerCase().replace('<b>', '').replace('</b>', '');
  return nodeSlug(str);
}

var NODE_ENV = process.env.NODE_ENV || 'development';
var AES_KEY = process.env.AES_KEY || '';
var AES_IV = process.env.AES_IV || '';
var ROLLBAR_SERVER_SECRET = process.env.ROLLBAR_SERVER_SECRET || '';

function decrypt(crypted) {
  var crypto = require('crypto');
  var binkey = new Buffer(AES_KEY, 'base64');
  var biniv = new Buffer(AES_IV, 'base64');
  var decipher = crypto.createDecipheriv('aes-256-cbc', binkey, biniv);
  var decrypted = decipher.update(crypted,'base64','utf8');
  decrypted += decipher.final('utf8');
  return decrypted;
}

if(NODE_ENV == 'staging') {
  app.use(basicAuth('hse', 'withgreatpower'));
}

if(NODE_ENV == 'production' || NODE_ENV == 'staging') {
  // force ssl
  app.use(function(req, res, next) {
    if(req.headers['x-forwarded-proto'] !== 'https') {
      return res.redirect(['https://', req.get('Host'), req.url].join(''));
    }
    next();
  });
}

app.use(logger('dev'));
app.use(compression());
app.use(bodyParser.json());
app.use(rollbar.errorHandler(ROLLBAR_SERVER_SECRET));
app.use(express.static('public'));

if(NODE_ENV == 'development') {
  var autoreload = require('connect-autoreload')
  var config = {
    watch_dirs: 'js html css/compiled thirdparty/frontend',
    ignore_regex: /\.sw[poax]$/,
    delay: 150,  // wait 150ms before reloading
  };
  app.use(autoreload(config));

  app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization");
    res.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE");
    next();
  });

  require('./server/mocks/routes')(app);
}

app.get('/one-page-summary.aspx', function(req, res) {
  id = req.query.A;
  title = req.query.T;
  url = '/articles/' + id + '?t=' + title;
  console.log('redirecting to ', url);
  res.redirect(url);
});

app.get('/r.aspx', function(req, res) {
  if(!req.query.x) {
    console.log('[Unknown Redirect] request recieved with no data ');
    return res.redirect('/');
  }

  data = decrypt(req.query.x);
  if(match = data.match(/A=([0-9]+).*R=one-page-summary\.aspx\0T=(.{10})/i)) {
    id = match[1];
    title = match[2];
    url = '/articles/' + id + '?t=' + title;
    console.log('redirecting to ', url);
    res.redirect(url);
  } else {
    console.log('[Unknown Redirect] request recieved with data ', data);
    res.redirect('/');
  }
});

app.get('/rollbar-error-test', function(req, res) {
  rollbar.reportMessage("Testing rollbars from node server", "error");
  res.send('testing rollbars');
});

if (NODE_ENV === 'production' || NODE_ENV == 'staging') {
  app.get('/articles/:id', function(req, res, next) {
    // we are using old url if there is only a number id without the title, so we check that
    var api = NODE_ENV === 'staging' ? 'staging-api' : 'api';
    api = 'https://' + api + '.healthsystemsevidence.org/api/';

    var params = req.params;
    var id = parseInt(params.id, 10);
    if (id == params.id && !isNaN(id)) {
      var url = api + 'articles/' + id + '?t=' + req.query.t;
      console.info('fetching', url);
      fetch(url, { headers: { "Referer": 'https://www.healthsystemsevidence.org' }})
      .then(function(res) {
        return res.json();
      }, function(error) {
        console.error('Failed trying to redirect', error);
        next();
      })
      .then(function(article) {
        var source = req.query.source ? '&source=' + req.query.source : '';
        var url = '/articles/' + id + '-' + slug(article.title) + '?t=' + req.query.t + source;
        console.info('redirecting to', url);
        res.redirect(301, url);
      }, function(error) {
        console.error('Failed trying to redirect', error);
        next();
      })
    } else {
      next();
    }
  });
}

app.get('/sitemap.xml', function(req, res) {
  var api = NODE_ENV === 'staging' ? 'staging-api' : 'api';
  api = 'https://' + api + '.healthsystemsevidence.org/';
  var url = api + 'sitemap.aspx';
  console.log('Redirecting to sitemap at ' + url);
  res.redirect(302, url);
});

app.get('*', function(req, res) {
  res.sendFile(path.join(__dirname,'public/index.html'));
});

var port = process.env.PORT || 3000
app.listen(port);
console.log("starting server on port ", port)
