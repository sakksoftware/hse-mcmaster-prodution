Link = require('components/shared/link')
ApplicationHelper = require('mixins/application_helper')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'ResultItem'

  mixins: [ApplicationHelper, TranslationHelper]
  baseTranslation: 'search_page.result_item'

  propTypes:
    resultNumber: React.PropTypes.number.isRequired
    result: React.PropTypes.object.isRequired

  shortRating: (quality) ->
    if match = quality?.match(/[0-9]{1,2}\/[0-9]{1,2}/)
      return match
    quality

  render: ->
    <li className="result-item">
      <header className="result-item-header">
        <div className="result-item-header-left">
          <span className="result-item-number">{@props.resultNumber}.</span>
          <div className="field result-item-published">
            <span className="field-name">{@t('year')}</span>
            <span className="field-value">{moment(@props.result.created_at).format('YYYY')}</span>
          </div>
          <div className="field result-item-quality">
            <span className="field-name">{@t('quality')}</span>
            <span className="field-value">{@shortRating(@props.result.quality)}</span>
          </div>
        </div>
        <div className="result-item-header-right">
          {@t('select')}<input type="radio" title="not yet implemented" disabled />
        </div>
      </header>
      <section className="result-item-description">
        <h2 className="result-item-title">
          <Link to={"/articles/#{@props.result.id}"}>{@props.result.title}</Link>
        </h2>
        <div className="result-item-categories">
          {@props.result.category} | {@props.result.country_groupings}
        </div>
        {@ellipsis(@props.result.description, 250)}
      </section>
    </li>
