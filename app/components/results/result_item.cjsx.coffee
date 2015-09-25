Link = require('components/shared/link')
HighlightFormat = require('components/shared/highlight_format')
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
      match
    else
      @t('not_available')

  render: ->
    <li className="result-item">
      <header className="result-item-header">
        <div className="result-item-header-left">
          <span className="result-item-number">{@props.resultNumber}.</span>
          <div className="field result-item-published">
            <span className="field-name">{@t('year')}</span>
            <span className="field-value">{@props.result.pub_year}</span>
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
          <Link to={"/articles/#{@props.result.id}?t=#{@props.result.traversal}"}><HighlightFormat>{@props.result.title}</HighlightFormat></Link>
        </h2>
        <div className="result-item-categories">
          <HighlightFormat>{@props.result.category}</HighlightFormat> | <HighlightFormat>{@props.result.country_groupings}</HighlightFormat>
        </div>
        <HighlightFormat>{@ellipsis(@props.result.description, 250)}</HighlightFormat>
      </section>
    </li>
