module.exports = React.createClass
  displayName: 'AnswerItem'
  propTypes:
    answer: React.PropTypes.object.isRequired
    onAddFilter: React.PropTypes.func.isRequired

  handleAdd: (e) ->
    e.preventDefault()
    @props.onAddFilter(@props.answer)

  render: ->
    <li className="answer-item">
      <a href="#" onClick={@handleAdd}>{@props.answer.text}</a>
    </li>
