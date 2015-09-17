UserStore = require('stores/user_store')
config = require('config')
API = require('lib/api')

QuestionActions = Reflux.createActions
  loadQuestions: {asyncResult: true}

QuestionActions.loadQuestions.listen ->
  language = UserStore.state.language

  $.getJSON("#{config.localesUrl}questions/#{language}.json").
    done(@completed).
    fail =>
      API.onError().apply(@failed, arguments)
      @failed.apply(@failed, arguments)

module.exports = QuestionActions
