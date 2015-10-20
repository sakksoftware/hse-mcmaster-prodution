SortOrder = require('components/results/sort_order')
ResultList = require('components/results/result_list')
TranslationHelper = require('mixins/translation_helper')
SavedSearchButtons = require('components/search/saved_search_buttons')

module.exports = React.createClass
  displayName: 'ResultBox'
  propTypes:
    search: React.PropTypes.object.isRequired
    sortBy: React.PropTypes.string.isRequired
    onLoadMore: React.PropTypes.func.isRequired
    onSortChange: React.PropTypes.func.isRequired

  mixins: [TranslationHelper]
  baseTranslation: 'search_page.result_box'

  render: ->
    <div className="result-box">
      <div className="result-box-header">
        <SortOrder sortBy={@props.sortBy} onChange={@props.onSortChange} />
        <div className="result-box-count">{@props.search.results_count} {@t('results')}</div>
      </div>
      <SavedSearchButtons search={@props.search} />
      <ResultList results={@props.search.results} resultsCount={@props.search.results_count} onLoadMore={@props.onLoadMore} />
    </div>
