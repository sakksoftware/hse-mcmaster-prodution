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
    searches: []
    subscribedOnly: false

  componentWillMount: ->
    UserActions.loadSearches()
    @unsubscribeUserStore = UserStore.listen(@userStoreUpdated)

  componentWillUnmount: ->
    @unsubscribeUserStore()

  userStoreUpdated: (data) ->
    @setState(searches: data.searches)

  toggleSubscribedOnly: ->
    @setState(subscribedOnly: !@state.subscribedOnly)

  getSearches: ->
    if @state.subscribedOnly
      @state.searches.filter (s) -> s.subscribed
    else
      @state.searches

  render: ->
    <div className="saved-search-page">
      <div className="saved-search-header">
        <h1>{@t('title')}</h1>
        <label className="saved-search-subscribed-only action">{@t('subscribed_only')}<input type="checkbox" onClick={@toggleSubscribedOnly} /></label>
      </div>
      <SavedSearchList searches={@getSearches()} />
    </div>
