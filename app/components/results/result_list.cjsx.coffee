ResultItem = require('components/results/result_item')

module.exports = React.createClass
  displayName: 'ResultList'
  propTypes:
    results: React.PropTypes.array.isRequired

  renderList: ->
    if @props.results.length == 0
      return <p className="no-results">No results found.</p>

    for result, i in @props.results
      <ResultItem result={result} resultNumber={i + 1} key="result-#{i}" />

  render: ->
    <ol className="result-list">
      {@renderList()}
    </ol>
