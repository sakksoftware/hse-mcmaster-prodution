GuidedQuestion = require('components/guided_questions/guided_question')
QuestionActions = require('actions/question_actions')

module.exports = React.createClass
  displayName: 'GuidedQuestionsBox'
  propTypes:
    onAddFilter: React.PropTypes.func.isRequired

  getInitialState: ->
    questionIndex: 0
    questions: []

  componentWillMount: ->
    QuestionActions.loadQuestions(@handleQuestionsLoaded, @handleError)

  handleQuestionsLoaded: (questions) ->
    @setState(questions: questions, questionIndex: 0)

  # TODO: refactor into mixin
  handleError: (xhr, statusCode, responseText) ->
    console.log("Failed to load questions", xhr, statusCode, responseText)
    flash("error", "cannot load list of questions")

  getQuestion: ->
    if @state.questions.length > 0
      @state.questions[@state.questionIndex]

  nextQuestion: (e) ->
    e.preventDefault()

    if @state.questionIndex < @state.questions.length - 1
      @setState(questionIndex: @state.questionIndex + 1)

  prevQuestion: (e) ->
    e.preventDefault()

    if @state.questionIndex > 0
      @setState(questionIndex: @state.questionIndex - 1)

  nextButton: ->
    className = "btn-next"
    className += " disabled" if @state.questionIndex < @state.questions.length - 1

    <a href="#" key="next" className={className} onClick={@nextQuestion}><i></i></a>

  prevButton: ->
    className = "btn-prev"
    className += " disabled" if @state.questionIndex > 0

    <a href="#" key="prev" className={className} onClick={@prevQuestion}><i></i></a>

  render: ->
    body =
      if @state.questions.length == 0
        <Loader loaded={false} />
      else
        [
          @prevButton()
          <GuidedQuestion key="guided-question" question={@getQuestion()} onAddFilter={@props.onAddFilter} />
          @nextButton()
        ]

    <div className="guided-questions-box">
      {body}
    </div>
