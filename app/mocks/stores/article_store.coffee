API = require('lib/api')
ArticleActions = require('actions/article_actions')

module.exports = Reflux.createStore
  listenables: [ArticleActions]

  loadArticle: (id, lang, success, error) ->
    API.read "articles/#{id}?lang=#{lang}",
      success: success,
      error: error
