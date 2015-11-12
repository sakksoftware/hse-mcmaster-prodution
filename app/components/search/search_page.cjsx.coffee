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
NotificationActions = require('actions/notification_actions')

Transition = React.addons.CSSTransitionGroup

module.exports = React.createClass
  displayName: 'SearchPage'

  mixins: [FilterNormalizationService, SearchSerializationService, TranslationHelper]
  baseTranslation: ''

  propTypes:
    onShowMenu: React.PropTypes.func.isRequired
    dismissMenu: React.PropTypes.func.isRequired
    setOverlayContent: React.PropTypes.func.isRequired

  # steps
  # pending_search
  # searching
  # results
  getInitialState: ->
    search: SearchStore.state.search
    filtersLoaded: false
    step: 'results'
    guidedSearch: UserStore.state.guidedSearch
    showSignupPrompt: false

  componentWillMount: ->
    document.title = "#{@t('search_page.search_box.placeholder')} | #{@t('/site_name')}"

    @unsubscribeUser = UserStore.listen(@userStoreUpdated)
    @unsubscribeSearch = SearchStore.listen(@searchStoreUpdated)

    @fetchResults()

  componentWillUnmount: ->
    @unsubscribeUser()
    @unsubscribeSearch()

  userStoreUpdated: (state) ->
    @setState(guidedSearch: state.guidedSearch)

  searchStoreUpdated: (state) ->
    step = @state.step
    search = state.search

    if _.isEmpty(search.query.trim()) && _.isEmpty(search.applied_filters)
      step = 'pending_search'
    else if search.results != null
      step = 'results'

    @setState(search: state.search, step: step, errors: state.errors, filtersLoaded: true)

  fetchResults: ->
    @setState(step: 'searching')
    document.title = "#{@state.search.query} | #{@t('/site_name')}"
    SearchActions.search(@state.search)

  handleSearch: (query) ->
    @state.search.query = query
    @state.search.page = 1
    @fetchResults()

  handleLoadMore: (page) ->
    if UserStore.state.user == null && page > 2
      @setState(showSignupPrompt: true)
      return

    SearchActions.loadMore(page)

  handleSortChange: (sortBy) ->
    SearchActions.sortBy(sortBy)

  toggleSubscription: ->
    console.log('toggle subscription')
    # UserActions.

  confirmSubscriptionToggle: ->
    base = '/saved_search_page.dialog.'
    NotificationActions.showDialog(message: @t("#{base}message"), cancelText: @t("#{base}cancel"), confirmText: @t("#{base}confirm"), onConfirm: @toggleSubscription)

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
    else if @state.step == 'pending_search'
      <div className="result-box">
        {@t('search_page.result_box.pending_search')}
      </div>
    else if @state.step == 'results'
      <ResultBox sortBy={@state.search.sort_by}
        search={@state.search}
        onSortChange={@handleSortChange}
        onLoadMore={@handleLoadMore}
        onSaveAndSubscribe={@confirmSubscriptionToggle}
      />

  renderSignupPrompt: ->
    <Transition transitionName="signup-prompt-slide" component="div">
      {
        if @state.showSignupPrompt
          <SignupPrompt />
      }
    </Transition>

  render: ->
    <div className="search-page">
      <SearchBox
        search={@state.search}
        onSearch={@handleSearch}
        onShowMenu={@props.onShowMenu}
        dismissMenu={@props.dismissMenu}
        onSaveAndSubscribe={@confirmSubscriptionToggle}
      />
      {@renderGuidedSearch()}
      {@renderDesktopFiltersMenu()}
      {@renderResults()}
      {@renderSignupPrompt()}
    </div>
