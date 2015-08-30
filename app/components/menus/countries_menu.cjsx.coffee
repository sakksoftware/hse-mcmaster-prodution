MenuFilterItem = require('components/menus/menu_filter_item')
ViewHelpers = require('mixins/view_helpers')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'CountriesMenu'

  mixins: [ViewHelpers, TranslationHelper]
  baseTranslation: 'menus.countries'

  propTypes:
    context: React.PropTypes.object

  componentWillMount: ->
    @filters = @props.context.filters
    @filterGroup = @props.context.filterGroup
    @onToggleFilter = (filter) =>
      @filterGroup.applied = true
      @filterGroup.mode = @state.mode
      if filter != @filterGroup
        @props.context.onToggleFilter(filter)
      @forceUpdate()
    @setState(countries: @filters, mode: @filterGroup.mode)

  getInitialState: ->
    countries: []
    mode: ''

  getAppliedFilters: ->
    _(@filters).filter (f) -> f.applied

  setMode: (mode) ->
    (e) =>
      e.preventDefault()
      return if mode == @state.mode

      @setState(countries: @state.countries, mode: mode)
      appliedFilters = @getAppliedFilters()

      # foce search if there are country filters already applied
      if appliedFilters.length > 0
        @onToggleFilter(@filterGroup)

  filterCountries: ->
    query = @refs.countryFilter.getDOMNode().value
    if _.isEmpty(query)
      countries = @filters
    else
      countries = _(@state.countries).filter (country) ->
        country.title.toLowerCase().indexOf(query.toLowerCase()) >= 0
    @setState(countries: countries, mode: @state.mode)

  renderCheckMark: (mode) ->
    if @state.mode == mode
      <i className="checkmark"></i>

  renderCountries: ->
    _.map @state.countries, (filter) =>
      <MenuFilterItem filter={filter} key="filter-#{filter.id}" onToggle={@onToggleFilter} />

  render: ->
    <div className="countries-menu filters-menu">
      <input placeholder={@t('placeholder')} onChange={@filterCountries} className="country-filter" ref="countryFilter" />
      <ul className="countries-menu-predicate menu-list nested-menu">
        <li data-value="target" className="menu-item menu-filter-item">
          <a className="menu-item-text" onClick={@setMode('target')}>
            {@t('predicates.target')}
            {@renderCheckMark('target')}
          </a>
        </li>
        <li data-value="contains" className="menu-item menu-filter-item">
          <a className="menu-item-text" onClick={@setMode('at_least_one_study')}>
            {@t('predicates.at_least_one_study')}
            {@renderCheckMark('at_least_one_study')}
          </a>
        </li>
      </ul>
      <ul className="countries-list menu-list nested-menu">
        {@ifEmpty(@renderCountries(), @t('no_countries_found'))}
      </ul>
    </div>
