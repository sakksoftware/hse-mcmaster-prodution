MenuFilterItem = require('components/menus/menu_filter_item')
TranslationHelper = require('mixins/translation_helper')
SearchActions = require('actions/search_actions')
SearchStore = require('stores/search_store')
LayerToggle = require('components/layered_navigation/layer_toggle')

SYSTEM_ARRANGMENTS_GROUP = '2_-1'

module.exports = React.createClass
  displayName: 'FiltersMenu'

  mixins: [TranslationHelper]
  baseTranslation: 'menus.filters'

  propTypes:
    context: React.PropTypes.object

  colors: [
    "#D8712A"
    "#178EEE"
    "#66C192"
    "#FFC46D"
    "#D8712A"
    "#C4536E"
  ]

  getInitialState: ->
    filters: @props.context.filters

  componentWillMount: ->
    @filterGroup = @props.context.filterGroup
    @onShowFilterGroup = @props.context.onShowFilterGroup
    @currentColorIndex = 0
    @unsubscribe = SearchStore.listen(@onSearchUpdated)

  componentWillUnmount: ->
    @unsubscribe()

  onSearchUpdated: (state) ->
    search = state.search
    if !_.isEmpty(search.filters)
      filterGroup = SearchStore.findFilter(@filterGroup)
      return unless filterGroup

      @filterGroup = filterGroup
      filters = @filterGroup.filters
      @setState(filters: filters)

  onToggleFilter: (filter) ->
    SearchActions.toggleFilter(filter)

  nextColor: ->
    @currentColorIndex = (@currentColorIndex + 1) % @colors.length
    @colors[@currentColorIndex]

  currentColor: -> @colors[@currentColorIndex]

  hasApplied: (filter) ->
    SearchStore.hasAppliedFiltersFor(filter)

  renderSystemArrangements: (items) ->
    results = []

    for item in items
      className="menu-item"
      className += " filter-applied" if @hasApplied(item)
      results.push <li className={className} key="filters-list-#{item.id}">
          <LayerToggle
            className="menu-item-text"
            menu="filters"
            title={item.title}
            context={
              filterGroup: item
              filters: SearchStore.findFilter(item).filters
            }
            onToggle={@onShowFilterGroup}
            style={
              borderColor: @currentColor()
              borderLeftWidth: "4px"
              borderLeftStyle: "solid"
            }
            >
            {item.title}
          </LayerToggle>
        </li>

      @nextColor()

    results

  renderItems: (items) ->
    results = []

    if @filterGroup.id == SYSTEM_ARRANGMENTS_GROUP
      return @renderSystemArrangements(items)

    for item in items
      results.push <MenuFilterItem key="filter-#{item.id}" indicatorColor={@currentColor()}
        filter={item} onToggle={@onToggleFilter} />
      if item.filters
        results.push <li className="menu-item nested-filters" key="filters-list-#{item.id}">
          <ul className="menu-list">
            {@renderItems(item.filters)}
          </ul>
        </li>
        @nextColor()

    results

  renderAnyFilter: ->
    return if @state.filters.length <= 1
    result =
      <MenuFilterItem className="any-filters" key="any-filter-#{@filterGroup.id}" indicatorColor={@currentColor()}
        filter={@anyFilter} onToggle={@onToggleFilter} />

    @nextColor()

    result

  render: ->
    @currentColorIndex = 0
    @anyFilter = _.clone(@filterGroup)
    title = @filterGroup.title
    if title != 'LMICs'
      title = title.toLowerCase()
    if title?.toUpperCase() == "CANADA'S HEALTH SYSTEM DOCUMENTS"
      title = "Canadian health system document"
    if title?.toUpperCase() == "ONTARIO'S HEALTH SYSTEM DOCUMENTS"
      title = "Ontario health system document"
    @anyFilter.title = @t('any_filters', filter_title: pluralize(title, 1))

    <div className="filters-menu nested-menu">
      <ul className="menu-list">
        {@renderAnyFilter()}
        {@renderItems(@state.filters)}
      </ul>
    </div>
