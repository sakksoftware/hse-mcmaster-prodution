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
    menu="filters"
    menu = "countries" if filterGroup.name == "countries"
    menu = "dateRange" if filterGroup.name == "date_range"
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
      for filterGroup in section.filters
        <li className="menu-item" key={filterGroup.name}>
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
