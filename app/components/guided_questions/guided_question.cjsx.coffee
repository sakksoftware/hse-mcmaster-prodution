AnswerList = require('components/guided_questions/answer_list')

module.exports = React.createClass
  displayName: 'GuidedQuestion'
  propTypes:
    question: React.PropTypes.object.isRequired
    onAddFilter: React.PropTypes.func.isRequired

  render: ->
    <div className="guided-question">
      <div className="guided-question-text">
        {@props.question.text}
      </div>
      <AnswerList answers={@props.question.answers} onAddFilter={@props.onAddFilter} />
    </div>
