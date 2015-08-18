LayerToggle = require('components/layered_navigation/layer_toggle')

module.exports = React.createClass
  displayName: 'FilterGroupsMenu'
  propTypes:
    context: React.PropTypes.object

  componentWillMount: ->
    @filters = @props.context.filters
    @onToggleFilter = @props.context.onToggleFilter
    @onShowFilterGroup = @props.context.onShowFilterGroup
    @overlayContent = @props.context.overlayContent

  renderMenu: (section, filterGroup) ->
    menu = "filters"
    menu = "countries" if filterGroup.type == "countries"
    menu = "dateRange" if filterGroup.type == "date_range"
    title = "Select #{section.title}: #{filterGroup.name}"

    <LayerToggle
      menu={menu}
      title={title}
      context={
        filterGroup: filterGroup
        filters: filterGroup.filters
        onToggleFilter: @onToggleFilter
        overlayContent: @overlayContent
      }
      onToggle={@onShowFilterGroup}>
      {filterGroup.title}
    </LayerToggle>

  renderSection: (section) ->
    menuItems =
      if section.filters
        for filterGroup in section.filters
          className = "menu-item"
          className += " filter-group-#{filterGroup.type.replace('_', '-')}" if filterGroup.type
          <li className={className} key="filter-group-#{filterGroup.id}">
            {@renderMenu(section, filterGroup)}
          </li>

    [
      <h2>{section.title}</h2>
      <ul className="menu-list">
        {menuItems}
      </ul>
    ]

  renderSections: ->
    for section in @filters
      @renderSection(section)

  render: ->
    <div className="filter-groups-menu nested-menu">
      {@renderSections()}
    </div>
