SortOrder = require('components/results/sort_order')
ResultList = require('components/results/result_list')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'ResultBox'
  propTypes:
    sortBy: React.PropTypes.string.isRequired
    results: React.PropTypes.array.isRequired
    resultsCount: React.PropTypes.number.isRequired
    onLoadMore: React.PropTypes.func.isRequired
    onSortChange: React.PropTypes.func.isRequired

  mixins: [TranslationHelper]
  baseTranslation: 'search_page.result_box'

  render: ->
    <div className="result-box">
      <div className="result-box-header">
        <SortOrder sortBy={@props.sortBy} onChange={@props.onSortChange} />
        <div className="result-box-count">{@props.resultsCount} {@t('results')}</div>
      </div>
      <ResultList results={@props.results} resultsCount={@props.resultsCount} onLoadMore={@props.onLoadMore} />
    </div>
