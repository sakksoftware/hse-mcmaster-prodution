UserStore = require('stores/user_store')
config = require('config')[window.ENV]

QuestionActions = Reflux.createActions
  loadQuestions: {asyncResult: true}

QuestionActions.loadQuestions.listen ->
  language = UserStore.state.language

  $.getJSON("#{config.localesUrl}questions/#{language}.json").
    done(@completed).
    fail(@failed)

module.exports = QuestionActions
