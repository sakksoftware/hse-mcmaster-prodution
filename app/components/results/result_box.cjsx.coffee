SortOrder = require('components/results/sort_order')
ResultList = require('components/results/result_list')

module.exports = React.createClass
  displayName: 'ResultBox'
  propTypes:
    results: React.PropTypes.array.isRequired

  render: ->
    <div className="result-box">
      <SortOrder />
      <ResultList results={@props.results} />
    </div>