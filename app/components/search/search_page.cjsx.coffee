Button = ReactBootstrap.Button
FilterActions = require('actions/filter_actions')
SearchActions = require('actions/search_actions')
SearchBox = require('components/search/search_box')
ResultBox = require('components/results/result_box')
GuidedQuestionsBox = require('components/guided_questions/guided_questions_box')
FilterGroupsMenu = require('components/menus/filter_groups_menu')

FilterNormalizationService = require('services/filter_normalization_service')
SearchSerializationService = require('services/search_serialization_service')

UserStore = require('stores/user_store')
SearchStore = require('stores/search_store')

TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'SearchPage'

  mixins: [FilterNormalizationService, SearchSerializationService, TranslationHelper]
  baseTranslation: ''

  propTypes:
    onShowMenu: React.PropTypes.func.isRequired
    dismissMenu: React.PropTypes.func.isRequired

  # steps
  # pending_search
  # searching
  # results
  getInitialState: ->
    search: SearchStore.state.search
    filtersLoaded: false
    step: 'pending_search'
    guidedSearch: UserStore.state.guidedSearch

  componentWillMount: ->
    @unsubscribeUser = UserStore.listen(@userStoreUpdated)
    @unsubscribeSearch = SearchStore.listen(@searchStoreUpdated)

    # TODO: remove when passing results as an attribute from server a bit hacky now
    if @state.search.query == null
      @fetchFilters()
    else
      @fetchResults()

  componentWillUnmount: ->
    @unsubscribeUser()

  userStoreUpdated: (state) ->
    @setState(guidedSearch: state.guidedSearch)

  searchStoreUpdated: (state) ->
    @setState(search: state.search)

  fetchFilters: ->
    FilterActions.loadFilters UserStore.state.language, @handleLoadFilters, @handleError

  fetchResults: ->
    @setState(step: 'searching')
    SearchActions.search(@state.search, UserStore.state.language).then =>
      @setState(step: 'results', filtersLoaded: true)

  handleSearch: (query) ->
    @state.search.query = query
    @fetchResults()

  handleLoadFilters: (data) ->
    @state.search.filters = data.filters
    @setState(filtersLoaded: true)
    @forceUpdate()

  handleLoadMore: (page) ->
    @state.search.page = page
    SearchActions.search(@state.search, UserStore.state.language)

  handleSortChange: (sortBy) ->
    SearchActions.sortBy(sortBy)

  getOverylayContent: ->
    if @state.search?.results_count
      "#{@state.search.results_count} results"

  renderDesktopFiltersMenu: ->
    if @state.filtersLoaded
      <div className="filter-groups-menu-wrapper">
        <div className="filter-groups-menu-title">
          {@t('menus.filter_groups.title')}
        </div>
        <FilterGroupsMenu context={
          onShowFilterGroup: @props.onShowMenu
          overlayContent: @getOverylayContent()
        } />
      </div>

  renderGuidedSearch: ->
    if @state.guidedSearch
      <GuidedQuestionsBox />

  renderResults: ->
    if @state.step == 'searching'
      <div className="result-box">
        <Loader loaded={@state.step == 'results'} />
      </div>
    else if @state.step == 'results'
      <ResultBox sortBy={@state.search.sort_by}
        results={@state.search.results}
        resultsCount={@state.search.results_count}
        onSortChange={@handleSortChange}
        onLoadMore={@handleLoadMore}
      />

  render: ->
    <div className="search-page">
      <SearchBox
        search={@state.search}
        onSearch={@handleSearch}
        onShowMenu={@props.onShowMenu}
        dismissMenu={@props.dismissMenu}
        overlayContent={@getOverylayContent()}
      />
      {@renderGuidedSearch()}
      {@renderDesktopFiltersMenu()}
      {@renderResults()}
    </div>
