API = require('lib/api')

ArticleActions = Reflux.createActions
  loadArticle: {asyncResult: true}

ArticleActions.loadArticle.listen (id, title, lang) ->
  id = switch id
    when '1'
      'all_filled_all_visible'
    when '2'
      'all_hidden'
    when '3'
      'not_filled_all_visible'
    else
      'all_filled_all_visible'

  API.read("articles/#{id}?lang=#{lang}&t=#{title}").done(@completed).fail(@failed)

module.exports = ArticleActions
