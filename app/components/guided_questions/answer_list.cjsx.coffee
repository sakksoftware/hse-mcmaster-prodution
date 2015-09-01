AnswerItem = require('components/guided_questions/answer_item')
SearchStore = require('stores/search_store')

module.exports = React.createClass
  displayName: 'AnswerList'
  propTypes:
    answers: React.PropTypes.array.isRequired
    onShowMenu: React.PropTypes.func.isRequired
    onHideMenu: React.PropTypes.func.isRequired

  renderFilters: ->
    for answer, i in @props.answers
      <AnswerItem onShowMenu={@props.onShowMenu} onHideMenu={@props.onHideMenu} key={"answer-#{i}"} answer={answer} />

  render: ->
    <ul className="answer-list">
      {@renderFilters()}
    </ul>
