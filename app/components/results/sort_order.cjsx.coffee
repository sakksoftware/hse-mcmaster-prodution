TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'SortOrder'

  mixins: [TranslationHelper]
  baseTranslation: 'search_page.sort_order'

  propTypes:
    sortBy: React.PropTypes.string.isRequired
    onChange: React.PropTypes.func.isRequired

  handleChange: (e) ->
    @props.onChange(e.target.value)

  render: ->
    <div className="sort-order">
      <span className="sort-order-label">{@t('sorted_by')}</span>
      <select className="sort-order-control" onChange={@handleChange} defaultValue={@props.sortBy}>
        <option value="relevance">{@t('relevance')}</option>
        <option value="most_recent">{@t('most_recent')}</option>
        <option value="most_popular">{@t('most_popular')}</option>
      </select>
    </div>
