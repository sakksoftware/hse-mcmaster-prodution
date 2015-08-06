Link = require('components/shared/link')

module.exports = React.createClass
  displayName: 'ResultItem'
  propTypes:
    result: React.PropTypes.object.isRequired

  render: ->
    <article className="result-item">
      <header className="result-item-header">
        <div className="result-item-header-left">
          <h2 className="result-item-title">
            <Link to={"/articles/#{@props.result.id}"}>{@props.result.title}</Link>
          </h2>
          <p className="result-item-category">{@props.result.category}</p>
        </div>
        <div className="result-item-header-right">
          <p className="result-item-created">{moment(@props.result.created_at).format('MMM D, YYYY')}</p>
          <p className="result-item-quality">quality {@props.result.quality}/10</p>
        </div>
      </header>
      <section className="result-item-description">
        {@props.result.description}
      </section>
    </article>
