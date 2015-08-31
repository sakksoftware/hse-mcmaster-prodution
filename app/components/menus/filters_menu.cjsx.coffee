MenuFilterItem = require('components/menus/menu_filter_item')
TranslationHelper = require('mixins/translation_helper')
SearchActions = require('actions/search_actions')
SearchStore = require('stores/search_store')

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
    @currentColorIndex = 0

    @unsubscribe = SearchStore.listen(@onFiltersUpdated)

  componentWillUnmount: ->
    @unsubscribe()

  onFiltersUpdated: ->
    @filterGroup = SearchStore.findFilter(@filterGroup)
    filters = @filterGroup.filters
    @setState(filters: filters)

  onToggleFilter: (filter) ->
    SearchActions.toggleFilter(filter)

  nextColor: ->
    @currentColorIndex = (@currentColorIndex + 1) % @colors.length
    @colors[@currentColorIndex]

  currentColor: -> @colors[@currentColorIndex]

  renderItems: (items) ->
    result = []

    for item in items
      result.push <MenuFilterItem key="filter-#{item.id}" indicatorColor={@currentColor()}
        filter={item} onToggle={@onToggleFilter} />
      if item.filters
        result.push <li className="menu-item nested-filters" key="filters-list-#{item.id}">
          <ul className="menu-list">
            {@renderItems(item.filters)}
          </ul>
        </li>
        @nextColor()

    result

  renderAllFilter: ->
    return if @state.filters.length <= 1
    result =
      <MenuFilterItem className="all-filters" key="all-filter-#{@filterGroup.id}" indicatorColor={@currentColor()}
        filter={@allFilter} onToggle={@onToggleFilter} />

    @nextColor()

    result

  render: ->
    @currentColorIndex = 0
    @allFilter = _.clone(@filterGroup)
    @allFilter.title = @t('all_filters', filter_title: @filterGroup.title[0].toLowerCase() + @filterGroup.title.substring(1))

    <div className="filters-menu nested-menu">
      <ul className="menu-list">
        {@renderAllFilter()}
        {@renderItems(@state.filters)}
      </ul>
    </div>
