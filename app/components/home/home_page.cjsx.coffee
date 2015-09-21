SearchActions = require('actions/search_actions')
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

  componentWillUnmount: ->
    @unsubscribeUser()

  userStoreUpdated: (state) ->
    @setState(guidedSearch: state.guidedSearch)

  fetchFilters: ->
    SearchActions.loadFilters()

  showFiltersMenu: ->
    router = require('lib/router')
    router.visit('/search')
    @props.onShowMenu.apply(@, arguments)

  redirectToSearch: (query) ->
    SearchStore.state.search.query = query
    router = require('lib/router')
    router.visit('/search')

  renderGuidedSearch: ->
    if @state.guidedSearch
      <GuidedQuestionsBox expanded=true onShowMenu={@showFiltersMenu} />

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
        />
      </div>
      {@renderGuidedSearch()}
    </div>
