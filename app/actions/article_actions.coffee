API = require('lib/api')
config = require('config')

if config.useMocks
  return module.exports = require('mocks/actions/article_actions')

ArticleActions = Reflux.createActions
  loadArticle: {asyncResult: true}

ArticleActions.loadArticle.listen (id, title, lang) ->
  API.read("articles/#{id}?lang=#{lang}&t=#{title}").done(@completed).fail(@failed)

module.exports = ArticleActions
