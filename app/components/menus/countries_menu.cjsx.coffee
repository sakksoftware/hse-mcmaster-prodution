allCountries = require('constants/countries_list')

module.exports = React.createClass
  displayName: 'CountriesMenu'

  getInitialState: ->
    countries: allCountries

  filterCountries: ->
    query = @refs.countryFilter.getDOMNode().value
    if _.isEmpty(query)
      countries = allCountries
    else
      countries = _(@state.countries).filter (country) ->
        country.name.toLowerCase().indexOf(query) >= 0
    @setState(countries: countries)

  renderCountries: ->
    _.map @state.countries, (country) ->
      <li data-value={country.code} className="coutnry-item menu-item" key={country.code}>{country.name}</li>

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