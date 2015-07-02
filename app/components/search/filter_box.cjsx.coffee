GuideQuestion = require('components/search/guide_question')

module.exports = React.createClass
  displayName: 'FilterBox'
  propTypes:
    guideQuestions: React.PropTypes.array.isRequired

  getInitialState: ->
    questionIndex: 0
  getQuestion: ->
    if @props.guideQuestions.length > 0
      @props.guideQuestions[@state.questionIndex]

  nextQuestion: ->
    if @state.questionIndex < @props.guideQuestions.length
      @setState(questionIndex: @state.questionIndex++)

  render: ->
    <div className="filter-box">
      <GuideQuestion guideQuestion={@getQuestion()}/>
      <button onClick={@nextQuestion}>Skip</button>
    </div>