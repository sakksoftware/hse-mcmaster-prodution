SearchBar = require('components/search/search_bar')
LayerToggle = require('components/layered_navigation/layer_toggle')
FilterNormalizationService = require('services/filter_normalization_service')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'SearchBox'
  mixins: [FilterNormalizationService, TranslationHelper]
  baseTranslation: 'search_page.search_box'
  propTypes:
    search: React.PropTypes.object
    onSearch: React.PropTypes.func.isRequired
    onShowMenu: React.PropTypes.func.isRequired
    overlayContent: React.PropTypes.string

  getInitialState: ->
    showingFiltersMenu: false

  getAppliedFilters: ->
    filters = @getFiltersArray(@props.search.filters || [])
    filters = filters.filter((e) => e.applied)

    # delete coutnries filter fro
    filters = _.reject filters, (f) -> f.type.match(/countries_/)
    filters

  handleClickFiltersButton: ->
    @props.onShowMenu.apply(@, arguments)
    @setState(showingFiltersMenu: true)

  handleBackToSearchResults: (ev) ->
    ev.preventDefault()
    @props.dismissMenu()

  renderFilterCount: ->
    count = @getAppliedFilters()?.length || 0
    if count > 0
      <span className="filter-count">{count}</span>

  renderResultCountFooter: ->
    if @state.showingFiltersMenu && @props.search?.results_count
      <div className="result-count">
        <a href="#" onClick={@handleBackToSearchResults}>{@t('view_results_count', results_count: @props.search.results_count)}</a>
      </div>

  render: ->
    <div className="search-box">
      <SearchBar search={@props.search} onSearch={@props.onSearch} />
      <div className="layer-toggles">
        <LayerToggle menu="help" onToggle={@props.onShowMenu}>
          <span className="icon"></span>{@t('tips')}
        </LayerToggle>
        <LayerToggle
          menu="filterGroups"
          context={
            filters: @props.search.filters
            onShowFilterGroup: @props.onShowMenu
            overlayContent: @props.overlayContent
          }
          onToggle={@handleClickFiltersButton}
        >
          {@t('filters')}
          {@renderFilterCount()}
        </LayerToggle>
      </div>
      {@renderResultCountFooter()}
    </div>
