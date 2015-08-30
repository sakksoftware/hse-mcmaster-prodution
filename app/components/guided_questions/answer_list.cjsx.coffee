AnswerItem = require('components/guided_questions/answer_item')

module.exports = React.createClass
  displayName: 'AnswerList'
  propTypes:
    answers: React.PropTypes.array.isRequired

  renderFilters: ->
    for answer, i in @props.answers
      <AnswerItem key={"answer-#{i}"} answer={answer} />

  render: ->
    <ul className="answer-list">
      {@renderFilters()}
    </ul>
