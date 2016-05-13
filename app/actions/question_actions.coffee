UrlStore = require('stores/url_store')
config = require('config')
API = require('lib/api')

QuestionActions = Reflux.createActions
  loadQuestions: {asyncResult: true}

QuestionActions.loadQuestions.listen ->
  language = UrlStore.state.params.lang || 'en'

  $.getJSON("/locales/questions/#{language}.json").
    done(@completed).
    fail =>
      API.onError().apply(@failed, arguments)
      @failed.apply(@failed, arguments)

module.exports = QuestionActions
