API = require('lib/api')

ArticleActions = Reflux.createActions
  loadArticle: {asyncResult: true}

ArticleActions.loadArticle.listen (id, title, lang) ->
  API.read("articles/#{id}?lang=#{lang}&t=#{title}").done(@completed).fail(@failed)

module.exports = ArticleActions
