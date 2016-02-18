Link = require('components/shared/link')
HighlightFormat = require('components/shared/highlight_format')
SelectableItem = require('components/shared/selectable_item')

ApplicationHelper = require('mixins/application_helper')
TranslationHelper = require('mixins/translation_helper')

UserStore = require('stores/user_store')

module.exports = React.createClass
  displayName: 'ResultItem'

  mixins: [ApplicationHelper, TranslationHelper]
  baseTranslation: 'search_page.result_item'

  propTypes:
    resultNumber: React.PropTypes.number.isRequired
    result: React.PropTypes.object.isRequired
    source: React.PropTypes.string
    toggleSelect: React.PropTypes.func

  getDefaultProps: ->
    showSelect: false
    selected: false
    source: 'search'

  shortRating: (quality) ->
    if match = quality?.match(/[0-9]{1,2}\/[0-9]{1,2}/)
      match
    else
      @t('not_available')

  getStudiesConductedIn: ->
    @props.result.studies_conducted_in.countries.map((c) ->
      name = c.name_abbreviation
      name = c.title if _.isEmpty(name)
      if c.conducted_count && c.conducted_count != "0" && c.conducted_count != "null"
        "#{name} (#{c.conducted_count})"
      else
        name
    ).join('; ')

  render: ->
    <SelectableItem {...@props} showSelect={false} className="result-item">
      <header className="result-item-header">
        <div className="result-item-header-left">
          <span className="result-item-number">{@props.resultNumber}.</span>
          <div className="field result-item-published">
            <span className="field-name">{@t('year')}</span>
            <span className="field-value">{@props.result.year || @t('/articles_page.no_last_year_literature_searched')}</span>
          </div>
          <div className="field result-item-quality">
            <span className="field-name">{@t('quality')}</span>
            <span className="field-value">{@shortRating(@props.result.quality)}</span>
          </div>
        </div>
        <div className="result-item-header-right action">
          {
            if UserStore.isLoggedIn()
              <label className="result-item-select">{@t('/select')}<input type="checkbox" onChange={=> @props.toggleSelect(@)} checked={@props.selected} /></label>
          }
        </div>
      </header>
      <section className="result-item-description">
        <h2 className="result-item-title">
          <Link to={["/articles/#{@props.result.id}", t: @props.result.traversal, source: @props.source]}><HighlightFormat>{@props.result.title}</HighlightFormat></Link>
        </h2>
        <div className="result-item-categories">
          {
            if @props.result.category
              <HighlightFormat>{@props.result.category}</HighlightFormat>
          }
          {
            if @props.result.studies_conducted_in
              <HighlightFormat>{@getStudiesConductedIn()}</HighlightFormat>
          }
        </div>
        <HighlightFormat>{@ellipsis(@props.result.description, 250)}</HighlightFormat>
      </section>
    </SelectableItem>
