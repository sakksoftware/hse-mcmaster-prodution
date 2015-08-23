module.exports = React.createClass
  displayName: 'AnswerItem'
  propTypes:
    answer: React.PropTypes.object.isRequired
    onAddFilterById: React.PropTypes.func.isRequired

  handleAdd: (e) ->
    e.preventDefault()
    for filter in @props.answer.filters
      @props.onAddFilterById(filter)

  render: ->
    <li className="answer-item">
      <a href="#" onClick={@handleAdd}>{@props.answer.text}</a>
    </li>
