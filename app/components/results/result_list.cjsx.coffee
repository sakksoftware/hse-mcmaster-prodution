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
    onSelectToggle: React.PropTypes.func

  getDefaultProps: ->
    onLoadMore: ->
    onSelectToggle: ->

  saveArticles: ->
    UserActions.saveArticles(@refs.selectableList.getSelected()).then =>
      flash('success', @t('on_save', documents_count: @refs.selectableList.getSelected().length))

  openNewWindow: (csvContent) ->
    encodedUri = encodeURI(csvContent)
    window.open(encodedUri)

  exportArticles: ->
    ids = _.pluck(@refs.selectableList.getSelected(), 'id')
    url = "#{config.apiBase}/api/user/articles.csv?ids=#{encodeURIComponent(ids.join(';'))}"
    @openNewWindow(url)

  removeUserArticles: ->
    UserActions.removeArticles(@refs.selectableList.getSelected()).then =>
      flash('success', @t('on_remove', searches_count: @refs.selectableList.getSelected().length))
      @setState(selected: [])

  emailArticles: ->
    UserActions.emailArticles(@refs.selectableList.getSelected()).then =>
      email = UserStore.state.user.email
      count = @refs.selectableList.getSelected().length
      flash('success', @t('on_email', email: email, documents_count: count))

  toggleSelectAll: ->
    @refs.selectableList.toggleSelectAll()

  loadMore: (page) ->
    @props.onLoadMore?(page)

  hasMore: ->
    @props.resultsCount > 0 and @props.resultsCount > @props.results.length

  hasSelectedItems: ->
    @refs.selectableList.hasSelectedItems()

  renderList: ->
    if @props.results.length == 0
      return <p className="no-results">{@t('no_results')}</p>

    for result, i in @props.results
      selected = !!_.findWhere(@refs.selectableList?.getSelected(), id: result.id)
      <ResultItem {...@props} result={result} resultNumber={i + 1} key="result-#{i}-#{selected}" selected={selected} onSelectToggle={@onSelectToggle} />

  render: ->
    <SelectableList ref="selectableList" items={@props.results} className="result-list">
      {@renderList()}
    </SelectableList>
