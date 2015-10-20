Button = require('components/shared/button')
SearchBar = require('components/search/search_bar')
LayerToggle = require('components/layered_navigation/layer_toggle')
FilterNormalizationService = require('services/filter_normalization_service')
TranslationHelper = require('mixins/translation_helper')

UserActions = require('actions/user_actions')

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
    if @state.showingFiltersMenu && @props.search?.results_count != null
      <div className="result-count">
        <a href="#" onClick={@handleBackToSearchResults}>{@t('view_results_count', results_count: @props.search.results_count)}</a>
      </div>

  saveSearch: ->
    search = @props.search
    @props.search.saved = !@props.search.saved
    @forceUpdate()
    search = _.pick(search, 'query', 'applied_filters', 'sort_by', 'saved', 'subscribed')
    UserActions.saveSearch(search)

  saveAndSubscribe: ->
    @props.search.subscribed = !@props.search.subscribed
    @saveSearch()

  render: ->
    <div className="search-box">
      <SearchBar search={@props.search} onSearch={@props.onSearch} />
      <div className="layer-toggles clearfix">
        <LayerToggle menu="help" onToggle={@props.onShowMenu}>
          {@t('tips')}
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
        <div className="saved-search-buttons">
          <Button className="btn-save #{'btn-save-on' if @props.search.saved}" onClick={@saveSearch}>{@t('save')}</Button>
          <Button className="btn-save-and-subscribe" onClick={@saveAndSubscribe}>{@t('save_and_subscribe')}</Button>
        </div>
      </div>
      {@renderResultCountFooter()}
    </div>
