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

  updateUrl: ->
    Router = require('lib/router')
    Router.update(@serializeSearchUrl(@state.search))

  handleSearch: (query) ->
    @state.search.query = query
    @updateUrl()
    @fetchResults()

  handleSortChange: (sortBy) ->
    @state.search.sort_by = sortBy
    @updateUrl()
    @fetchResults()

  changeFilterValue: (filter, value) ->
    # optimistic update
    filter.applied = value
    @updateUrl()
    @fetchResults()

  changeParentFilterValue: (parentFilter, value) ->
    parentFilter.applied = value
    for filter in parentFilter.filters
      filter.applied = value
      if filter.filters
        @changeParentFilterValue(filter, value)

  handleNestedFilterToggle: (filter) ->
    @changeParentFilterValue(filter, !filter.applied)
    @updateUrl()
    @fetchResults()

  handleFilterToggle: (filter) ->
    if filter.filters
      return @handleNestedFilterToggle(filter)

    if filter.applied
      @handleFilterRemove(filter)
    else
      @handleFilterAdded(filter)

  handleFilterAdded: (filter) ->
    @changeFilterValue(filter, true)

  handleFilterRemove: (filter) ->
    @changeFilterValue(filter, false)

  # TODO: refactor search to come from a store like jon suggested
  # that way we don't have to pass akward callbacks around
  findFilter: (filterId, filters) ->
    for filter in filters
      if filter.id == filterId
        return filter
      else if filter.filters
        if result = @findFilter(filterId, filter.filters)
          return result

    return null

  addFilterById: (filterId) ->
    filter = @findFilter(filterId, @state.search.filters)
    @changeFilterValue(filter, true)

  handleLoadFilters: (data) ->
    @state.search.filters = data.filters
    @setState(filtersLoaded: true)
    @forceUpdate()

  handleLoadMore: (page) ->
    @state.search.page = page
    SearchActions.search(@state.search, UserStore.state.language)

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
          filters: @state.search.filters
          onToggleFilter: @handleFilterToggle
          onShowFilterGroup: @props.onShowMenu
          overlayContent: @getOverylayContent()
        } />
      </div>

  renderGuidedSearch: ->
    if @state.guidedSearch
      <GuidedQuestionsBox onAddFilterById={@addFilterById} />

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
        onToggleFilter={@handleFilterToggle}
        onAddFilter={@handleFilterAdded}
        onShowMenu={@props.onShowMenu}
        dismissMenu={@props.dismissMenu}
        overlayContent={@getOverylayContent()}
      />
      {@renderGuidedSearch()}
      {@renderDesktopFiltersMenu()}
      {@renderResults()}
    </div>
