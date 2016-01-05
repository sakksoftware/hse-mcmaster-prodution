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
    @unsubscribe = SearchStore.listen(@onSearchUpdated)

  componentWillUnmount: ->
    @unsubscribe()

  onSearchUpdated: (state) ->
    search = state.search
    if search.filters
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
    @anyFilter.title = @t('any_filters', filter_title: pluralize(title, 1))

    <div className="filters-menu nested-menu">
      <ul className="menu-list">
        {@renderAnyFilter()}
        {@renderItems(@state.filters)}
      </ul>
    </div>
