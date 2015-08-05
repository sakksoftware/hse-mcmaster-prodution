MenuToggle = require('components/menus/menu_toggle')

module.exports = React.createClass
  displayName: 'FiltersMenu'
  propTypes:
    filters: React.PropTypes.array.isRequired
    onFilterToggle: React.PropTypes.func.isRequired
    onFilterGroupClick: React.PropTypes.func.isRequired

  renderMenu: (filterGroup) ->
    if filterGroup.name == "Countries"
      console.log("countries", filterGroup)
      <MenuToggle
        menu="countries"
        context={countries: filterGroup.filters, onFilterToggle: @props.onFilterToggle}
        onToggle={@props.onFilterGroupClick}>
        {filterGroup.name}
      </MenuToggle>
    else
      <span>{filterGroup.name}</span>

  renderSection: (section) ->
    menuItems =
      for filterGroup in section.filters
        <li className="menu-item" key={filterGroup.name}>
          {@renderMenu(filterGroup)}
        </li>

    [
      <h2>{section.name}</h2>
      <ul className="menu-list">
        {menuItems}
      </ul>
    ]

  renderSections: ->
    for section in @props.filters
      @renderSection(section)

  render: ->
    <div className="filters-menu">
      {@renderSections()}
    </div>
