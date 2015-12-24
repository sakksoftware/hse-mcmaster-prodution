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

  toggleSubscriptionSavedSearch: (saved_search) ->
    UserActions.toggleSubscribeToSavedSearch(saved_search.id, saved_search.subscribed)

  toggleSubscriptionCuratedSearch: (curated_search) ->
    UserActions.toggleSubscribeToCuratedSearch(curated_search)

  render: ->
    <div className="saved-search-page">
      <div className="saved-searches">
        <div className="saved-search-header clearfix">
          <h1>{@t('title')}</h1>
          <label className="saved-search-subscribed-only action">{@t('subscribed_only')}<input type="checkbox" onClick={@toggleSubscribedOnly} /></label>
        </div>
        {
          if @state.searches.length > 0
            <SavedSearchList searches={@getSearches()} toggleSubscription={@toggleSubscriptionSavedSearch} />
          else
            <div className="saved-search-list">
              <ol className="saved-search-list-content list">
                <li className="saved-search-item list-item">{@t('no_saved_searches')}</li>
              </ol>
            </div>
        }
      </div>
      {
        if !_.isEmpty(@getCuratedSearches())
          <div className="curated-searches">
            <h1>{@t('curated_searches')}</h1>
            <SavedSearchList searches={@getCuratedSearches()} toggleSubscription={@toggleSubscriptionCuratedSearch} showHeader={false} showSelect={false}/>
          </div>
      }
    </div>
