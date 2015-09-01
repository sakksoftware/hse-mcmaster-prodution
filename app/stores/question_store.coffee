QuestionActions = require('actions/question_actions')
RefluxStateMixin = require('lib/reflux_state_mixin')(Reflux)

module.exports = Reflux.createStore
  listenables: [QuestionActions]
  mixins: [RefluxStateMixin]

  getInitialState: ->
    questions: []
    loaded: false
    errors: null

  onLoadQuestionsCompleted: (questions) ->
    @setState(questions: questions, loaded: true)

  onLoadQuestionsFailed: ->
    console.log('Cannot load questions')
    @setState(errors: 'Cannot load questions', loaded: false)
