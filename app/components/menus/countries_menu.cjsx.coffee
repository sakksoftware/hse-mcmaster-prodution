MenuFilterItem = require('components/menus/menu_filter_item')
ViewHelpers = require('mixins/view_helpers')
TranslationHelper = require('mixins/translation_helper')
SearchActions = require('actions/search_actions')
SearchStore = require('stores/search_store')

module.exports = React.createClass
  displayName: 'CountriesMenu'

  mixins: [ViewHelpers, TranslationHelper]
  baseTranslation: 'menus.countries'

  propTypes:
    context: React.PropTypes.object

  componentWillMount: ->
    @filters = @props.context.filters
    @filterGroup = _.clone(@props.context.filterGroup)
    mode = @filterGroup.attributes?[0] || @state.mode
    @setState(countries: @filters, mode: mode)
    @unsubscribe = SearchStore.listen(@onFiltersUpdated)

  componentWillUnmount: ->
    @unsubscribe()

  getInitialState: ->
    countries: []
    mode: 'target'

  onFiltersUpdated: ->
    @filterGroup = SearchStore.findFilter(@filterGroup)
    @filters = @filterGroup.filters
    @filterCountries()

  onToggleFilter: (filter) ->
    SearchActions.toggleCountryFilter(filter, @filterGroup, @state.mode)

  getAppliedFilters: ->
    _(@filters).filter (f) -> f.applied

  setMode: (mode) ->
    (e) =>
      e.preventDefault()
      return if mode == @state.mode

      @setState(mode: mode)
      appliedFilters = @getAppliedFilters()

      # force search if there are country filters already applied
      if appliedFilters.length > 0
        _.defer =>
          @onToggleFilter(@filterGroup)

  filterCountries: ->
    query = @refs.countryFilter.getDOMNode().value
    if _.isEmpty(query)
      countries = @filters
    else
      countries = _(@state.countries).filter (country) ->
        country.title.toLowerCase().indexOf(query.toLowerCase()) >= 0
    @setState(countries: countries)

  renderCheckMark: (mode) ->
    if @state.mode == mode
      <i className="checkmark"></i>

  renderCountries: ->
    _.map @state.countries, (f) =>
      filter = SearchStore.findFilter(f)
      return unless filter
      <MenuFilterItem filter={filter} key="filter-#{filter.id}" onToggle={@onToggleFilter} />

  renderPredicates: ->
    if @filterGroup.type == 'countries_countries'
      <ul className="countries-menu-predicate menu-list nested-menu" key="predicates">
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

  render: ->
    <div className="countries-menu filters-menu">
      <input placeholder={@t('placeholder')} onChange={@filterCountries} className="country-filter" ref="countryFilter" />
      {@renderPredicates()}
      <ul className="countries-list menu-list nested-menu">
        {@ifEmpty(@renderCountries(), @t('no_countries_found'))}
      </ul>
    </div>
