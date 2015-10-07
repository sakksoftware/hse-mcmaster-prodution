ApplicationHelper = require('mixins/application_helper')
LayerToggle = require('components/layered_navigation/layer_toggle')
SearchStore = require('stores/search_store')
FilterStore = require('stores/filter_store')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'AnswerItem'
  mixins: [ApplicationHelper, TranslationHelper]
  baseTranslation: ''

  propTypes:
    answer: React.PropTypes.object.isRequired
    onShowMenu: React.PropTypes.func.isRequired
    onHideMenu: React.PropTypes.func.isRequired

  getTitle: (section, filterGroup) ->
    @t('menus.filters.title', section_title: section.title, filter_group_title: filterGroup.title)

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
    filterGroup = SearchStore.findFilter(answer.filterGroup)

    # in case filter is not found, we don't want to crash the whole site
    return false unless filterGroup

    <li key="answer-item-simple" className="answer-item">
      <LayerToggle
        menu="filters"
        title={@getTitle(answer.section, answer.filterGroup)}
        context={
          filterGroup: filterGroup
          filters: @getFilters()
          onDismiss: @props.onHideMenu
          }
        onToggle={@props.onShowMenu}
      >{answer.text}</LayerToggle>
      <span className="answer-item-filters">
        [{answer.filterGroup.title}]
      </span>
    </li>
