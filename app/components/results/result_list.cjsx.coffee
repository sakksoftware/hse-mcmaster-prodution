ResultItem = require('components/results/result_item')
TranslationHelper = require('mixins/translation_helper')
InfiniteScroll = require('mixins/infinite_scroll')

module.exports = React.createClass
  displayName: 'ResultList'

  mixins: [TranslationHelper, InfiniteScroll]
  baseTranslation: 'search_page.result_list'

  propTypes:
    results: React.PropTypes.array.isRequired
    resultsCount: React.PropTypes.number.isRequired
    onLoadMore: React.PropTypes.func.isRequired

  loadMore: (page) ->
    @props.onLoadMore(page)

  hasMore: ->
    @props.resultsCount > 0 and @props.resultsCount > @props.results.length

  renderList: ->
    if @props.results.length == 0
      return <p className="no-results">{@t('no_results')}</p>

    for result, i in @props.results
      <ResultItem result={result} resultNumber={i + 1} key="result-#{i}" />

  render: ->
    <ol className="result-list">
      {@renderList()}
    </ol>
