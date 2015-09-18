Button = ReactBootstrap.Button
SearchActions = require('actions/search_actions')

SearchBox = require('components/search/search_box')
ResultBox = require('components/results/result_box')
GuidedQuestionsBox = require('components/guided_questions/guided_questions_box')
FilterGroupsMenu = require('components/menus/filter_groups_menu')
SignupPrompt = require('components/search/signup_prompt')

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
    setOverlayContent: React.PropTypes.func.isRequired

  # steps
  # searching
  # results
  getInitialState: ->
    search: SearchStore.state.search
    filtersLoaded: false
    step: 'results'
    guidedSearch: UserStore.state.guidedSearch

  componentWillMount: ->
    @unsubscribeUser = UserStore.listen(@userStoreUpdated)
    @unsubscribeSearch = SearchStore.listen(@searchStoreUpdated)

    # @pageQueue = []

    @fetchResults()

  componentWillUnmount: ->
    @unsubscribeUser()
    @unsubscribeSearch()

  userStoreUpdated: (state) ->
    @setState(guidedSearch: state.guidedSearch)

  searchStoreUpdated: (state) ->
    step = @state.step
    step = 'results' if state.search.results_count > 0
    @setState(search: state.search, step: step, errors: state.errors)

  fetchResults: ->
    @setState(step: 'searching')
    SearchActions.search(@state.search).then =>
      @setState(step: 'results', filtersLoaded: true)

  handleSearch: (query) ->
    @state.search.query = query
    @fetchResults()

  handleLoadMore: (page) ->
    if @state.errors?[0] != 'reached_search_limit'
      search = _.clone(@state.search)
      search.page = page
      SearchActions.search(search)

    # @pageQueue.push(page)
    #
    # if @pageQueue.length == 1
    #   if @state.errors?[0] == 'reached_search_limit'
    #     @pageQueue = []
    #   else
    #     execute = (page) =>
    #       search = _.clone(@state.search)
    #       search.page = page
    #       SearchActions.search(search).then =>
    #         page = @pageQueue.pop()
    #         execute(page)
    #     execute(page)

  handleSortChange: (sortBy) ->
    SearchActions.sortBy(sortBy)

  renderDesktopFiltersMenu: ->
    if @state.filtersLoaded
      <div className="filter-groups-menu-wrapper">
        <div className="filter-groups-menu-title">
          {@t('menus.filter_groups.title')}
        </div>
        <FilterGroupsMenu context={
          onShowFilterGroup: @props.onShowMenu
        } setOverlayContent={@props.setOverlayContent} />
      </div>

  renderGuidedSearch: ->
    if @state.guidedSearch
      <GuidedQuestionsBox onShowMenu={@props.onShowMenu} />

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

  renderSignupPrompt: ->
    if @state.errors?[0] == 'reached_search_limit'
      <SignupPrompt />

  render: ->
    <div className="search-page">
      <SearchBox
        search={@state.search}
        onSearch={@handleSearch}
        onShowMenu={@props.onShowMenu}
        dismissMenu={@props.dismissMenu}
      />
      {@renderGuidedSearch()}
      {@renderDesktopFiltersMenu()}
      {@renderResults()}
      {@renderSignupPrompt()}
    </div>
