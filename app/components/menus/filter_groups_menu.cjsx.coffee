AppliedFilters = require('components/search/applied_filters')
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

  onRemoveFilterGroup: (filter) ->
    # temporary toggle on so we can toggle it off!
    filter.applied = true
    @onToggleFilter(filter)

  getTitle: (section, filterGroup) ->
    "Select #{section.title}: #{filterGroup.title}"

  getMenuContext: (filterGroup) ->
    filterGroup: filterGroup
    filters: filterGroup.filters
    onToggleFilter: @onToggleFilter
    overlayContent: @overlayContent

  getMenuName: (filterGroup) ->
    menu = "filters"
    menu = "countries" if filterGroup.type == "countries"
    menu = "dateRange" if filterGroup.type == "date_range"
    menu

  # TODO: a little bit dirty, maybe should re-think the
  # * option 1: use references to trigger "toggle" method on the LayerToggle,
  #   will need to find the right reference
  # * option 2: pass a layer toggle into AppliedFilters component
  onShowFilterGroupWrapper: (section, filterGroup) ->
    menu = @getMenuName(filterGroup)
    title = @getTitle(section, filterGroup)

    @onShowFilterGroup(menu, title, @getMenuContext(filterGroup))

  renderMenu: (section, filterGroup) ->
    <LayerToggle
      menu={@getMenuName(filterGroup)}
      title={@getTitle(section, filterGroup)}
      context={@getMenuContext(filterGroup)}
      onToggle={@onShowFilterGroup}>
      {filterGroup.title}
    </LayerToggle>

  renderSection: (section) ->
    menuItems =
      if section.filters
        for filterGroup, i in section.filters
          className = "menu-item"
          className += " filter-group-#{filterGroup.type.replace('_', '-')}" if filterGroup.type
          <li className={className} key="filter-group-#{i}">
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
      <AppliedFilters filters={@filters} onRemoveFilter={@onRemoveFilterGroup} onShowFilterGroup={@onShowFilterGroupWrapper} />
      {@renderSections()}
    </div>
