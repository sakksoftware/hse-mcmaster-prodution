GuidedQuestion = require('components/guided_questions/guided_question')
CarouselIndicators = require('components/shared/carousel_indicators')
QuestionActions = require('actions/question_actions')

module.exports = React.createClass
  displayName: 'GuidedQuestionsBox'

  propTypes:
    onShowMenu: React.PropTypes.func.isRequired

  getInitialState: ->
    questionIndex: 0
    questions: []

  componentWillMount: ->
    QuestionActions.loadQuestions().then(@handleQuestionsLoaded).catch(@handleError)

  handleQuestionsLoaded: (questions) ->
    @setState(questions: questions, questionIndex: 0)

  # TODO: refactor into mixin
  handleError: (xhr, statusCode, responseText) ->
    console.log("Failed to load questions", xhr, statusCode, responseText)
    flash("error", "cannot load list of questions")

  getQuestion: ->
    if @state.questions.length > 0
      @state.questions[@state.questionIndex]

  onNextQuestion: (e) ->
    e.preventDefault()
    @nextQuestion()

  onPrevQuestion: (e) ->
    e.preventDefault()
    @prevQuestion()

  nextQuestion: ->
    if @state.questionIndex < @state.questions.length - 1
      @setState(questionIndex: @state.questionIndex + 1)

  prevQuestion: ->
    if @state.questionIndex > 0
      @setState(questionIndex: @state.questionIndex - 1)

  setQuestion: (questionIndex) ->
    @setState(questionIndex: questionIndex)

  nextButton: ->
    className = "btn-next"
    className += " disabled" if @state.questionIndex >= @state.questions.length - 1

    <a href="#" key="next" className={className} onClick={@onNextQuestion}><i></i></a>

  prevButton: ->
    className = "btn-prev"
    className += " disabled" if @state.questionIndex <= 0

    <a href="#" key="prev" className={className} onClick={@onPrevQuestion}><i></i></a>

  handleKeyDown: (e) ->
    leftArrowKey = 37
    rightArrowKey = 39

    if e.keyCode == leftArrowKey
      @prevQuestion()
    if e.keyCode == rightArrowKey
      @nextQuestion()

  render: ->
    body =
      if @state.questions.length == 0
        <Loader loaded={false} />
      else
        [
          <CarouselIndicators key="carousel-indicators" onClick={@setQuestion} index={@state.questionIndex} length={@state.questions.length} />
          @prevButton()
          <GuidedQuestion onShowMenu={@props.onShowMenu} onHideMenu={@nextQuestion} key="guided-question" question={@getQuestion()} />
          @nextButton()
        ]

    <div className="guided-questions-box" tabIndex={1} onKeyDown={@handleKeyDown}>
      {body}
    </div>
