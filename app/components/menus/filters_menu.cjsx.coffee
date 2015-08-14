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
    @onToggleFilter = @props.context.onToggleFilter
    @currentColorIndex = 0

  nextColor: ->
    @currentColorIndex = (@currentColorIndex + 1) % @colors.length
    @colors[@currentColorIndex]

  currentColor: -> @colors[@currentColorIndex]

  renderItems: (items) ->
    result = []
    for item in items
      result.push <MenuFilterItem key={item.name} indicatorColor={@currentColor()}
        filter={item} onToggle={@onToggleFilter} />
      if item.filters
        result.push <li className="menu-item nested-filters" key="#{item.name}-filters">
          <ul className="menu-list">
            {@renderItems(item.filters)}
          </ul>
        </li>
        @nextColor()

    result

  render: ->
    <div className="filters-menu nested-menu">
      <ul className="menu-list">
        {@renderItems(@filters)}
      </ul>
    </div>
