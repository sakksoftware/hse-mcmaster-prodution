MenuFilterItem = require('components/menus/menu_filter_item')

module.exports = React.createClass
  displayName: 'CountriesMenu'

  propTypes:
    context: React.PropTypes.object

  componentWillMount: ->
    @filters = @props.context.filters
    @onToggleFilter = (filter) =>
      @props.context.onToggleFilter(filter)
      @forceUpdate()
    @setState(countries: @filters)

  getInitialState: ->
    countries: []

  filterCountries: ->
    query = @refs.countryFilter.getDOMNode().value
    if _.isEmpty(query)
      countries = @filters
    else
      countries = _(@state.countries).filter (country) ->
        country.name.toLowerCase().indexOf(query.toLowerCase()) >= 0
    @setState(countries: countries)

  renderCountries: ->
    _.map @state.countries, (filter) =>
      <MenuFilterItem filter={filter} key="filter-#{filter.id}" onToggle={@onToggleFilter} />

  render: ->
    <div className="countries-menu">
      <input placeholder="Type country name" onChange={@filterCountries} ref="countryFilter" />
      <ul className="countries-menu-predicate menu-list">
        <li data-value="target" className="menu-item">Target of document</li>
        <li data-value="contains" className="menu-item">At least one study from are</li>
      </ul>
      <ul className="countries-list menu-list">
        {@renderCountries()}
      </ul>
    </div>
