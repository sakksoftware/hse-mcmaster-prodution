MenuFilterItem = require('components/menus/menu_filter_item')
module.exports = React.createClass
  displayName: 'FiltersMenu'

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

  componentWillMount: ->
    @filters = @props.context.filters
    @filterGroup = _.clone(@props.context.filterGroup)
    @filterGroup.title = "All " + @filterGroup.title
    @onToggleFilter = (filter) =>
      @props.context.onToggleFilter(filter)
      @forceUpdate()
    @currentColorIndex = 0

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
    result =
      <MenuFilterItem className="all-filters" key="all-filter-#{@filterGroup.id}" indicatorColor={@currentColor()}
        filter={@filterGroup} onToggle={@onToggleFilter} />

    @nextColor()

    result

  render: ->
    @currentColorIndex = 0
    <div className="filters-menu nested-menu">
      <ul className="menu-list">
        {@renderAllFilter()}
        {@renderItems(@filters)}
      </ul>
    </div>
