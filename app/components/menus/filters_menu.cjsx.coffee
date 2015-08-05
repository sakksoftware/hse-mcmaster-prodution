module.exports = React.createClass
  displayName: 'SubFiltersMenu'

  propTypes:
    filters: React.PropTypes.array.isRequired

  renderItems: (items)->
    result = []
    for item in items
      result.push <li className="menu-item">{item.name}</li>
      if item.filters
        result.push <li className="menu-item">
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
