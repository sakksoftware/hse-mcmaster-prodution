SearchActions = require('actions/search_actions')
UrlActions = require('actions/url_actions')
TourActions = require('actions/tour_actions')

SearchStore = require('stores/search_store')
UserStore = require('stores/user_store')

TranslationHelper = require('mixins/translation_helper')

SearchBox = require('components/search/search_box')
GuidedQuestionsBox = require('components/guided_questions/guided_questions_box')

module.exports = React.createClass
  displayName: 'HomePage'

  mixins: [TranslationHelper]
  baseTranslation: 'home_page'

  propTypes:
    onShowMenu: React.PropTypes.func.isRequired
    dismissMenu: React.PropTypes.func.isRequired

  getInitialState: ->
    guidedSearch: UserStore.state.guidedSearch

  componentWillMount: ->
    @unsubscribeUser = UserStore.listen(@userStoreUpdated)
    @search = SearchStore.state.search
    @search.query = ''
    @fetchFilters()

    TourActions.addStep
      key: 'advanced_search'
      order: 3

  componentWillUnmount: ->
    @unsubscribeUser()
    TourActions.removeStep 'advanced_search'

  componentDidMount: ->
    document.title = "#{@t('/site_name')}"

  userStoreUpdated: (state) ->
    @setState(guidedSearch: state.guidedSearch)

  fetchFilters: ->
    SearchActions.loadFilters()

  showFiltersMenu: ->
    router = require('lib/router')
    router.visit('/search')
    @props.onShowMenu.apply(@, arguments)

  redirectToSearch: (query) ->
    UrlActions.navigateTo("/search", q: query)

  isMobile: ->
    if window.innerWidth < 1024
      true
    else
      false

  renderGuidedSearch: ->
    if @state.guidedSearch
      <GuidedQuestionsBox expanded={!@isMobile()} onShowMenu={@showFiltersMenu} />

  render: ->
    <div className="home-page">
      <div className="home-page-header">
        <h1>Health Systems Evidence</h1>
        <p className="intro">{@t('intro')}</p>
        <SearchBox
          search={@search}
          onSearch={@redirectToSearch}
          onShowMenu={@props.onShowMenu}
          dismissMenu={@props.dismissMenu}
          showSavedSearchButtons={false}
        />
      </div>
      {@renderGuidedSearch()}
    </div>
