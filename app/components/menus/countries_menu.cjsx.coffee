module.exports = React.createClass
  displayName: 'CountriesMenu'

  propTypes:
    countries: React.PropTypes.array.isRequired
    onFilterToggle: React.PropTypes.func.isRequired

  getInitialState: ->
    countries: @props.countries

  filterCountries: ->
    query = @refs.countryFilter.getDOMNode().value
    if _.isEmpty(query)
      countries = allCountries
    else
      countries = _(@state.countries).filter (country) ->
        country.name.toLowerCase().indexOf(query.toLowerCase()) >= 0
    @setState(countries: countries)

  renderCheckMark: (country) ->
    if country.applied
      <i className="checkmark"></i>

  renderCountries: ->
    handleClick = (country) =>
      (e) => e.preventDefault(); @props.onFilterToggle(country)
    _.map @state.countries, (country) =>
      <li data-value={country.code} className="coutnry-item menu-item" key={country.code}>
        <a href="#" onClick={handleClick(country)}>{country.name}</a>
        {@renderCheckMark(country)}
      </li>

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
