AppliedFilters = require('components/search/applied_filters')
LayerToggle = require('components/layered_navigation/layer_toggle')
TranslationHelper = require('mixins/translation_helper')
SearchActions = require('actions/search_actions')
SearchStore = require('stores/search_store')
Util = require('lib/util')

TourActions = require('actions/tour_actions')

module.exports = React.createClass
  displayName: 'FilterGroupsMenu'

  mixins: [TranslationHelper]
  baseTranslation: ''

  propTypes:
    context: React.PropTypes.object
    setOverlayContent: React.PropTypes.func

  getInitialState: ->
    filters: SearchStore.state.search.filters

  componentWillMount: ->
    @onShowFilterGroup = @props.context.onShowFilterGroup
    @unsubscribe = SearchStore.listen(@onSearchUpdated)

  componentWillUnmount: ->
    @unsubscribe()

  onSearchUpdated: (state) ->
    if state.loaded
      @setState(filters: state.search.filters)
      @setOverlayContent(state)

  # TODO: can probably rewrite this whole thing by using css to move the SearchBox.renderResultCountFooter
  # as this is for desktop only
  setOverlayContent: (state) ->
    overlayContent = ""
    if state.search?.results_count != null
      overlayContent = @t('/search_page.search_box.view_results_count', count: state.search.results_count)
    @props.setOverlayContent(overlayContent)

  onRemoveFilterGroup: (filter) ->
    SearchActions.removeFilterGroup(filter)

  getTitle: (section, filterGroup) ->
    title = @t('menus.filters.title', section_title: section.title, filter_group_title: filterGroup.title)
    Util.sentenceCase(title)

  getMenuContext: (filterGroup) ->
    filterGroup: filterGroup
    filters: SearchStore.findFilter(filterGroup)?.filters || []
    onShowFilterGroup: @onShowFilterGroup

  getMenuName: (filterGroup) ->
    menu = "filters"
    menu = "countries" if filterGroup.type.match(/countries_/) && filterGroup.type != 'countries_lmics'
    menu = "dateRange" if filterGroup.type == "date_range"
    menu

  # TODO: a little bit dirty, maybe should re-think the
  # * option 1: use references to trigger "toggle" method on the LayerToggle,
  #   will need to find the right reference
  # * option 2: pass a layer toggle into AppliedFilters component
  onShowFilterGroupWrapper: (section, filterGroup) ->
    menu = @getMenuName(filterGroup)
    title = @getTitle(section, filterGroup)

    @onShowFilterGroup(menu, title, @getMenuContext(filterGroup))

  hasApplied: (filter) ->
    SearchStore.hasAppliedFiltersFor(filter)

  renderMenu: (section, filterGroup) ->
    <LayerToggle
      className="menu-item-text"
      menu={@getMenuName(filterGroup)}
      title={@getTitle(section, filterGroup)}
      context={@getMenuContext(filterGroup)}
      onToggle={@onShowFilterGroup}>
      {filterGroup.title}
    </LayerToggle>

  renderSection: (section) ->
    menuItems =
      if section.filters
        for filterGroup, i in section.filters
          className = "menu-item"
          className += " filter-applied" if @hasApplied(filterGroup)
          className += " filter-group-#{filterGroup.type.replace('_', '-')}" if filterGroup.type
          <li className={className} key="filter-group-#{i}">
            {@renderMenu(section, filterGroup)}
          </li>

    [
      <h2>{section.title}</h2>
      <ul className="menu-list">
        {menuItems}
      </ul>
    ]

  renderSections: ->
    for section in @state.filters
      @renderSection(section)

  render: ->
    <div className="filter-groups-menu nested-menu">
      <AppliedFilters filters={@state.filters} onRemoveFilter={@onRemoveFilterGroup} onShowFilterGroup={@onShowFilterGroupWrapper} />
      {@renderSections()}
    </div>
