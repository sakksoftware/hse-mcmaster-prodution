module.exports = function(app) {
  require('./controllers/search_controller')(app);
  require('./controllers/user_controller')(app);
  require('./controllers/articles_controller')(app);
};
