var path = require('path');

module.exports = function(app) {
  app.get('/api/articles/:id', function(req, res, id) {
    var file_path = 'all_filled_all_visible'
    switch(id) {
      case '1':
      file_path = 'all_filled_all_visible'
      break;
      case '2':
      file_path = 'all_hidden'
      break;
      case '3':
      file_path = 'not_filled_all_visible';
      break;
    }

    res.sendFile(path.resolve(__dirname, '../../../spec/fixtures/requests/articles/' + file_path + '.json'));
  });
};
