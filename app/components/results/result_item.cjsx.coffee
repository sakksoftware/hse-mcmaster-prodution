Link = require('components/shared/link')

module.exports = React.createClass
  displayName: 'ResultItem'
  propTypes:
    resultNumber: React.PropTypes.number.isRequired
    result: React.PropTypes.object.isRequired

  render: ->
    <li className="result-item">
      <header className="result-item-header">
        <div className="result-item-header-left">
          <span className="result-item-number">{@props.resultNumber}.</span>
          <div className="field result-item-published">
            <span className="field-name">Year:</span>
            <span className="field-value">{moment(@props.result.created_at).format('YYYY')}</span>
          </div>
          <div className="field result-item-quality">
            <span className="field-name">Quality:</span>
            <span className="field-value">{@props.result.quality}/10</span>
          </div>
        </div>
        <div className="result-item-header-right">
          Select: <input type="radio" title="not yet implemented" disabled />
        </div>
      </header>
      <section className="result-item-description">
        <h2 className="result-item-title">
          <Link to={"/articles/#{@props.result.id}"}>{@props.result.title}</Link>
        </h2>
        <div className="result-item-categories">
          {@props.result.category}
        </div>
        {@props.result.description}
      </section>
    </li>
