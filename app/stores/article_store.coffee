ArticleActions = require('actions/article_actions')
RefluxStateMixin = require('lib/reflux_state_mixin')(Reflux)

module.exports = Reflux.createStore
  listenables: [ArticleActions]
  mixins: [RefluxStateMixin]

  getInitialState: ->
    article: null
    loaded: false
    errros: null

  loadArticleCompleted: (article) ->
    @setState(article: article, loaded: true)

  loadArticleFailed: (xhr) ->
    @setState(errors: ['load_article_failed'], loaded: false)
