ApplicationHelper = require('mixins/application_helper')
LayerToggle = require('components/layered_navigation/layer_toggle')
SearchStore = require('stores/search_store')
FilterStore = require('stores/filter_store')

module.exports = React.createClass
  displayName: 'AnswerItem'
  mixins: [ApplicationHelper]

  propTypes:
    answer: React.PropTypes.object.isRequired
    onShowMenu: React.PropTypes.func.isRequired
    onHideMenu: React.PropTypes.func.isRequired

  getFilters: ->
    # TODO: this is super hacky figure out how to compose stores, filters should be
    # a seperate store to search
    answer = @props.answer
    filterGroup = SearchStore.findFilter(answer.filterGroup)
    unless filterGroup
      filterGroup = FilterStore.findFilter(answer.filterGroup)

    filterGroup.filters

  render: ->
    answer = @props.answer
    <li key="answer-item-simple" className="answer-item">
      <LayerToggle
        menu="filters"
        context={
          filterGroup: answer.filterGroup
          filters: @getFilters()
          onDismiss: @props.onHideMenu
          }
        onToggle={@props.onShowMenu}
      >{answer.text}</LayerToggle>
      <span className="answer-item-filters">
        [{answer.filterGroup.title}]
      </span>
    </li>
