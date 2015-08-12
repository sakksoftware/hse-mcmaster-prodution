MenuFilterItem = require('components/menus/menu_filter_item')
module.exports = React.createClass
  displayName: 'FiltersMenu'

  propTypes:
    context: React.PropTypes.object

  componentWillMount: ->
    @filters = @props.context.filters
    @onToggleFilter = @props.context.onToggleFilter

  renderItems: (items) ->
    result = []
    for item in items
      result.push <MenuFilterItem key={item.name} filter={item} onToggle={@onToggleFilter} />
      if item.filters
        result.push <li className="menu-item" key="#{item.name}-filters">
          <ul className="menu-list">
            {@renderItems(item.filters)}
          </ul>
        </li>

    result

  render: ->
    <div className="filters-menu nested-menu">
      <ul className="menu-list">
        {@renderItems(@filters)}
      </ul>
    </div>
