MenuToggle = require('components/menus/menu_toggle')

module.exports = React.createClass
  displayName: 'FilterGroupsMenu'
  propTypes:
    filters: React.PropTypes.array.isRequired
    onFilterToggle: React.PropTypes.func.isRequired
    onFilterGroupClick: React.PropTypes.func.isRequired

  renderMenu: (section, filterGroup) ->
    menu="filters"
    # TODO: would not work when we do translations
    menu = "countries" if filterGroup.name == "Countries"

    <MenuToggle
      menu={menu}
      context={filters: filterGroup.filters, onFilterToggle: @props.onFilterToggle, section: section.name, filterGroup: filterGroup.name}
      onToggle={@props.onFilterGroupClick}>
      {filterGroup.name}
    </MenuToggle>

  renderSection: (section) ->
    menuItems =
      for filterGroup in section.filters
        <li className="menu-item" key={filterGroup.name}>
          {@renderMenu(section, filterGroup)}
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
    <div className="filters-menu-groups nested-menu">
      {@renderSections()}
    </div>
