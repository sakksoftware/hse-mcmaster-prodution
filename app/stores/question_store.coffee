QuestionActions = require('actions/question_actions')
questions = require('constants/questions')

module.exports = Reflux.createStore
  listenables: [QuestionActions]

  loadQuestions: (success, error) ->
    success(questions)
