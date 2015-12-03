API = require('lib/api')
SavedSearchList = require('components/saved_search/saved_search_list')
TranslationHelper = require('mixins/translation_helper')

UserActions = require('actions/user_actions')
UserStore = require('stores/user_store')

module.exports = React.createClass
  displayName: 'SavedSearchPage'

  mixins: [TranslationHelper]
  baseTranslation: 'saved_search_page'

  getInitialState: ->
    searches: UserStore.state.searches
    subscribedOnly: false
    curatedSearches: UserStore.state.curatedSearches

  componentWillMount: ->
    UserActions.loadSearches()
    UserActions.loadCuratedSearches()
    @unsubscribeUserStore = UserStore.listen(@userStoreUpdated)

  componentWillUnmount: ->
    @unsubscribeUserStore()

  componentDidMount: ->
    document.title = "#{@t('title')} | #{@t('/site_name')}"

  userStoreUpdated: (data) ->
    @setState(searches: data.searches, curatedSearches: data.curatedSearches)

  toggleSubscribedOnly: ->
    @setState(subscribedOnly: !@state.subscribedOnly)

  getSearches: ->
    if @state.subscribedOnly
      @state.searches.filter (s) -> s.subscribed
    else
      @state.searches

  getCuratedSearches: ->
    if @state.subscribedOnly
      @state.curatedSearches.filter (s) -> s.subscribed
    else
      @state.curatedSearches

  render: ->
    <div className="saved-search-page">
      <div className="saved-search-header clearfix">
        <h1>{@t('title')}</h1>
        <label className="saved-search-subscribed-only action">{@t('subscribed_only')}<input type="checkbox" onClick={@toggleSubscribedOnly} /></label>
      </div>
      <SavedSearchList searches={@getSearches()} />
      <h1>{@t('curated_searches')}</h1>
      <SavedSearchList searches={@getCuratedSearches()} />
    </div>
