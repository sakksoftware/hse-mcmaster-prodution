LayerToggle = require('components/layered_navigation/layer_toggle')

module.exports = React.createClass
  displayName: 'FilterGroupsMenu'
  propTypes:
    context: React.PropTypes.object

  componentWillMount: ->
    @filters = @props.context.filters
    @onToggleFilter = @props.context.onToggleFilter
    @onShowFilterGroup = @props.context.onShowFilterGroup

  renderMenu: (section, filterGroup) ->
    menu="filters"
    # TODO: would not work when we do translations
    menu = "countries" if filterGroup.name == "Countries"
    title = "Select #{section.name}: #{filterGroup.name}"

    <LayerToggle
      menu={menu}
      title={title}
      context={filters: filterGroup.filters, onToggleFilter: @onToggleFilter }
      onToggle={@onShowFilterGroup}>
      {filterGroup.name}
    </LayerToggle>

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
    for section in @filters
      @renderSection(section)

  render: ->
    <div className="filters-menu-groups nested-menu">
      {@renderSections()}
    </div>
