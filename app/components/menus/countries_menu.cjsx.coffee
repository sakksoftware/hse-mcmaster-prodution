MenuFilterItem = require('components/menus/menu_filter_item')
ViewHelpers = require('mixins/view_helpers')

module.exports = React.createClass
  displayName: 'CountriesMenu'

  mixins: [ViewHelpers]

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
    <div className="countries-menu filters-menu">
      <input placeholder="Type country name" onChange={@filterCountries} className="country-filter" ref="countryFilter" />
      <ul className="countries-menu-predicate menu-list nested-menu">
        <li data-value="target" className="menu-item menu-filter-item"><a href="#">Target of document</a></li>
        <li data-value="contains" className="menu-item menu-filter-item"><a href="#">At least one study from are</a></li>
      </ul>
      <ul className="countries-list menu-list nested-menu">
        {@ifEmpty(@renderCountries(), "No countries found.")}
      </ul>
    </div>
