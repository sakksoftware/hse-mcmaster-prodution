ResultItem = require('components/results/result_item')

module.exports = React.createClass
  displayName: 'ResultList'
  propTypes:
    results: React.PropTypes.array.isRequired

  renderList: ->
    if @props.results.length == 0
      return <p className="no-results">No results found.</p>

    for result, i in @props.results
      <ResultItem result={result} key="result-#{i}" />

  render: ->
    <div className="result-list">
      {@renderList()}
    </div>