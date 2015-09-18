GuidedQuestion = require('components/guided_questions/guided_question')
CarouselIndicators = require('components/shared/carousel_indicators')
QuestionActions = require('actions/question_actions')
SearchStore = require('stores/search_store')
FilterStore = require('stores/filter_store')
QuestionStore = require('stores/question_store')

module.exports = React.createClass
  displayName: 'GuidedQuestionsBox'

  propTypes:
    onShowMenu: React.PropTypes.func.isRequired
    expanded: React.PropTypes.bool

  getInitialState: ->
    questionIndex: 0
    questions: QuestionStore.state.questions
    questionsLoaded: QuestionStore.state.loaded
    filtersLoaded: SearchStore.state.loaded || FilterStore.state.loaded

  componentWillMount: ->
    QuestionActions.loadQuestions().then(@handleQuestionsLoaded)
    @unsubscribeSearch = SearchStore.listen(@handleSearchLoaded)
    @unsubscirbeFilters = FilterStore.listen(@handleFiltersLoaded)

  componentWillUnmount: ->
    @unsubscribeSearch()
    @unsubscirbeFilters()

  handleQuestionsLoaded: (questions) ->
    @setState(questions: questions, questionIndex: 0, questionsLoaded: true)

  handleSearchLoaded: (state) ->
    @setState(filtersLoaded: state.loaded)

  handleFiltersLoaded: (state) ->
    @setState(filtersLoaded: state.loaded)

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
      if @state.questionsLoaded && @state.filtersLoaded
        [
          <CarouselIndicators key="carousel-indicators" onClick={@setQuestion} index={@state.questionIndex} length={@state.questions.length} />
          @prevButton()
          <GuidedQuestion expanded={@props.expanded} onShowMenu={@props.onShowMenu} onHideMenu={@nextQuestion} key="guided-question" question={@getQuestion()} />
          @nextButton()
        ]
      else
        <Loader loaded={false} />

    <div className="guided-questions-box" tabIndex={1} onKeyDown={@handleKeyDown}>
      {body}
    </div>
