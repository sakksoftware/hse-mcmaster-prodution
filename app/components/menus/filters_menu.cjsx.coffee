MenuFilterItem = require('components/menus/menu_filter_item')
module.exports = React.createClass
  displayName: 'FiltersMenu'

  propTypes:
    filters: React.PropTypes.array.isRequired
    onToggleFilter: React.PropTypes.func.isRequired

  renderItems: (items)->
    result = []
    for item in items
      result.push <MenuFilterItem key={item.name} filter={item} onToggle={@props.onToggleFilter} />
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
        {@renderItems(@props.filters)}
      </ul>
    </div>
