MenuFilterItem = require('components/menus/menu_filter_item')

module.exports = React.createClass
  displayName: 'CountriesMenu'

  propTypes:
    filters: React.PropTypes.array.isRequired
    onToggleFilter: React.PropTypes.func.isRequired

  getInitialState: ->
    countries: @props.filters

  filterCountries: ->
    query = @refs.countryFilter.getDOMNode().value
    if _.isEmpty(query)
      countries = @props.filters
    else
      countries = _(@state.countries).filter (country) ->
        country.name.toLowerCase().indexOf(query.toLowerCase()) >= 0
    @setState(countries: countries)

  renderCountries: ->
    _.map @state.countries, (filter) =>
      <FilterItem filter={filter} key="filter-#{filter.id}" onToggle={@props.onToggleFilter} />

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
