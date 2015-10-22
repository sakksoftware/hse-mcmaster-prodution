ResultItem = require('components/results/result_item')
TranslationHelper = require('mixins/translation_helper')
InfiniteScroll = require('mixins/infinite_scroll')

UserActions = require('actions/user_actions')

module.exports = React.createClass
  displayName: 'ResultList'

  mixins: [TranslationHelper, InfiniteScroll]
  baseTranslation: 'search_page.result_list'

  propTypes:
    results: React.PropTypes.array.isRequired
    resultsCount: React.PropTypes.number.isRequired
    onLoadMore: React.PropTypes.func

  defaultProps: ->
    onLoadMore: ->

  getInitialState: ->
    selectedArticles: []

  onSelectToggle: (article) ->
    selectedArticles = _.clone @state.selectedArticles
    if selectedArticle = _.findWhere(selectedArticles, id: article.id)
      selectedArticles = _.reject selectedArticles, (a) -> a.id == selectedArticle.id
    else
      selectedArticles.push(article)

    @setState(selectedArticles: selectedArticles)

  saveArticles: ->
    UserActions.saveArticles(@state.selectedArticles).then =>
      flash('success', 'saved articles')

  loadMore: (page) ->
    @props.onLoadMore(page)

  hasMore: ->
    @props.resultsCount > 0 and @props.resultsCount > @props.results.length

  renderList: ->
    if @props.results.length == 0
      return <p className="no-results">{@t('no_results')}</p>

    for result, i in @props.results
      <ResultItem result={result} resultNumber={i + 1} key="result-#{i}" onSelectToggle={@onSelectToggle} />

  render: ->
    <ol className="result-list">
      {@renderList()}
    </ol>
