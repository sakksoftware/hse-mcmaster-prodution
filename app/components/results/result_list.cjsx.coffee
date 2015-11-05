ResultItem = require('components/results/result_item')
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

  getInitialState: ->
    selected: []

  # TODO: duplicate logic between saved_search, saved_articles and result_list
  onSelectToggle: (article) ->
    selected = _.clone @state.selected
    if found = _.findWhere(selected, id: article.id)
      selected = _(selected).without(found)
    else
      selected.push(article)

    @setState(selected: selected)

    @props.onSelectToggle(article)

  toggleSelectAll: (ev) ->
    selected = @props.results
    allSelected = false

    if @state.selected.length > 0
      selected = []
      allSelected = false
    else
      allSelected = true

    @setState(selected: selected, allSelected: allSelected)

  saveArticles: ->
    UserActions.saveArticles(@state.selected).then =>
      flash('success', @t('on_save', documents_count: @state.selected.length))

  openNewWindow: (csvContent) ->
    encodedUri = encodeURI(csvContent)
    window.open(encodedUri)

  exportArticles: ->
    ids = _.pluck(@state.selected, 'id')
    url = "#{config.apiBase}/api/user/articles.csv?ids=#{encodeURIComponent(ids.join(';'))}"
    @openNewWindow(url)

  removeUserArticles: ->
    UserActions.removeArticles(@state.selected).then =>
      flash('success', @t('on_remove', searches_count: @state.selected.length))
      @setState(selected: [])

  emailArticles: ->
    UserActions.emailArticles(@state.selected).then =>
      email = UserStore.state.user.email
      count = @state.selected.length
      flash('success', @t('on_email', email: email, documents_count: count))

  loadMore: (page) ->
    @props.onLoadMore?(page)

  hasMore: ->
    @props.resultsCount > 0 and @props.resultsCount > @props.results.length

  renderList: ->
    if @props.results.length == 0
      return <p className="no-results">{@t('no_results')}</p>

    for result, i in @props.results
      selected = !!_.findWhere(@state.selected, id: result.id)
      <ResultItem {...@props} result={result} resultNumber={i + 1} key="result-#{i}-#{selected}" selected={selected} onSelectToggle={@onSelectToggle} />


  render: ->
    <ol className="result-list">
      {@renderList()}
    </ol>
