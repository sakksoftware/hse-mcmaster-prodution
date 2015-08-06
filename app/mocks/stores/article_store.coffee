API = require('lib/api')
ArticleActions = require('actions/article_actions')

module.exports = Reflux.createStore
  listenables: [ArticleActions]

  loadArticle: (id, success, error) ->
    API.read "articles/#{id}",
      success: success,
      error: error
