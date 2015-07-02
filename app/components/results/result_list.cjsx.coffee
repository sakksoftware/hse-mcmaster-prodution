ResultItem = require('components/results/result_item')

module.exports = React.createClass
  displayName: 'ResultList'
  propTypes:
    results: React.PropTypes.array.isRequired

  renderList: ->
    for result, i in @props.results
      <ResultItem result={result} key="result-#{i}" />

  render: ->
    <div className="result-list">
      {@renderList()}
    </div>