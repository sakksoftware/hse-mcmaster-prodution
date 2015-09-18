SearchActions = require('actions/search_actions')
SearchStore = require('stores/search_store')
UserStore = require('stores/user_store')

SearchBox = require('components/search/search_box')
GuidedQuestionsBox = require('components/guided_questions/guided_questions_box')

module.exports = React.createClass
  displayName: 'HomePage'

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
    SearchActions.search(SearchStore.state.search).then =>
      @setState(step: 'pending_search', filtersLoaded: true)

  redirectToSearch: (query) ->
    @search.query = query
    router = require('lib/router')
    router.visit('/search')

  renderGuidedSearch: ->
    if @state.guidedSearch
      <GuidedQuestionsBox onShowMenu={@props.onShowMenu} />

  render: ->
    <div className="home-page">
      <div className="home-page-header">
        <h1>Health Systems Evidence</h1>
        <p className="intro">
          The world's most compherhansive, freeaccess poinnt with for evidence support policy makers,
          stakeholders and researches interested in how to strengthen or reform health systems or in how to
          get cost-effective programs services and drugs to those who need them
        </p>
        <SearchBox
          search={@search}
          onSearch={@redirectToSearch}
          onShowMenu={@props.onShowMenu}
          dismissMenu={@props.dismissMenu}
        />
      </div>
      {@renderGuidedSearch()}
    </div>
