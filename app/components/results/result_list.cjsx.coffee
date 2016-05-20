ResultItem = require('components/results/result_item')
SelectableList = require('components/shared/selectable_list')
TranslationHelper = require('mixins/translation_helper')
InfiniteScroll = require('mixins/infinite_scroll')

UserActions = require('actions/user_actions')
UserStore = require('stores/user_store')
SearchStore = require('stores/search_store')
config = require('config')

module.exports = React.createClass
  displayName: 'ResultList'

  mixins: [TranslationHelper, InfiniteScroll]
  baseTranslation: 'search_page.result_list'

  propTypes:
    results: React.PropTypes.array.isRequired
    resultsCount: React.PropTypes.number.isRequired
    onLoadMore: React.PropTypes.func
    toggleSelect: React.PropTypes.func
    onAllowUserToFetchMorePages: React.PropTypes.func

  getDefaultProps: ->
    onLoadMore: ->
    onAllowUserToFetchMorePages: ->

  componentWillMount: ->
    @userLoggedIn = !!UserStore.state.user
    @unsubscribeUser = UserStore.listen(@onUserStoreUpdated)
    @unsubscribeSearch = SearchStore.listen(@onSearchStoreUpdated)

  componentWillUnmount: ->
    @unsubscribeToLoadMore?()
    @unsubscribeUser()
    @unsubscribeSearch()

  onUserStoreUpdated: (state) ->
    loggedIn = !!state.user
    if loggedIn && !@userLoggedIn
      @userLoggedIn = true
      @attachScrollListener()
      # guest users are allowed only 2 results pages, but since it tried fetching 3
      # (when we show the signup prompt) we need to bring it back down to 2 so it fetches the
      # 3rd page again (instead of the 4th page)
      if @page == 3
        @page = 2

  onSearchStoreUpdated: (state) ->
    @page = state.search.page

  saveArticles: ->
    selected = @getSelected()
    UserActions.saveArticles(selected).then =>
      flash('success', @t('on_save', count: selected.length))

  open: (csvContent) ->
    encodedUri = encodeURI(csvContent)
    window.location = encodedUri

  getSelected: ->
    @refs.selectableList.getSelected().map (child) ->
      child.props.result

  exportArticles: ->
    FetchAPI = require('lib/fetch_api')
    ids = _.pluck(@getSelected(), 'id')
    FetchAPI.create('/user/articles/export.csv', ids).then (data) =>
      url = config.apiBase + data.file
      @open(url)

  removeUserArticles: ->
    selected = @getSelected()
    UserActions.removeArticles(selected).then =>
      flash('success', @t('on_remove', count: @refs.selectableList.getSelected().length))
      @clearSelected()

  emailArticles: ->
    selected = @getSelected()
    UserActions.emailArticles(selected).then =>
      email = UserStore.state.user.email
      count = selected.length
      flash('success', @t('on_email', email: email, count: count))

  toggleSelectAll: ->
    @refs.selectableList.toggleSelectAll()

  clearSelected: ->
    @refs.selectableList.clearSelected()

  loadMore: (page) ->
    @unsubscribeToLoadMore = @props.onLoadMore?(page)

  hasMore: ->
    # no more if there are no results to begin with (in case of discrepancy between resultCount)
    # should always start with a non-empty array of results before we can request more
    return false if @props.results.length <= 0
    @props.resultsCount > 0 and @props.resultsCount > @props.results.length

  hasSelectedItems: ->
    @refs.selectableList.hasSelectedItems()

  renderList: ->
    if @props.results.length == 0
      return <p className="no-results">{@t('no_results')}</p>

    @props.results.map (result, i) =>
      <ResultItem {...@props} result={result} resultNumber={i + 1} key="result-#{i}" />

  render: ->
    <SelectableList ref="selectableList" showSelectAll={false} items={@props.results} className="result-list" toggleSelect={@props.toggleSelect}>
      {@renderList()}
    </SelectableList>
