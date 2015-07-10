GuideQuestion = require('components/search/guide_question')

module.exports = React.createClass
  displayName: 'FilterBox'
  propTypes:
    onAddFilter: React.PropTypes.func.isRequired
    guideQuestions: React.PropTypes.array.isRequired

  getInitialState: ->
    questionIndex: 0

  getQuestion: ->
    if @props.guideQuestions.length > 0
      @props.guideQuestions[@state.questionIndex]

  nextQuestion: (e) ->
    e.preventDefault()

    if @state.questionIndex < @props.guideQuestions.length - 1
      @setState(questionIndex: @state.questionIndex + 1)

  prevQuestion: (e) ->
    e.preventDefault()

    if @state.questionIndex > 0
      @setState(questionIndex: @state.questionIndex - 1)

  nextButton: ->
    if @state.questionIndex < @props.guideQuestions.length - 1
      <a href="#" className="btn-next" onClick={@nextQuestion}>Next</a>

  prevButton: ->
    if @state.questionIndex > 0
      <a href="#" className="btn-prev" onClick={@prevQuestion}>prev</a>

  render: ->
    <div className="filter-box">
      <GuideQuestion guideQuestion={@getQuestion()} onAddFilter={@props.onAddFilter} />
      {@prevButton()}
      {@nextButton()}
    </div>