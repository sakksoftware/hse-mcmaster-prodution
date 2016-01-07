ResultItem = require('components/results/result_item')
SelectableList = require('components/shared/selectable_list')
TranslationHelper = require('mixins/translation_helper')
InfiniteScroll = require('mixins/infinite_scroll')

UserActions = require('actions/user_actions')
UserStore = require('stores/user_store')
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

  getDefaultProps: ->
    onLoadMore: ->

  saveArticles: ->
    selected = @getSelected()
    UserActions.saveArticles(selected).then =>
      flash('success', @t('on_save', documents_count: selected.length))

  openNewWindow: (csvContent) ->
    encodedUri = encodeURI(csvContent)
    window.open(encodedUri)

  getSelected: ->
    @refs.selectableList.getSelected().map (child) ->
      child.props.result

  exportArticles: ->
    API = require('lib/api')
    ids = _.pluck(@getSelected(), 'id')
    API = API.create('/user/articles.csv', ids.join(';')).then (data) =>
      url = config.apiBase + data.Link
      @openNewWindow(url)

  removeUserArticles: ->
    selected = @getSelected()
    UserActions.removeArticles(selected).then =>
      flash('success', @t('on_remove', searches_count: @refs.selectableList.getSelected().length))
      @clearSelected()

  emailArticles: ->
    selected = @getSelected()
    UserActions.emailArticles(selected).then =>
      email = UserStore.state.user.email
      count = selected.length
      flash('success', @t('on_email', email: email, documents_count: count))

  toggleSelectAll: ->
    @refs.selectableList.toggleSelectAll()

  clearSelected: ->
    @refs.selectableList.clearSelected()

  loadMore: (page) ->
    @props.onLoadMore?(page)

  hasMore: ->
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
