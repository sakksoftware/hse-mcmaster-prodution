SortOrder = require('components/results/sort_order')
ResultList = require('components/results/result_list')

module.exports = React.createClass
  displayName: 'ResultBox'
  propTypes:
    results: React.PropTypes.array.isRequired
    onSortChange: React.PropTypes.func.isRequired

  render: ->
    <div className="result-box">
      <SortOrder onChange={@props.onSortChange} />
      <ResultList results={@props.results} />
    </div>