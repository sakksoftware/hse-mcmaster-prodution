TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: "SelectableItem"

  mixins: [TranslationHelper]
  baseTranslation: 'saved_search_page'

  propTypes:
    className: React.PropTypes.string

  render: ->
    <li  className="selectable-item #{@props.className}">
      <label className="result-item-select">{@t('/select')}
        <input type="checkbox" onChange={@props.toggleSelect} checked={@props.selected} />
      </label>
      {@props.children}
    </li>
