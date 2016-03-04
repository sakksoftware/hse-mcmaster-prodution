Link = require('components/shared/link')
SearchBar = require('components/search/search_bar')
SavedSearchButtons = require('components/search/saved_search_buttons')
LayerToggle = require('components/layered_navigation/layer_toggle')
FilterNormalizationService = require('services/filter_normalization_service')
TranslationHelper = require('mixins/translation_helper')
Button = require('components/shared/button')
Hotspot = require('components/tour/hotspot')

SearchActions = require('actions/search_actions')
TourActions = require('actions/tour_actions')
UserStore = require('stores/user_store')

module.exports = React.createClass
  displayName: 'SearchBox'
  mixins: [FilterNormalizationService, TranslationHelper]
  baseTranslation: 'search_page.search_box'
  propTypes:
    search: React.PropTypes.object
    onSearch: React.PropTypes.func.isRequired
    onShowMenu: React.PropTypes.func.isRequired
    overlayContent: React.PropTypes.string
    showSavedSearchButtons: React.PropTypes.bool
    onSaveAndSubscribe: React.PropTypes.func

  getDefaultProps: ->
    showSavedSearchButtons: true

  getInitialState: ->
    showingFiltersMenu: false

  componentWillMount: ->
    TourActions.addStep
      key: 'advanced_search'
      element: '.advanced-search'
      position: 'bottom'
      order: 3

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
        <a href="#" onClick={@handleBackToSearchResults}>{@t('view_results_count', count: @props.search.results_count)}</a>
      </div>

  renderSavedSearchButtons: ->
    if @props.showSavedSearchButtons && UserStore.isLoggedIn()
      <SavedSearchButtons search={@props.search} onSaveAndSubscribe={@props.onSaveAndSubscribe} />

  renderRelatedArticle: ->
    related_article = @props.search.related_article

    if related_article
      <p className="related-article">
        {@t('related_article')}
        <Link to="articles/#{related_article.id}">{related_article.title}</Link>
        <Button className="btn-clear" onClick={@clearSearch}>[{@t('/clear')}]</Button>
      </p>

  clearSearch: ->
    SearchActions.clearRelatedArticle()

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
        {@renderSavedSearchButtons()}
        <div className="advanced-search-wrapper">
          <Hotspot tourKey="advanced_search" />
          <Link to="/search" className="advanced-search">{@t('advanced_search')}</Link>
        </div>
      </div>
      {@renderResultCountFooter()}
      {@renderRelatedArticle()}
    </div>
