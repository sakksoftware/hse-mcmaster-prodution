SortOrder = require('components/results/sort_order')
ResultList = require('components/results/result_list')

module.exports = React.createClass
  displayName: 'ResultBox'
  propTypes:
    sortBy: React.PropTypes.string.isRequired
    results: React.PropTypes.array.isRequired
    onSortChange: React.PropTypes.func.isRequired

  render: ->
    <div className="result-box">
      <SortOrder sortBy={@props.sortBy} onChange={@props.onSortChange} />
      <ResultList results={@props.results} />
    </div>