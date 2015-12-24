FetchAPI = require('lib/fetch_api')

ArticleActions = Reflux.createActions
  loadArticle: {asyncResult: true}

ArticleActions.loadArticle.listen (id, title, lang) ->
  FetchAPI.read("articles/#{id}?lang=#{lang}&t=#{title}").then(@completed).catch(@failed)

module.exports = ArticleActions
