Button = ReactBootstrap.Button
SearchActions = require('actions/search_actions')

SearchBox = require('components/search/search_box')
ResultBox = require('components/results/result_box')
GuidedQuestionsBox = require('components/guided_questions/guided_questions_box')
FilterGroupsMenu = require('components/menus/filter_groups_menu')
SignupPrompt = require('components/search/signup_prompt')

FilterNormalizationService = require('services/filter_normalization_service')
SearchSerializationService = require('services/search_serialization_service')

UserActions = require('actions/user_actions')

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
    search: SearchStore.state.search || {}
    filtersLoaded: false
    step: 'results'
    guidedSearch: UserStore.state.guidedSearch
    showSignupPrompt: false

  componentWillMount: ->
    document.title = "#{@t('search_page.search_box.placeholder')} | #{@t('/site_name')}"

    @unsubscribeUser = UserStore.listen(@userStoreUpdated)
    @unsubscribeSearch = SearchStore.listen(@searchStoreUpdated)

  componentWillUnmount: ->
    @unsubscribeUser()
    @unsubscribeSearch()

  userStoreUpdated: (state) ->
    @setState(guidedSearch: state.guidedSearch)

  searchStoreUpdated: (state) ->
    step = @state.step
    search = _.deepClone(state.search)
    
    if @_isPendingSearch(search)
      step = 'pending_search'
    else if !state.loaded
      step = "searching"
    else if search.results != null
      step = 'results'

    @setState(search: search, step: step, filtersLoaded: true)

  fetchResults: ->
    @setState(step: 'searching') if @state.step != 'searching'
    document.title = "#{@state.search.query} | #{@t('/site_name')}"
    SearchActions.search(@state.search)

  handleSearch: (query) ->
    search = _.clone(@state.search)
    search.query = query
    search.page = 1
    @setState { search: search, step: 'searching' }, =>
      @fetchResults()

  handleLoadMore: (page) ->
    if UserStore.state.user == null && page > 2
      @setState(showSignupPrompt: true)
      return

    promise = SearchActions.loadMore(page)
    promise

  handleSortChange: (sortBy) ->
    SearchActions.sortBy(sortBy)

  toggleSubscription: ->
    UserActions.toggleSubscribeToSearch(@state.search).then (saved_search) =>
      if saved_search.subscribed
        flash('success', @t('search_page.on_save_and_subscribe'))
      else
        flash('success', @t('search_page.on_unsubscribe'))

  confirmSubscriptionToggle: ->
    base = '/saved_search_page.dialog.'
    NotificationActions.showDialog(message: @t("#{base}message"), cancelText: @t("#{base}cancel"), confirmText: @t("#{base}confirm"), onConfirm: @toggleSubscription)

  _isPendingSearch: (search) ->
    _.isEmpty(search.query.trim()) && _.isEmpty(search.applied_filters) && _.isEmpty(search.related_article)

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
