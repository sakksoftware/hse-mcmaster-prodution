AnswerItem = require('components/guided_questions/answer_item')
SearchStore = require('stores/search_store')

module.exports = React.createClass
  displayName: 'AnswerList'
  propTypes:
    answers: React.PropTypes.array.isRequired
    onShowMenu: React.PropTypes.func.isRequired
    onHideMenu: React.PropTypes.func.isRequired

  getInitialState: ->
    loaded: false

  componentWillMount: ->
    @unsubscribe = SearchStore.listen(@onSearchUpdated)

  componentWillUnmount: ->
    @unsubscribe()

  onSearchUpdated: (state) ->
    @setState(loaded: state.loaded)


  renderFilters: ->
    for answer, i in @props.answers
      <AnswerItem onShowMenu={@props.onShowMenu} onHideMenu={@props.onHideMenu} key={"answer-#{i}"} answer={answer} />

  render: ->
    if @state.loaded
      <ul className="answer-list">
        {@renderFilters()}
      </ul>
    else
      <ul className="answer-list">
        <Loader loaded=false />
      </ul>
